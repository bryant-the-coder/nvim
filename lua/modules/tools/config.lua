local config = {}

function config.workspaces()
    require("workspaces").setup({
        -- path to a file to store workspaces data in
        -- on a unix system this would be ~/.local/share/nvim/workspaces
        path = vim.fn.stdpath("data") .. "/workspaces",
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
            open = { "Telescope find_files" },
        },
    })

    require("telescope").load_extension("workspaces")
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

function config.toggleterm()
    local present, toggleterm = pcall(require, "toggleterm")
    if not present then
        return
    end

    -- toggleterm.setup {
    --     size = 16,
    --     open_mapping = [[<c-b>]],
    --     shade_filetypes = {},
    --     shade_terminals = false,
    --     start_in_insert = true,
    --     insert_mappings = true,
    --     persist_size = true,
    --     direction = "horizontal",
    --     close_on_exit = true,
    --     float_opts = {
    --         -- border = "shadow",
    --         border = {
    --             "╭",
    --             "─",
    --             "╮",
    --             "│",
    --             "╯",
    --             "─",
    --             "╰",
    --             "│",
    --         },
    --         winblend = 0,
    --         highlights = {
    --             border = "FloatBorder",
    --             background = "NormalFloat",
    --         },
    --     },
    -- }

    toggleterm.setup({
        size = 52,
        open_mapping = [[<c-t>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = "vertical",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_open_win'
            -- see :h nvim_open_win for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            border = "curved",
            -- like `size`, width and height can be a number or function which is passed the current terminal
            width = 200,
            height = 50,
            winblend = 3,
        },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "horizontal" })

    function _lazygit_toggle()
        lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
end

function config.hover()
    require("hover").setup({
        init = function()
            -- Require providers
            require("hover.providers.lsp")
            require("hover.providers.gh")
            require("hover.providers.gh_user")
            require("hover.providers.man")
        end,
        preview_opts = {
            border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
    })
end

return config
