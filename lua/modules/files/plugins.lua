local search = require("utils.pack").package

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
