local base16 = require("base16")

local theme = vim.g.colors_name
return base16(base16.themes(theme))
