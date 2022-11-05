local Hydra = require "hydra"
local cmd = require("hydra.keymap-util").cmd
local border = require("custom.border").styles.type_1

local hint = [[
_bh_: show doc _d_: definition _t_: type definition
_h_ : show sig _r_: rename
]]

Hydra {
    name = "Diagnostic",
    hint = hint,
    config = {
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = border,
        },
    },
    mode = { "n" },
    body = "<leader>l",
    heads = {
        {
            "bh",
            function()
                require("core.utils").show_documentation()
            end,
            { exit = true },
        },
        {
            "r",
            function()
                require("core.utils").open()
            end,
            { exit = true },
        },
        { "d", vim.lsp.buf.definition, { exit = true } },
        { "t", vim.lsp.buf.type_definition, { exit = true } },
        { "h", vim.lsp.buf.signature_help, { exit = true } },
    },
}
