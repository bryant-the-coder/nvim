local dep = require("utils.pack").package
local conf = require("modules.dependencies.config")

dep({
    "nvim-lua/plenary.nvim",
    lazy = true,
})

dep({
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    config = conf.devicons,
})

dep({
    "MunifTanjim/nui.nvim",
    lazy = true,
    event = "VeryLazy",
})

return dep
