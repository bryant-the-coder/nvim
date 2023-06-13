local conf = require("modules.misc.config")
local latex = require("utils.pack").package

local filetype = { "latex", "tex" }

latex({
    "lervag/vimtex",
    lazy = true,
    ft = filetype,
    init = conf.vimtex,
})
