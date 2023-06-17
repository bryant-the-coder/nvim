local conf = require("modules.misc.config")
local latex = require("utils.pack").package

local filetype = { "latex", "tex" }

latex({
    "lervag/vimtex",
    enabled = false,
    lazy = true,
    ft = filetype,
    init = conf.vimtex,
})
