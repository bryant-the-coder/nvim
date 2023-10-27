local ai = require("utils.pack").package
local conf = require("modules.ai.config")

ai({
    enabled = false,
    "zbirenbaum/copilot.lua",
    ft = { "lua", "cpp", "python" },
    dependencies = { "nvim-cmp" },
    opts = {
        panel = {
            enabled = true,
            auto_refresh = true,
            keymap = { open = "<M-CR>" },
            layout = { position = "right", ratio = 0.4 },
        },
        suggestion = {
            auto_trigger = true,
            keymap = { accept = "<M-a>", accept_word = "<M-w>", accept_line = "<M-l>" },
        },
        filetypes = {
            gitcommit = false,
            NeogitCommitMessage = false,
            DressingInput = false,
            TelescopePrompt = false,
            ["neo-tree-popup"] = false,
            ["dap-repl"] = false,
        },
    },
})
