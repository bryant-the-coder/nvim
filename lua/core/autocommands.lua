local api = vim.api
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

-----------------------------------
--            BUILTIN            --
-----------------------------------
-- Disable autocommenting
-- Who likes autocommenting anyways?
cmd("FileType", {
    -- desc = "Disable autocommenting in new lines",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            + "r" -- continue comments after return
            + "c" -- wrap comments using textwidth
            + "q" -- allow to format comments w/ gq
            + "j" -- remove comment leader when joining lines when possible
            - "t" -- don't autoformat
            - "a" -- no autoformatting
            - "o" -- don't continue comments after o/O
            - "2" -- don't use indent of second line for rest of paragraph
    end,
    desc = "Set formatoptions",
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

-- code from lazyvim
-- Cursor position
-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "_buffer",
    callback = function()
        local exclude = { "gitcommit" }
        local buf = vim.api.nvim_get_current_buf()
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
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

-- code from lazyvim
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = "_buffer",
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
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

--[[ cmd({ "TabEnter", "BufEnter", "WinEnter" }, {
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
}) ]]
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

cmd("CursorHold", {
    group = vim.api.nvim_create_augroup("lsp_float", {}),
    callback = function()
        vim.diagnostic.open_float()
    end,
})

-- code from lazyvim
augroup("auto_create_dir", {})
-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = "auto_create_dir",
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- CPP purposes
--------------------------------------------------------------------
---------------------- READ TO UNDERSTAND --------------------------
--------------------------------------------------------------------
--- Function to open a new terminal (vertical / horizontal)
--- While starting in INSERT mode
local function TermWrapper(command)
    if vim.g.split_term_style == nil then
        vim.g.split_term_style = "vertical"
    end

    local buffercmd
    if vim.g.split_term_style == "vertical" then
        buffercmd = "vnew"
    elseif vim.g.split_term_style == "horizontal" then
        buffercmd = "new"
    else
        error(
            'ERROR! g:split_term_style is not a valid value (must be "horizontal" or "vertical" but is currently set to "'
            .. vim.g.split_term_style
            .. '")'
        )
    end

    vim.cmd(buffercmd)

    if vim.g.split_term_resize_cmd ~= nil then
        vim.cmd(vim.g.split_term_resize_cmd)
    end

    vim.cmd("term " .. command)
    vim.cmd("setlocal nornu nonu")
    vim.cmd("startinsert")
    vim.api.nvim_create_autocmd("BufEnter", {
        buffer = 0,
        command = "startinsert",
    })
end

-- Invoke a command
-- Runs g++ and compile it into exe
-- After compile, runs the exe
vim.api.nvim_create_user_command("CompileAndRun", function()
    local fileName = vim.fn.expand("%")
    local exeName = fileName:gsub("%.cpp$", "")
    TermWrapper("g++ -std=c++11 -o " .. exeName .. " " .. fileName .. " && ./" .. exeName)
end, {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    command = "nnoremap <leader>fc :CompileAndRun<CR>",
})

-- Same as above but theres an input file (use it thru command line)
vim.api.nvim_create_user_command("CompileAndRunWithFile", function(args)
    TermWrapper("g++ -std=c++11 " .. vim.fn.expand("%") .. " && ./a.out < " .. args.args)
end, {
    nargs = 1,
    complete = "file",
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    command = "nnoremap <leader>fr :CompileAndRunWithFile<CR>",
})

augroup("json_conceal", {})
-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "json_conceal",
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})
