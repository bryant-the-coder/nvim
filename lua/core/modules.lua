-- Bootstrapping
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim
require("lazy").setup("modules", {
    dev = {
        -- directory where you store your local plugin projects
        path = "~/dev/GITHUB/neovim_plugins",
    },
    default = {
        lazy = false,
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "mocha" },
    },
    performance = {
        rtp = {
            paths = {
                vim.fn.expand "~" .. "/.config/nvim",
            },
            disabled_plugins = {
                "loaded_python3_provider",
                "python_provider",
                "node_provider",
                "ruby_provider",
                "perl_provider",
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "tar",
                "tarPlugin",
                "rrhelper",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "logiPat",
                "netrwSettings",
                "netrwFileHandlers",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
                "load_ftplugin",
                "indent_on",
                "netrwPlugin",
                "tohtml",
                "man",
            },
        },
    },
    change_detection = {
        enabled = false,
    },
})
