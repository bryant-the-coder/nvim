require "bryant.core.settings"
require "bryant.core.mappings"
require "bryant.core.modules"
require "bryant.core.autocommands"
require "bryant.modules.ui.theme"
require "bryant.custom.statusline"
require "bryant.custom.overrides"
require "bryant.custom.abbrev"

--[[ vim.g.ts_highlight_lua = true
local colorscheme_path = vim.fn.stdpath "cache" .. "/omega/highlights"
if not vim.loop.fs_stat(colorscheme_path) then
    require("omega.colors").compile_theme "onedark"
end
loadfile(colorscheme_path)() ]]
