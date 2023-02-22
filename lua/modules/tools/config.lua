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

function config.colorizer()
    local status_ok, colorizer = pcall(require, "colorizer")
    if not status_ok then
        return
    end

    local options = {
        filetypes = {
            "*",
        },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            mode = "background", -- Set the display mode.
        },
    }
    colorizer.setup(options)
end
return config
