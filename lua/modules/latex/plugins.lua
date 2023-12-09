local conf = require("modules.latex.config")
local latex = require("utils.pack").package

local filetype = { "latex", "tex" }

latex({
    "lervag/vimtex",
    ft = filetype,
    lazy = true,
    init = conf.vimtex,
})
