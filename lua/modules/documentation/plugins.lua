local conf = require("modules.documentation.config")
local docs = require("utils.pack").package

docs({
    "danymat/neogen",
    lazy = true,
    dependencies = { "L3MON4D3/LuaSnip" },
    config = conf.neogen,
})

docs({
    "romainl/vim-devdocs",
    cmd = { "DD" },
    lazy = true,
})

docs({
    "lalitmee/browse.nvim",
    lazy = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = conf.browse,
})
