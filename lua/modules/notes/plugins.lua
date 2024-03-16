local conf = require("modules.notes.config")
local notes = require("utils.pack").package

--[[ notes({
    enabled = true,
    "nvim-neorg/neorg",
    lazy = false,
    run = ":Neorg sync-parsers", -- This is the important bit!
    cmd = "Neorg",
    ft = "norg",
    config = conf.neorg,
}) ]]

notes({
    "vhyrro/luarocks.nvim",
    config = function()
        require("luarocks").setup({})
    end,
})

notes({
    "nvim-neorg/neorg",
    branch = "luarocks",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    cmd = "Neorg",
    ft = "norg",
    config = conf.neorg,
})
