local conf = require "modules.lang.config"
local lang = require("utils.pack").package

lang {
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
}

lang {
    "mfussenegger/nvim-dap",
    lazy = true,
    --[[ config = function()
        require "modules.tools.dap"
    end, ]]
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
    },
}

lang {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = conf.dap_ui,
}

lang {
    "mfussenegger/nvim-dap-python",
    after = "nvim-dap",
    config = conf.dap_py,
}

lang {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    config = conf.overseer,
}
