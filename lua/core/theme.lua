local base16 = require("base16")

local theme = require("core.default_config").ui.theme
return base16(base16.themes(theme))

--[[ local time = os.date("*t")
local theme
local base16 = require("base16")

-- When its 7am or is equal or more than 9pm = onedark
if time.hour < 7 or time.hour <= 21 then
    theme = "everforest"
else
    theme = "onedark"
end

return base16(base16.themes(theme)) ]]
