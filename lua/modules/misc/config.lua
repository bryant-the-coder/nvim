local config = {}

function config.workspaces()
    require("workspaces").setup {
        -- path to a file to store workspaces data in
        -- on a unix system this would be ~/.local/share/nvim/workspaces
        path = vim.fn.stdpath "data" .. "/workspaces",

        -- to change directory for all of nvim (:cd) or only for the current window (:lcd)
        -- if you are unsure, you likely want this to be true.
        global_cd = true,

        -- sort the list of workspaces by name after loading from the workspaces path.
        sort = true,

        -- sort by recent use rather than by name. requires sort to be true
        mru_sort = true,

        -- enable info-level notifications after adding or removing a workspace
        notify_info = true,

        hooks = {
            open = { "Neotree", "Telescope find_files" },
        },
    }

    require("telescope").load_extension "workspaces"
end

function config.surround()
    local status_ok, surround = pcall(require, "nvim-surround")
    if not status_ok then
        return
    end

    surround.setup {
        keymaps = { -- vim-surround style keymaps
            insert = "ys",
            visual = "S",
            delete = "ds",
            change = "cs",
        },
        delimiters = {
            pairs = {
                ["("] = { "( ", " )" },
                [")"] = { "(", ")" },
                ["{"] = { "{ ", " }" },
                ["}"] = { "{", "}" },
                ["<"] = { "< ", " >" },
                [">"] = { "<", ">" },
                ["["] = { "[ ", " ]" },
                ["]"] = { "[", "]" },
            },
            separators = {
                ["'"] = { "'", "'" },
                ['"'] = { '"', '"' },
                ["`"] = { "`", "`" },
            },
            HTML = {
                ["t"] = false, -- Use "t" for HTML-style mappings
            },
            aliases = {
                ["a"] = ">", -- Single character aliases apply everywhere
                ["b"] = ")",
                ["B"] = "}",
                ["r"] = "]",
                ["q"] = { '"', "'", "`" }, -- Table aliases only apply for changes/deletions
            },
        },
    }
end

return config
