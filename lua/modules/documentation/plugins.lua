local conf = require("modules.documentation.config")
local docs = require("utils.pack").package

docs({
    "danymat/neogen",
    -- lazy = true,
    cmd = { "Neogen" },
    dependencies = { "L3MON4D3/LuaSnip" },
    config = conf.neogen,
})

docs({
    enabled = false,
    "romainl/vim-devdocs",
    cmd = { "DD" },
    lazy = true,
})

docs({
    enabled = true,
    "lalitmee/browse.nvim",
    lazy = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = conf.browse,
})
