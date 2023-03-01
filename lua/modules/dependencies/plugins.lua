local dep = require("utils.pack").package
local conf = require("modules.dependencies.config")

dep({
    "nvim-lua/plenary.nvim",
    lazy = true,
})

dep({
    "kyazdani42/nvim-web-devicons",
    config = conf.devicons,
})

dep({
    "MunifTanjim/nui.nvim",
    lazy = true,
    event = "VeryLazy",
})

return dep
