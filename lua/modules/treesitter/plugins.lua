local conf = require("modules.treesitter.config")
local ts = require("utils.pack").package

ts({
    "nvim-treesitter/nvim-treesitter",
    init = function()
        require("custom.load").lazy_load("nvim-treesitter")
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = conf.nvim_treesitter,
})

-- Vscode like rainbow parenthesis
ts({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
})

ts({
    enabled = false,
    "HiPhish/nvim-ts-rainbow2",
    after = "nvim-treesitter",
})

-- Auto complete tag
ts({
    enabled = false,
    "windwp/nvim-ts-autotag",
    -- ft = { "html", "typescript", "javascripts", "javascriptreact" },
})

ts({
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
})

ts({
    "lewis6991/nvim-treesitter-context",
    -- after = "nvim-treesitter",
    ft = { "rust", "python" },
    opt = {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    },
})

return ts
