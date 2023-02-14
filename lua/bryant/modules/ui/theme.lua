local base16 = require "base16"

-- Theme that I like:
-- A) onedark
-- B) kanagawa
-- C) everforest
-- D) mocha

-- TODO: might add a timer for theme
--[[ _G.theme = "everblush"

local theme = _G.theme ]]

local theme = vim.g.colors_name
return base16(base16.themes(theme))

-- vim.cmd [[colorscheme everblush]]
--[[ require("tokyonight").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
} ]]
