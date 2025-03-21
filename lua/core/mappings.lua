--[[ map("n", "gcc", function() ]]
---@param lhs string Keymaps
---@param rhs string Command
---@param opts string Options
-- local function nimap(lhs, rhs, opts)
-- local default_options = { noremap = true, silent = true }
-- if opts then
--     default_options = vim.tbl_extend("force", default_options, opts)
-- end
-- vim.keymap.set({ "n", "i" }, lhs, rhs, default_options)
-- end

-- local nimap = require("core.utils").normal_insert()

local map = vim.keymap.set

map("n", "<leader>ta", [[<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[]])
-----------------------------------
--           BASIC               --
-----------------------------------
-- Quitting
map("n", "<C-q>", "<cmd>q<CR>")
map("i", "<C-c>", "<Esc>")

-- Buffer
map("n", "<leader>db", "<cmd>bdelete<CR>")

-- Pasting stuff
map("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

-- Folding
map("n", "<space>", "za")

-- Don't yank text upon delete (good mapping btw)
map("v", "d", '"_d"')

-- Don't yank text on cut
map("n", "x", '"_x')

-- ESC to clear all highlights
map({ "n", "i", "v" }, "<ESC>", "<cmd>noh<CR>")
-- map({ "n", "v" }, "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })

-- Running and exec files
map("n", "<leader>ex", "<cmd>call bryant#save_and_exec()<CR>")
map("n", "<leader>st", "<cmd>call bryant#terminal()<CR>")

-- Replace words with find and replace
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Saving the traditional way
map({ "n", "i" }, "<C-s>", "<Cmd>silent! write ++p<CR>")
-- nimap("<C-s>", "<cmd>w<CR>")
map("n", "<leader>sf", "<cmd>source % <CR>")

-- Expand the word and find for the word in help files
map("n", "<C-f>", function()
    vim.cmd(":vert :h " .. vim.fn.expand("<cword>"))
end, { noremap = true, silent = true, desc = "Open helpfile of word under cursor" })

--  j = gj
-- k = gk
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")

-- Indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

-- ESC key
map({ "i", "v" }, "jk", "<Esc>")
map({ "i", "v" }, "JK", "<ESC>")

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
--[[ map({ "n", "v" }, "j", "jzzzv")
map({ "n", "v" }, "k", "kzzzv") ]]
-- Disable arrow keys
map({ "n", "v" }, "<Up>", "<nop>")
map({ "n", "v" }, "<Down>", "<nop>")
map({ "n", "v" }, "<Left>", "<nop>")
map({ "n", "v" }, "<Right>", "<nop>")

-- Terminal ESC key
-- map("n", "<leader>vs", "<cmd>90 vsp | :term<CR>")
map("n", "<leader>vt", "<cmd>70 vsp | :term<CR>")
map("n", "<leader>h", "<cmd>17 sp | :term<CR>")
map("t", "jk", "<C-\\><C-n>")
map("t", "<Esc>", "<C-\\><C-n> <cmd>bd!<CR>")

-- Resize windows
map("n", "<A-up>", "<C-w>+")
map("n", "<A-down>", "<C-w>-")
map("n", "<A-left>", "<C-w>>")
map("n", "<A-right>", "<C-w><")

-- Window Navigation
map("", "<C-h>", "<C-w>h")
map("", "<C-k>", "<C-w>k")
map("", "<C-j>", "<C-w>j")
map("", "<C-l>", "<C-w>l")
map("", "<C-h>", "<cmd>silent! TmuxNavigateLeft<CR>")
map("", "<C-k>", "<cmd>silent! TmuxNavigateUp<CR>")
map("", "<C-j>", "<cmd>silent! TmuxNavigateDown<CR>")
map("", "<C-l>", "<cmd>silent! TmuxNavigateRight<CR>")

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprevious<CR>")

-- Moving lines up & down (complicated)
map("n", "<C-down>", "<cmd>m .+1<CR>==")
map("n", "<C-up>", "<cmd>m .-2<CR>==")
map("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv")
map("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv")

-- Insert a new line
-- Code from max
--[[ map("n", "<A-CR>", "O<ESC>", { desc = "Empty line above" })
map("n", "<CR>", "o<ESC>", { desc = "Empty line below" }) ]]
map("n", "<leader>lb", "i<CR><ESC>", { desc = "Line break at cursor" })
map("n", "<leader>il", "i <ESC>l", { desc = "Space before" })
map("n", "<leader>ih", "a <ESC>h", { desc = "Space after" })
map("n", "<F10>", function()
    if vim.o.conceallevel > 0 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end)

-- Wrting a file without a name
-- This will ask for the filename then write it
-- Credit: https://www.reddit.com/r/neovim/comments/xazxxe/comment/inwtkis/?utm_source=share&utm_medium=web2x&context=3
map("n", "<leader>w", function()
    local ok, res = pcall(vim.cmd, "write")
    if ok then
        return
    elseif res:match("^Vim%(write%):E32:") then
        ok, res = pcall(vim.fn.input, "File name: ")
        if ok and res and res ~= "" then
            vim.cmd("write " .. res)
        end
    else
        vim.api.nvim_err_writeln(res)
    end
end)

-----------------------------------
--           Utils               --
-----------------------------------
map("n", "<leader>sb", function()
    require("core.utils").swap_boolean()
end)

--[[ map("n", "<leader>sy", function()
    require("core.utils").swap_yes_no()
end) ]]
map("n", "<A-r>", function()
    require("core.utils").rename()
end)

map("n", "l", function()
    require("core.utils").l_motion()
end)
map("n", "h", function()
    require("core.utils").h_motion()
end)
map("n", "<leader>,", function()
    require("core.utils").insert_comma()
end)
map("n", ";;", function()
    require("core.utils").insert_semicolon()
end)

-----------------------------------
--           Plugins             --
-----------------------------------
-- Nvim-tree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

-- Lazy
map("n", "<leader>un", function()
    require("notify").dismiss()
end)

-- Noerg
map("n", "<leader>jt", "<cmd>Neorg journal today<CR>")

-- Neogit
map("n", "<leader>ng", "<cmd>Neogit<CR>")

-- Neo-tree
map("n", "<leader>nr", "<cmd>Neotree<CR>")
map("n", "<leader>nf", "<cmd>Neotree float<CR>")

-- Zen-mode
map("n", "<leader>zm", "<cmd>ZenMode<CR>")

-- Trouble
map("n", "<leader>tt", "<cmd>Trouble<CR>")

-- Neogen
-- map("n", "<leader>ng", "<cmd>Neogen<CR>")
--[[ map("n", "<leader>dd", function()
    require("neogen").generate()
end)
map("n", "<leader>dc", function()
    require("neogen").generate { type = "class" }
end)
map("n", "<leader>ds", function()
    require("neogen").generate { type = "type" }
end) ]]
-- TSPlayground
map("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>")
map("i", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

-- Cybu
map("n", "sk", "<Plug>(CybuPrev)")
map("n", "sj", "<Plug>(CybuNext)")

-- Lsp-Inlayhints
map("n", "<space>lh", function()
    require("lsp-inlayhints").toggle()
end)

-- Nvim-dap
-- See https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L419 for more info
map("n", "<leader>dc", function()
    require("dap").continue()
end)
map("n", "<leader>dso", function()
    require("dap").step_over()
end)
map("n", "<leader>dsi", function()
    require("dap").step_into()
end)
map("n", "<leader>dst", function()
    require("dap").step_out()
end)
map("n", "<leader>b", function()
    require("dap").toggle_breakpoint()
end)

-- Nvim-dap-ui
map("n", "<leader>dt", function()
    require("dapui").toggle()
end)

-- Lazy.nvim
map("n", "<leader>li", "<cmd>Lazy install<CR>")
map("n", "<leader>lu", "<cmd>Lazy update<CR>")
map("n", "<leader>lx", "<cmd>Lazy clean<CR>")
map("n", "<leader>ls", "<cmd>Lazy sync<CR>")
map("n", "<leader>pp", "<cmd>Lazy profile<CR>")

-- Lspsaga
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map("n", "<leader>lf", "<cmd>Lspsaga finder<CR>")
map("n", "<leader>lpd", "<cmd>Lspsaga peek_definition<CR>")
map("n", "<leader>lptd", "<cmd>Lspsaga peek_type_definition<CR>")
map({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

-- LSP
-- map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>lr", function()
    require("core.utils").open()
end)
map("n", "<leader>ld", vim.lsp.buf.definition)
map("n", "<leader>lt", vim.lsp.buf.type_definition)
map("n", "<leader>lh", vim.lsp.buf.signature_help)
map("n", "<leader>qf", vim.diagnostic.setqflist)
map("n", "<C-a>", vim.lsp.buf.references)
map("n", "[d", function()
    vim.diagnostic.goto_prev({ border = "rounded" })
end)
map("n", "]d", function()
    vim.diagnostic.goto_next({ border = "rounded" })
end)
map("n", "<leader>lq", vim.diagnostic.setloclist)
map("n", "<leader>lbh", function()
    require("core.utils").show_documentation()
end, { desc = "Show the documentation in a floating window" })

-- Harpooon
map("n", "<A-p>", function()
    require("harpoon.ui").toggle_quick_menu()
end)
map("n", "<A-=>", function()
    require("harpoon.mark").add_file()
end)
map("n", "<A-1>", function()
    require("harpoon.ui").nav_file(1)
end)
map("n", "<A-2>", function()
    require("harpoon.ui").nav_file(2)
end)
map("n", "<A-3>", function()
    require("harpoon.ui").nav_file(3)
end)
map("n", "<A-4>", function()
    require("harpoon.ui").nav_file(4)
end)

-- Telescope
map("n", "<leader>ff", function()
    require("modules.files.telescope").find_files()
    -- require("telescope.builtin").find_files()
end)
map("n", "<leader>fw", function()
    require("modules.files.telescope").live_grep()
    -- require("telescope.builtin").live_grep()
end)
map("n", "<leader>fd", function()
    require("modules.files.telescope").diag()
    -- require("telescope.builtin").diagnostics()
end)
--[[ map("n", "<C-p>", function()
    require("modules.files.telescope").buffers()
    -- require("telescope.builtin").buffers()
end) ]]
map("n", "<C-p>", "<cmd>FzfLua buffers<CR>")
map("n", "<leader>fc", function()
    require("telescope.builtin").colorscheme()
end)
map("n", "<leader>fo", function()
    require("telescope.builtin").oldfiles()
end)
map("n", "<leader>fk", function()
    require("telescope.builtin").keymaps()
end)
map("n", "<leader>fm", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end)
map("n", "<leader>ft", function()
    require("telescope.builtin").treesitter()
end)
map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>")
map("n", "<leader>ft", function()
    require("modules.files.telescope").harpoon()
end)
map("n", "<leader>pws", function()
    local builtin = require("telescope.builtin")
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end)
map("n", "<leader>ps", function()
    local builtin = require("telescope.builtin")
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        map("n", "<leader>qn", function()
            vim.cmd.cnext()
        end)
        map("n", "<leader>qp", function()
            vim.cmd.cprev()
        end)
        map("n", "<leader>qo", function()
            vim.cmd.copen()
        end)
    end,
})

--[[ map("n", "<leader>hh", require("hover").hover, { desc = "hover.nvim" })
map("n", "<leader>hs", require("hover").hover_select, { desc = "hover.nvim (select)" }) ]]

-- code from lazyvim
local utils = require("core.utils")

map("n", "<leader>gG", function()
    utils.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })
map("n", "<leader>tft", function()
    utils.float_term()
end)

map("n", "<leader>bis", function()
    require("browse").input_search()
end)
map("n", "<leader>bob", function()
    require("browse").open_bookmarks({ bookmarks = BOOKMARKS })
end)
map("n", "<leader>bb", function()
    require("browse").browse({ bookmarks = BOOKMARKS })
end)
map("n", "<leader>bds", function()
    require("browse.devdocs").search()
end)
map("n", "<leader>bdf", function()
    require("browse.devdocs").search_with_filetype()
end)
