-- local km = require("core.keymap")
local Hydra = require "hydra"
local cmd = require("hydra.keymap-util").cmd
local border = require("custom.border").styles.type_1

if table.unpack == nil then
    table.unpack = unpack
end

local config = {}

local exit = { nil, { exit = true, desc = "EXIT" } }
-- TODO: make a toggler for cursorhold events, so we can show peek
function toggle(lhs, on_enter, on_exit)
    return {
        color = "pink",
        body = lhs,
        [lhs] = exit,
        on_exit = on_exit,
        on_enter = on_enter,
    }
end

local hints = [[
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
 ^^^^                    Doc gen                   ^^^^
 ^^^^                                              ^^^^
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
    _d_: Gen Docs
    _c_: Gen Class
    _s_: Gen Type

 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
 ^^^^               Documentation Search           ^^^^
 ^^^^                                              ^^^^
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔^^^^
    _k_: Dev doc

  _Esc_: Quit
]]

config.doc_binds = {
    color = "pink",
    body = "<leader>d",
    mode = { "n", "v", "x", "o" },
    ["<Esc>"] = { nil, { exit = true } },
    -- Neogen stuff
    d = {
        function()
            require("neogen").generate()
        end,
        { nowait = true, silent = true, desc = "Gen Doc", exit = true },
    },
    c = {
        function()
            require("neogen").generate { type = "class" }
        end,
        { nowait = true, silent = true, desc = "Gen class", exit = true },
    },
    s = {
        function()
            require("neogen").generate { type = "type" }
        end,
        { nowait = false, silent = false, desc = "Gen type", exit = false },
    },
    k = {
        cmd "DD",
        { nowait = true, silent = true, desc = "DevDoc Search", exit = true },
    },
}

local mapping = {
    color = function(t, rhs)
        t.config.color = rhs
    end,
    body = function(t, rhs)
        t.body = rhs
    end,
    on_enter = function(t, rhs)
        t.config.on_enter = rhs
    end,
    on_exit = function(t, rhs)
        t.config.on_exit = rhs
    end,
    mode = function(t, rhs)
        t.config.mode = rhs
    end,
}

local new_hydra = {
    hint = hints,
    name = "core",

    config = {
        hint = {
            position = "middle-right",
            border = border,
        },
        invoke_on_body = true,
        timeout = false,
    },
    heads = {},
}

for name, spec in pairs(config) do
    for lhs, rhs in pairs(spec) do
        local action = mapping[lhs]
        if action == nil then
            new_hydra.heads[#new_hydra.heads + 1] = { lhs, table.unpack(rhs) }
        else
            action(new_hydra, rhs)
        end
    end
end

Hydra(new_hydra)
