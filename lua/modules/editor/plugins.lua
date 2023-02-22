local conf = require "modules.editor.config"
local editor = require("utils.pack").package

editor {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = { { "g", mode = "n" }, { "g", mode = "v" } },
    config = conf.comment,
}

editor {
    "LudoPinelli/comment-box.nvim",
    lazy = true,
    keys = { "<Leader>cb", "<Leader>cc", "<Leader>cl", "<M-p>" },
    cmd = { "CBlbox", "CBcbox", "CBline", "CBcatalog" },
    config = conf.comment_box,
}

editor {
    "andweeb/presence.nvim",
    lazy = true,
    --[[ config = function()
        require "modules.editor.presence"
    end, ]]
    config = conf.discord,
}

editor {
    "anuvyklack/hydra.nvim",
    lazy = true,
    dependencies = { "anuvyklack/keymap-layer.nvim" },
    config = conf.hydra,
}

editor {
    "jbyuki/venn.nvim",
    event = "VeryLazy",
    -- lazy = true,
    -- cmd = "Venn",
    config = conf.venn,
}

editor {
    "folke/todo-comments.nvim",
    after = "nvim-treesitter",
    config = conf.todo,
}

return editor
