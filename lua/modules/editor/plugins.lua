local conf = require("modules.editor.config")
local editor = require("utils.pack").package

editor({
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
    },
    keys = { { "g", mode = "n" }, { "g", mode = "v" } },
    config = conf.comment,
})

editor({
    enabled = false,
    "LudoPinelli/comment-box.nvim",
    lazy = true,
    keys = { "<Leader>cb", "<Leader>cc", "<Leader>cl", "<M-p>" },
    cmd = { "CBlbox", "CBcbox", "CBline", "CBcatalog" },
    config = conf.comment_box,
})

editor({
    enabled = true,
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = conf.discord,
})

editor({
    enabled = false,
    "anuvyklack/hydra.nvim",
    lazy = true,
    dependencies = { "anuvyklack/keymap-layer.nvim" },
    config = conf.hydra,
})

editor({
    enabled = false,
    "jbyuki/venn.nvim",
    event = "VeryLazy",
    -- lazy = true,
    -- cmd = "Venn",
    config = conf.venn,
})

editor({
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = conf.todo,
})

return editor
