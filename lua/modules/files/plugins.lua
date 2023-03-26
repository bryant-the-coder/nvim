local search = require("utils.pack").package
local conf = require("modules.files.config")

search({
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            lazy = true,
        },
        { "nvim-lua/plenary.nvim", lazy = true },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            lazy = true,
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
            lazy = true,
        },
    },
    config = function()
        require("modules.files.telescope")
    end,
})

search({
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = {
        "FzfLua files",
        "FzfLua live_grep",
        "FzfLua buffers",
        "FzfLua lsp_references",
        "FzfLua lsp_definitions",
        "FzfLua lsp_code_actions",
    },
    config = conf.fzf,
})
