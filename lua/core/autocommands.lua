local api = vim.api
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

-----------------------------------
--            BUILTIN            --
-----------------------------------
-- Disable autocommenting
-- Who likes autocommenting anyways?
cmd("BufEnter", {
    desc = "Disable autocommenting in new lines",
    command = "set fp-=c fo-=r fo-=o",
})

-- Terminal
augroup("_terminal", {})
cmd("TermOpen", {
    desc = "Terminal settings",
    group = "_terminal",
    command = "startinsert",
})
cmd("TermOpen", {
    desc = "Terminal settings",
    group = "_terminal",
    command = "setlocal nonumber norelativenumber",
})

cmd("FileType", {
    pattern = "norg",
    callback = function()
        vim.opt.number = false
        vim.opt.cole = 1
        vim.opt.foldlevel = 10
        vim.opt.signcolumn = "yes:2"
    end,
})

-- Setting plaintex to tex in order for it to work
cmd("FileType", {
    pattern = "plaintex",
    callback = function()
        vim.bo.ft = "tex"
    end,
})

-- Auto resize panes
cmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

augroup("_buffer", {})
-- Cursor position
cmd("BufReadPost", {
    desc = "Restore cursor position upon reopening the file",
    group = "_buffer",
    command = [[
       if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
    ]],
})

-- Highlight while yanking
cmd("TextYankPost", {
    pattern = "*",
    desc = "Highlight while yanking",
    group = "_buffer",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
    end,
})

-- q as an escape key
cmd("FileType", {
    desc = "Quit with q in this filetypes",
    group = "_buffer",
    pattern = "qf,help,man,lspinfo,startuptime,Trouble",
    callback = function()
        vim.keymap.set("n", "q", "<CMD>close<CR>")
    end,
})

-- Quickfix mappings
cmd("FileType", {
    desc = "Quit with q in this filetypes",
    group = "_buffer",
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", ";j", "<CMD>cn<CR>")
        vim.keymap.set("n", ";k", "<CMD>cp<CR>")
    end,
})

-----------------------------------
--            CUSTOM             --
-----------------------------------
-- Custom dashboard display
--[[ cmd({ "VimEnter" }, {
    callback = function()
        require("custom.dashboard").display()
    end,
}) ]]
-- If filetype is dashboard then do not show statusline
cmd("FileType", {
    pattern = "dashboard",
    callback = function()
        vim.opt.laststatus = 0
        vim.opt.list = false
    end,
})
-- Other filetype, show statusline
cmd("BufUnload", {
    buffer = 0,
    callback = function()
        vim.opt.laststatus = 3
        vim.opt.list = true
    end,
})

cmd({ "TabEnter", "BufEnter", "WinEnter" }, {
    callback = function()
        vim.opt.statusline = "%!v:lua.require'custom.statusline'.run()"
    end,
})

cmd({ "WinEnter", "FileType" }, {
    pattern = {
        "NetrwTreeListing",
        "TelescopePrompt",
        "gitcommit",
        "gitdiff",
        "help",
        "packer",
        "startify",
        "netrw",
        "terminal",
    },
    callback = function()
        vim.opt.statusline = "%#StatusLine#" -- Disable statusline
    end,
})

-----------------------------------
--             PLUGINS           --
-----------------------------------
augroup("_lsp", {})

-- Nofity when file changes
augroup("_auto_reload_file", {})
cmd("FileChangedShellPost", {
    desc = "Actions when the file is changed outside of Neovim",
    group = "_auto_reload_file",
    callback = function()
        vim.notify("File changed, reloading the buffer", "error", { title = "Buffer changed", icon = "勒" })
    end,
})
cmd({ "FocusGained", "CursorHold" }, {
    desc = "Actions when the file is changed outside of Neovim",
    group = "_auto_reload_file",
    command = [[if getcmdwintype() == '' | checktime | endif]],
})
cmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        -- vim.lsp.semantic_tokens.stop(bufnr, args.data.client_id)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
