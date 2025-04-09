local conf = require("modules.completion.config")
local completion = require("utils.pack").package

completion({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    -- after = { "LuaSnip" },
    lazy = true,
    dependencies = {
        {
            "saadparwaiz1/cmp_luasnip",
            lazy = true,
        },
        { "hrsh7th/cmp-nvim-lsp", lazy = true },
        { "hrsh7th/cmp-buffer", lazy = true },
        { "hrsh7th/cmp-path", lazy = true },
        {
            "petertriho/cmp-git",
            lazy = true,
            config = conf.cmp_git,
        },
        { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
    },
    config = conf.cmp,
})

completion({
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            lazy = true,
            "hrsh7th/nvim-cmp",
        },
    },
    config = function()
        require("modules.completion.snippets")
    end,
})

completion({
    "windwp/nvim-autopairs",
    event = {
        "InsertEnter",
        -- for working with cmp
        "CmdLineEnter",
    },
    config = conf.nvim_autopairs,
})

completion({
    enabled = false,
    "altermo/ultimate-autopair.nvim",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = conf.autopair(),
})

completion({
    enabled = false,
    "zbirenbaum/copilot-cmp",
    config = function()
        require("copilot_cmp").setup()
    end,
})

completion({
    enabled = false,
    "onsails/lspkind.nvim",
    config = function()
        require("lspkind").init({
            -- DEPRECATED (use mode instead): enables text annotations
            --
            -- default: true
            -- with_text = true,

            -- defines how annotations are shown
            -- default: symbol
            -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode = "symbol_text",

            -- default symbol map
            -- can be either 'default' (requires nerd-fonts font) or
            -- 'codicons' for codicon preset (requires vscode-codicons font)
            --
            -- default: 'default'
            preset = "codicons",

            -- override preset symbols
            --
            -- default: {}
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            },
        })
    end,
})
