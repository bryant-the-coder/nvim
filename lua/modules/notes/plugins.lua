local conf = require("modules.notes.config")
local notes = require("utils.pack").package

notes({
    "nvim-neorg/neorg",
    lazy = false,
    run = ":Neorg sync-parsers", -- This is the important bit!
    -- cmd = "Neorg",
    -- ft = "norg",
    config = conf.neorg,
})
