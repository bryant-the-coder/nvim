local present, devicons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

local options = require("bryant.custom.icons").devicons

devicons.setup(options)
