local Hydra = require "hydra"
local border = require("bryant.custom.border").styles.type_1

local harpoon_hint = [[
    ^ ^ _p_ : Toggle Harpoon   ^ ^
    ^ ^ _=_ : Harpoon add file ^ ^
    ^ ^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^ ^
    ^ ^ _1_ : open harpoon file 1  ^ ^
    ^ ^ _2_ : open harpoon file 2  ^ ^
    ^ ^ _3_ : open harpoon file 3  ^ ^
    ^ ^ _4_ : open harpoon file 4  ^ ^
    ^ ^ _5_ : open harpoon file 5  ^ ^
    ^ ^                                     ^ ^
    ^ ^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^ ^
    ^ ^            _<Esc>_: quit            ^ ^
]]

Hydra {
    name = "harpoon",
    hint = harpoon_hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "bottom-right",
            border = border,
        },
    },
    mode = "n",
    body = ";",
    heads = {
        { "1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>" },
        { "2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>" },
        { "3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>" },
        { "4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>" },
        { "5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>" },

        { "p", [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], { exit = true } },
        { "=", [[<cmd>lua require("harpoon.mark").add_file()<CR>]], { exit = true } },

        { "<Esc>", nil, { nowait = true, exit = true, desc = false } },
    },
}
