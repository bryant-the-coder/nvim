local Hydra = require "hydra"
local cmd = require("hydra.keymap-util").cmd
local border = require("custom.border").styles.type_1

local telescope_hint = [[
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^
 ^^^^                       Files                         ^^^^
 ^^^^                                                     ^^^^
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^
  _f_ : Find files                   _w_: Find string
  _d_ : Find diag                    _c_: Colorscheme
  _m_ : Find word (buffer)           _t_: Harpoon
  _o_ : Oldfiles                     _k_: Mappings
  _ws_: Workspaces
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^

 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^
 ^^^^                       DevDoc                        ^^^^
 ^^^^                                                     ^^^^
 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^
      _;_: Search ft    _'_: Search     _#_: Browse

 ^^^^▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔ ^^^^
  _q_ exit _<Esc>_ exit

]]

Hydra {
    name = "Diagnostic",
    hint = telescope_hint,
    config = {
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = border,
        },
    },
    mode = { "n" },
    body = "<leader>f",
    heads = {
        {
            "f",
            function()
                require("modules.files.telescope").find_files()
            end,
            { exit = true },
        },
        {
            "w",
            function()
                require("modules.files.telescope").live_grep()
            end,
            { exit = true },
        },
        {
            "d",
            function()
                require("modules.files.telescope").diag()
            end,
            { exit = true },
        },
        {
            "c",
            function()
                require("telescope.builtin").colorscheme()
            end,
            { exit = true },
        },
        {
            "o",
            function()
                require("telescope.builtin").oldfiles()
            end,
            { exit = true },
        },
        {
            "k",
            function()
                require("telescope.builtin").keymaps()
            end,
            { exit = true },
        },
        {
            "m",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end,
            { exit = true },
        },
        {
            "t",
            function()
                require("modules.files.telescope").harpoon()
            end,
            { exit = true },
        },
        {
            "ws",
            "<cmd>Telescope workspaces<CR>",
            { exit = true },
        },
        { ";", require("modules.files.telescope").devdocs_ft, { exit = true, desc = "Dev Doc search ft" } },
        { "'", require("modules.files.telescope").devdocs_search, { exit = true, desc = "Dev Doc search" } },
        { "#", require("modules.files.telescope").google_search, { exit = true, desc = "Google search" } },
        { "q", nil, { exit = true, nowait = true } },
        { "<Esc>", nil, { exit = true, nowait = true } },
    },
}
