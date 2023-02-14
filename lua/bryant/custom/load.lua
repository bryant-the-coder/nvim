local load = {}

local cmd = vim.api.nvim_create_autocmd
-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/modules/ui/bufferline.lua
load.lazy_load = function(plugin)
    vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
        callback = function()
            local file = vim.fn.expand "%"
            local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

            if condition then
                vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

                -- dont defer for treesitter as it will show slow highlighting
                -- This deferring only happens only when we do "nvim filename"
                if plugin ~= "nvim-treesitter" then
                    vim.schedule(function()
                        require("lazy").load { plugins = plugin }

                        if plugin == "nvim-lspconfig" then
                            vim.cmd "silent! do FileType"
                        end
                    end, 0)
                else
                    require("lazy").load { plugins = plugin }
                end
            end
        end,
    })
end

-- If there is more than 1 buffer, load bufferline
--[[ load.bufferline = function()
    lazy_load {
        events = { "BufNewFile", "BufRead", "TabEnter" },
        augroup_name = "BufferLineLazy",
        plugins = "bufferline.nvim",
        cond = function()
            return #vim.fn.getbufinfo { buflisted = 1 } >= 2
        end,
    }
end

load.colorizer = function()
    lazy_load {
        events = { "BufRead", "BufNewFile" },
        augroup_name = "ColorizerLazy",
        plugins = "nvim-colorizer.lua",
        cond = function()
            return true
        end,
    }
end

-- Only load todo comments with these specific words
load.todo_comments = function()
    lazy_load {
        events = { "BufRead", "BufNewFile" },
        augruop = "TodoLazy",
        plugins = "todo-comments.nvim",
        cond = function()
            local words = {
                "FIXME",
                "BUG",
                "FIXIT",
                "ISSUE",
                "FIX",
                "TODO",
                "REVIST",
                "todo",
                "Todo",
                "HACK",
                "WARN",
                "WARNING",
                "XXX",
                "PERF",
                "OPTIM",
                "PERFORMANCE",
                "OPTIMIZE",
                "NOTE",
            }

            for _, val in ipairs(words) do
                if vim.fn.search(val) ~= 0 then
                    return true
                end
            end
        end,
    }
end

load.ts = function()
    lazy_load {
        events = { "BufRead", "BufWinEnter", "BufNewFile" },
        augroup_name = "Treesitter_lazy",
        plugins = "nvim-treesitter",
        cond = function()
            local file = vim.fn.expand "%"
            return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= "neo-tree filesystem" and file ~= ""
        end,
    }
end

--- Check if the directory has .git folder or not
load.git = function()
    cmd({ "BufEnter" }, {
        callback = function()
            if vim.fn.isdirectory ".git" ~= 0 then
                vim.schedule(function()
                    require("lazy").load { plugins = { "gitsigns.nvim" } }
                end)
            end
        end,
    })
end

-- Same logic as loading bufferline
load.harpoon = function()
    lazy_load {
        events = { "BufRead", "TabEnter" },
        augroup_name = "HarpoonLazy",
        plugins = "harpoon",
        cond = function()
            return #vim.fn.getbufinfo { buflisted = 1 } >= 2
        end,
    }
end

load.blankline = function()
    cmd("BufEnter", {
        callback = function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            if lines ~= { "" } then
                require("lazy").load { plugins = { "indent-blankline.nvim" } }
            end
        end,
    })
end

load.on_file_open = function(plugname)
    lazy_load {
        events = { "BufRead", "BufWinEnter", "BufNewFile" },
        augroup_name = "BeLazyOnFileOpen" .. plugname,
        plugins = plugname,
        cond = function()
            local file = vim.fn.expand "%"
            return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
        end,
    }
end ]]

return load
