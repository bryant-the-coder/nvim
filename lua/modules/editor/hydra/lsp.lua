local Hydra = require("hydra")
local border = require("custom.border").styles.type_1
local cmd = require("hydra.keymap-util").cmd

local hint = [[
_d_    : definition
_t_    : type definition
_h_    : show signature
_r_    : rename
_sd_   : show documentation
_so_   : outline
_<Esc>_: quit
]]

-- _a_ : code action

Hydra({
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
            "sd",
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
        -- { "a", "<cmd>Lspsaga code_action<CR>", { exit = true } },
        { "so", "<cmd>LSoutlineToggle<CR>", { exit = true } },

        { "<Esc>", nil, { nowait = true, exit = true, desc = false } },
    },
})
