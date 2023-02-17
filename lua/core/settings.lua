require "core.disable_builtin"
local utils = require "core.utils"
local config = require "core.default_config"

local g = vim.g
local o = vim.opt

-- local themes = utils.timer_theme()

g.colors_name = config.ui.theme

--Cursor & cursorline
o.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
-- o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor-blinkwait300-blinkon500-blinkoff300,r-cr-o:hor20"
o.cursorline = true
o.cursorlineopt = { "number" } -- Highlighting the number where the cursor is on

-- Mappings
g.mapleader = ","
o.mouse = "a"
o.mousemoveevent = true

-- Theme
o.termguicolors = true

-- Number
o.number = true
o.relativenumber = true
o.signcolumn = "yes:2"
o.scrolloff = 1000 -- Stop scrolling on the number set

-- Splits
o.splitright = true
o.splitbelow = true

-- Command line
o.shortmess:append "I"
o.cmdheight = 1
o.hidden = true
o.history = 300
o.updatetime = 200
o.smd = false -- Don't show mode in cmdline

-- Tabs & Indent
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.autoindent = true
o.smarttab = true
o.linebreak = true
o.breakindent = true

-- Editor
o.wrap = false
o.clipboard = "unnamedplus"
o.foldmethod = "marker"
o.completeopt = "menuone,noselect,menu"
o.lazyredraw = true

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.showmatch = true -- Shows show match
o.smartcase = true -- Don't ignore when uppercase search

-- Statusline
-- o.laststatus = 3
o.guifont = "Operator Mono SSm Lig Book:h9"

-- Conceal
o.conceallevel = 2

-- See :h fillchars
o.fillchars = {
    eob = " ",
    vert = "║",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    vertleft = "╣",
    vertright = "╠",
    verthoriz = "╬",
}
o.listchars = {
    trail = "·",
    eol = "↲",
}

-- Backups / Undo
--[[ o.backup = false -- Don't backup files
o.writebackup = false -- Don't write backup
o.undofile = false -- Don't write undofile
o.swapfile = false -- Don't write swapfile ]]

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

-- Syntax
-- Set C syntax for '.h' header files (default is C++)
vim.g.c_syntax_for_h = true

-- Enable bundled tree-sitter parser for Lua
vim.g.ts_highlight_lua = true

-- vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
-- vim.g.indent_blankline_filetype_exclude = {
--     "help",
--     "startify",
--     "dashboard",
--     "packer",
--     "neogitstatus",
--     "NvimTree",
--     "Trouble",
--     "norg",
--     "markdown",
-- }
-- vim.g.indentLine_enabled = 1
-- -- vim.g.indent_blankline_char = "│"
-- vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = false
-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {
--     "class",
--     "return",
--     "function",
--     "method",
--     "^if",
--     "^do",
--     "^switch",
--     "^while",
--     "jsx_element",
--     "^for",
--     "^object",
--     "^table",
--     "block",
--     "arguments",
--     "if_statement",
--     "else_clause",
--     "jsx_element",
--     "jsx_self_closing_element",
--     "try_statement",
--     "catch_clause",
--     "import_statement",
--     "operation_type",
-- }
