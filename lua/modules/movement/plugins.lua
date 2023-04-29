local conf = require("modules.movement.config")
local movement = require("utils.pack").package

movement({
    "ggandor/leap.nvim",
    lazy = true,
    event = "VeryLazy",
    priority = 100,
    config = conf.leap,
})

-- Faster movement
movement({
    enabled = false,
    "ggandor/lightspeed.nvim",
    keys = { "S", "s", "f", "F", "t", "T" },
    config = conf.lightspeed,
})

movement({
    "ThePrimeagen/harpoon",
    lazy = true,
    init = function()
        require("custom.load").lazy_load("harpoon")
    end,
    config = conf.harpoon,
})

movement({
    "christoomey/vim-tmux-navigator",
})
