local colorscheme = require("utils.pack").package

colorscheme({
    "bryant-the-coder/base16",
    lazy = false,
    priority = 1000,
    config = function()
        local base16 = require("base16")
        local theme = vim.g.colors_name
        return base16(base16.themes(theme))
    end,
})

colorscheme({
    enabled = false,
    "NTBBloodbath/sweetie.nvim",
    config = function()
        vim.cmd.colorscheme("sweetie")
    end,
})

return colorscheme
