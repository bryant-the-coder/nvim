local Hydra = require "hydra"
local cmd = require("hydra.keymap-util").cmd
local border = require("custom.border").styles.type_1

local hints = [[
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
 ^^^^                   Rust Tools                 ^^^^
 ^^^^                                              ^^^^
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
    _u_ : Move up
    _b_ : Move down
    _r_ : Rust runnables
    _ie_: Inlay hints enable
    _id_: Inlay hints disable
    _ha_: Hover actions
    _oc_: Open Cargo.toml
    _pm_: Parent module

    _q_ exit _<Esc>_ exit
]]

Hydra {
    name = "Rust Tools",
    hint = hints,
    config = {
        invoke_on_body = true,
        hint = {
            position = "middle-right",
            border = border,
        },
    },
    mode = { "n" },
    body = "<leader>r",
    heads = {
        {
            "ie",
            function()
                require("rust-tools").inlay_hints.enable()
            end,
            { exit = true },
        },
        {
            "id",
            function()
                require("rust-tools").inlay_hints.disable()
            end,
            { exit = true },
        },
        {
            "r",
            function()
                require("rust-tools").runnables.runnables()
            end,
            { exit = true },
        },
        {
            "u",
            function()
                local up = true -- true = move up, false = move down
                require("rust-tools").move_item.move_item(up)
            end,
            { exit = true },
        },
        {
            "b",
            function()
                local up = false -- true = move up, false = move down
                require("rust-tools").move_item.move_item(up)
            end,
            { exit = true },
        },
        {
            "ha",
            function()
                require("rust-tools").hover_actions.hover_actions()
            end,
            { exit = true },
        },
        {
            "oc",
            function()
                require("rust-tools").open_cargo_toml.open_cargo_toml()
            end,
            { exit = true },
        },
        {
            "pm",
            function()
                require("rust-tools").parent_module.parent_module()
            end,
            { exit = true },
        },
        { "q", nil, { exit = true, nowait = true } },
        { "<Esc>", nil, { exit = true, nowait = true } },
    },
}
