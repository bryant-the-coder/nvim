local conf = require("modules.latex.config")
local latex = require("utils.pack").package

local filetype = { "latex", "tex" }

latex({
    "lervag/vimtex",
    lazy = true,
    ft = filetype,
    init = conf.vimtex,
})
