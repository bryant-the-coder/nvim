local ui = require("utils.pack").package
local conf = require("modules.ui.config")

ui({
    "rcarriga/nvim-notify",
    lazy = true,
    config = conf.notify,
})

ui({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    -- event = "VeryLazy",
    cmd = { "Neotree", "NeoTreeShow", "NeoTreeFocus", "NeoTreeFocusToggle" },
    config = conf.neo_tree,
})

ui({
    enabled = false,
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly",
    config = conf.nvim_tree,
})

ui({
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    main = "ibl",
    init = function()
        require("custom.load").lazy_load("indent-blankline.nvim")
    end,
    config = conf.blankline,
})

ui({
    enabled = false,
    "rareitems/hl_match_area.nvim",
    lazy = true,
    event = "VeryLazy",
    config = conf.hl_area,
})

ui({
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = conf.fidget,
})

ui({
    "rebelot/heirline.nvim",
    config = conf.heirline,
})

ui({
    enabled = false,
    "utilyre/barbecue.nvim",
    version = "*",
    after = "nvim-lspconfig",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = conf.barbecue,
})
