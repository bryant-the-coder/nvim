local conf = require "modules.tools.config"
local tools = require("utils.pack").package

tools {
    "rktjmp/paperplanes.nvim",
    lazy = true,
    cmd = { "PP" },
    config = true,
}

tools {
    "natecraddock/workspaces.nvim",
    event = "VeryLazy",
    config = conf.woekspaces,
}

tools {
    "akinsho/toggleterm.nvim",
    keys = { "<c-t>", "<leader>tg" },
    config = function()
        require "modules.tools.toggleterm"
    end,
}

tools {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = conf.colorizer,
}
