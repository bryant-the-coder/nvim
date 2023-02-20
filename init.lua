require "core.settings"
require "core.modules"
require "core.autocommands"
require "core.theme"
require "custom.overrides"
require "custom.abbrev"
vim.defer_fn(function()
    require "core.mappings"
    require "custom.statusline"
end, 1)
