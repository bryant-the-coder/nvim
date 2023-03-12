local conf = require("modules.tools.config")
local tools = require("utils.pack").package

tools({
    "rktjmp/paperplanes.nvim",
    lazy = true,
    cmd = { "PP" },
    config = true,
})

tools({
    "natecraddock/workspaces.nvim",
    lazy = true,
    cmd = {
        "WorkspacesAdd",
        "WorkspacesRemove",
        "WorkspacesRename",
        "WorkspacesList",
        "WorkspacesOpen",
    },
    config = conf.workspaces,
})

tools({
    "akinsho/toggleterm.nvim",
    keys = { "<c-t>", "<leader>tg" },
    config = conf.toggleterm,
})

tools({
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = conf.colorizer,
})

tools({
    "mbbill/undotree",
    -- after = "telescope.nvim",
    cmd = {
        "UndotreeToggle",
        "UndotreeShow",
        "UndotreeFocus",
        "UndotreeHide",
    },
})
