local Hydra = require "hydra"
local border = require("custom.border").styles.type_1

local hint = [[
_h_: show signature     _r_: rename something
_d_: definition         _bh_: show doc
_t_: type definition    _ca_: code action

^ ^            _<Esc>_: quit            ^ ^
]]

Hydra {
    name = "Diagnostic",
    hint = hint,
    config = {
        invoke_on_body = true,
        hint = {
            position = "middle-right",
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
            { exit = true, silent = true },
        },
        {
            "r",
            function()
                require("core.utils").open()
            end,
            { exit = true, silent = true },
        },
        { "d", vim.lsp.buf.definition, { exit = true } },
        { "t", vim.lsp.buf.type_definition, { exit = true } },
        { "h", vim.lsp.buf.signature_help, { exit = true } },
        { "ca", vim.lsp.buf.code_action, { exit = true } },

        { "<Esc>", nil, { nowait = true, exit = true, desc = false } },
    },
}
