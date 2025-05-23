local conf = require("modules.lang.config")
local lang = require("utils.pack").package

lang({
    enabled = false,
    "folke/trouble.nvim",
    cmd = {
        "Trouble",
        "TroubleRefresh",
        "TroubleClose",
        "TroubleToggle",
    },
    --[[ config = function()
        require "modules.lang.trouble"
    end, ]]
    config = conf.trouble,
})

lang({
    enabled = true,
    "mfussenegger/nvim-dap",
    lazy = true,
    --[[ config = function()
        require "modules.tools.dap"
    end, ]]
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
    },
    config = conf.dap,
})

lang({
    enabled = true,
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
    },
    config = conf.dap_ui,
})

lang({
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
        ensure_installed = { "codelldb" },
        handlers = {},
    },
})

lang({
    enabled = true,
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = conf.dap_py,
})

lang({
    enabled = false,
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    config = conf.overseer,
})
