require("core.disable_builtin")
local utils = require("core.utils")
local config = require("core.default_config")

local g = vim.g
local o = vim.opt

-- local themes = utils.timer_theme()

g.colors_name = config.ui.theme
g.tmux_navigator_no_mappings = true

--Cursor & cursorline
o.cursorline = true
o.cursorlineopt = { "number" } -- Highlighting the number where the cursor is on
vim.opt.stl = " "

-- Mappings
g.mapleader = ","
g.maplocalleader = " "
o.mouse = "a"
o.mousemoveevent = true

-- Theme
o.termguicolors = true

-- Command line
o.shortmess:append("I")
o.cmdheight = 1
o.hidden = true
o.history = 300
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

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true -- Don't ignore when uppercase search

-- Statusline
-- o.laststatus = 3

-- Conceal
o.conceallevel = 2

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Syntax
-- Set C syntax for '.h' header files (default is C++)
vim.g.c_syntax_for_h = true

-- Enable bundled tree-sitter parser for Lua
vim.g.ts_highlight_lua = true

vim.defer_fn(function()
    o.updatetime = 200
    -- Editor
    o.wrap = false
    o.clipboard = "unnamedplus"
    o.foldmethod = "marker"
    o.completeopt = "menuone,noselect,menu"
    o.lazyredraw = true

    -- Splits
    o.splitright = true
    o.splitbelow = true

    o.showmatch = true -- Shows show match

    -- See :h fillchars
    o.fillchars = {
        eob = " ",
        vert = "┃", -- ║
        horiz = "━", -- ═
        horizup = "┻", -- ╩
        horizdown = "┳", -- ╦
        vertleft = "┫", -- ╣
        vertright = "┣", -- ╠
        verthoriz = "╋", -- ╬
        stl = " ",
        stlnc = " ",
    }
    o.listchars = {
        trail = "·",
        eol = "↲",
        tab = "  ",
    }

    o.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
    -- o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor-blinkwait300-blinkon500-blinkoff300,r-cr-o:hor20"
    o.guifont = "Operator Mono SSm Lig Book:h9"

    -- Number
    o.number = true
    o.relativenumber = true
    o.signcolumn = "yes:2"
    o.scrolloff = 1000 -- Stop scrolling on the number set
end, 1)

-- Backups / Undo
--[[ o.backup = false -- Don't backup files
o.writebackup = false -- Don't write backup
o.undofile = false -- Don't write undofile
o.swapfile = false -- Don't write swapfile ]]
