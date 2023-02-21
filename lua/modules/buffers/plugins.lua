local buffer = require("utils.pack").package
local conf = require "modules.buffers.config"

buffer {
    "akinsho/bufferline.nvim",
    lazy = true,
    -- Taken from https://github.com/max397574/omega-nvim
    init = function()
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
            pattern = "*",
            group = vim.api.nvim_create_augroup("BufferLineLazyLoading", {}),
            callback = function()
                local count = #vim.fn.getbufinfo { buflisted = 1 }
                if count >= 2 then
                    require("lazy").load { plugins = { "bufferline.nvim" } }
                end
            end,
        })
    end,
    config = conf.nvim_bufferline,
}

buffer {
    enabled = false,
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    config = conf.cybu,
}

buffer {
    "stevearc/oil.nvim",
    -- event = "VeryLazy",
    init = function()
        vim.keymap.set("n", "<leader>oo", require("oil").open, { desc = "Open parent directory" })
    end,
    config = conf.oil,
}
