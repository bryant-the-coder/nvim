local conf = require "modules.completion.config"
local completion = require("utils.pack").package

completion {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    -- after = { "LuaSnip" },
    lazy = true,
    dependencies = {
        {
            "saadparwaiz1/cmp_luasnip",
            after = { "nvim-cmp" },
        },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        {
            "petertriho/cmp-git",
            after = "nvim-cmp",
            config = conf.cmp_git,
        },
    },
    config = conf.cmp,
}

completion {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            lazy = true,
            "hrsh7th/nvim-cmp",
        },
    },
    config = function()
        require "modules.completion.snippets"
    end,
}

completion {
    enabled = false,
    "windwp/nvim-autopairs",
    event = {
        "InsertEnter",
        -- for working with cmp
        "CmdLineEnter",
    },
    after = "nvim-cmp",
    config = conf.nvim_autopairs,
}

completion {
    enabled = false,
    "altermo/ultimate-autopair.nvim",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = conf.autopair(),
}
