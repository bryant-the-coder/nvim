local conf = require "modules.notes.config"
local notes = require("utils.pack").package

notes {
   "nvim-neorg/neorg",
        lazy = true,
        ft = "norg",
        cmd = "Neorg",
        config = function()
            require("modules.notes.neorg")
        end
}
