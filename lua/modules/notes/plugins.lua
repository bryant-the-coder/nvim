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
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
})

notes({
    "nvim-neorg/neorg",
    branch = "luarocks",
    dependencies = { "vhyrro/luarocks.nvim" },
    lazy = false,
    cmd = "Neorg",
    ft = "norg",
    config = conf.neorg,
})
