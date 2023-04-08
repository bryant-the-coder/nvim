local conf = require("modules.git.config")
local git = require("utils.pack").package

git({
    "TimUntersberger/neogit",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Neogit" },
    config = conf.neogit,
})

git({
    enabled = false,
    "tpope/vim-fugitive",
    after = "gitsigns.nvim",
})

-- Git intergrations
git({
    "lewis6991/gitsigns.nvim",
    -- event = "BufRead",
    -- init = function()
    --     require("custom.load").lazy_load "gitsigns.nvim"
    -- end,
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                    vim.schedule(function()
                        require("lazy").load({ plugins = "gitsigns.nvim" })
                    end)
                end
            end,
        })
    end,
    config = conf.gitsigns,
})

--[[ {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    config = function()
        require "modules.git.gitsigns"
    end,
    -- dependencies = { "nvim-lua/plenary.nvim" },
    -- module = "gitsigns",
} ]]
git({
    enabled = true,
    "sindrets/diffview.nvim",
    after = "gitsigns.nvim",
    config = conf.diffview,
})
