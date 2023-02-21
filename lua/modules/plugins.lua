return {
    -----------------------------------
    --          Dependencies         --
    -----------------------------------
    {
        "folke/lazy.nvim",
        version = "*",
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require "modules.ui.devicons"
        end,
    },

    -- Theme
    {
        "bryant-the-coder/base16",
        lazy = false,
        priority = 1000,
        config = function()
            local base16 = require "base16"
            local theme = vim.g.colors_name
            return base16(base16.themes(theme))
        end,
    },
    { "catppuccin/nvim", name = "catppuccin" },

    {
        "MunifTanjim/nui.nvim",
        -- after = "neo-tree.nvim",
    },

    -----------------------------------
    --           Completion          --
    -----------------------------------
    -- CMP
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        after = { "LuaSnip" },
        dependencies = {
            {
                "saadparwaiz1/cmp_luasnip",
                after = { "nvim-cmp" },
            },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            {
                "petertriho/cmp-git",
                after = "nvim-cmp",
                config = function()
                    require "modules.completion.cmp_git"
                end,
            },
        },
        config = function()
            require "modules.completion.cmp"
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        config = function()
            require "modules.completion.snippets"
        end,
    },

    {
        "bryant-the-coder/friendly-snippets",
        event = "InsertEnter",
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = {
            "InsertEnter",
            -- for working with cmp
            "CmdLineEnter",
        },
        after = "nvim-cmp",
        config = function()
            require "modules.completion.autopairs"
        end,
    },

    -----------------------------------
    --             Editor            --
    -----------------------------------
    {
        enabled = false,
        "rareitems/hl_match_area.nvim",
        config = function()
            require "modules.editor.hl_area"
        end,
        after = "nvim-lspconfig",
    },

    {
        "anuvyklack/hydra.nvim",
        dependencies = "anuvyklack/keymap-layer.nvim",
        config = function()
            require "modules.editor.hydra.init"
        end,
        event = "InsertEnter",
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            lazy = true,
        },
        config = function()
            require "modules.editor.comment"
        end,
    },

    -- Neorg
    {
        "nvim-neorg/neorg",
        lazy = true,
        ft = "norg",
        cmd = "Neorg",
        config = function()
            require "modules.editor.neorg"
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        keys = { "<c-t>", "<leader>tg" },
        config = function()
            require "modules.editor.toggleterm"
        end,
    },

    -----------------------------------
    --              Files            --
    -----------------------------------
    -- Oil.nvim
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "<leader>oo", require("oil").open, { desc = "Open parent directory" })
        end,
        config = function()
            require "modules.files.oil"
        end,
    },

    -- Neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        cmd = { "Neotree", "NeoTreeShow", "NeoTreeFocus", "NeoTreeFocusToggle" },
        config = function()
            require "modules.files.neo-tree"
        end,
    },

    {
        "bryant-the-coder/harpoon",
        lazy = true,
        init = function()
            require("custom.load").lazy_load "harpoon"
        end,
        config = function()
            require "modules.files.harpoon"
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require "modules.files.telescope"
        end,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                lazy = true,
                -- after = "telescope.nvim",
            },
            --[[ {
                "nvim-telescope/telescope-file-browser.nvim",
                -- after = "telescope.nvim",
                lazy = true,
            }, ]]

            {
                "nvim-telescope/telescope-ui-select.nvim",
                -- after = "telescope.nvim",
                lazy = true,
            },
        },
    },
    --[[ {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        after = "telescope.nvim",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        after = "telescope.nvim",
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        after = "telescope.nvim",
    }, ]]

    -----------------------------------
    --              Git              --
    -----------------------------------
    {
        "TimUntersberger/neogit",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Neogit" },
        config = function()
            require "modules.git.neogit"
        end,
    },

    {
        enabled = false,
        "tpope/vim-fugitive",
        after = "gitsigns.nvim",
        cmd = {
            "Git commit",
            "Git add",
        },
    },

    -- Git intergrations
    {
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
                    vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = "gitsigns.nvim" }
                        end)
                    end
                end,
            })
        end,
        config = function()
            require "modules.git.gitsigns"
        end,
    },
    --[[ {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        config = function()
            require "modules.git.gitsigns"
        end,
        -- dependencies = { "nvim-lua/plenary.nvim" },
        -- module = "gitsigns",
    }, ]]

    {
        enabled = false,
        "sindrets/diffview.nvim",
        after = "gitsigns.nvim",
        config = function()
            require "modules.git.diffview"
        end,
    },

    -----------------------------------
    --            Language           --
    -----------------------------------
    -- Formatter
    {
        enabled = false,
        "mhartington/formatter.nvim",
        cmd = "FormatWrite",
        init = function()
            local group = vim.api.nvim_create_augroup("Formatter", {})
            vim.api.nvim_create_autocmd("BufWritePost", {
                callback = function()
                    vim.cmd [[FormatWrite]]
                end,
                group = group,
            })
        end,
        config = function()
            require "modules.lang.formatter"
        end,
    },

    -- Null-ls
    {
        "Jose-elias-alvarez/null-ls.nvim",
        event = { "InsertEnter" },
        config = function()
            require "modules.lang.null-ls"
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
            require("custom.load").lazy_load "nvim-treesitter"
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require "modules.lang.treesitter"
        end,
    },

    -- Vscode like rainbow parenthesis
    {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
    },

    -- Auto complete tag
    {
        enabled = false,
        "windwp/nvim-ts-autotag",
        -- ft = { "html", "typescript", "javascripts", "javascriptreact" },
    },

    {
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    },

    {
        "lewis6991/nvim-treesitter-context",
        -- after = "nvim-treesitter",
        ft = { "rust", "python" },
        config = function()
            require("treesitter-context").setup {
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            }
        end,
    },

    -- Trouble
    {
        enabled = false,
        "folke/trouble.nvim",
        cmd = {
            "Trouble",
            "TroubleRefresh",
            "TroubleClose",
            "TroubleToggle",
        },
        config = function()
            require "modules.lang.trouble"
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        -- event ={"BufEnter", "BufFilePost", "BufFilePre"},
        -- event = "BufRead",
        init = function()
            require("custom.load").lazy_load "nvim-lspconfig"
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
        config = function()
            require "modules.lsp.main"
        end,
    },

    -- mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        -- after = "mason.nvim",
    },

    -- Much like lspisntaller, but better
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    },

    -- Setting up inlay hints
    {
        enabled = false,
        "lvimuser/lsp-inlayhints.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.inlay"
        end,
    },

    {
        "max397574/lua-dev.nvim",
        ft = { "lua" },
        after = "nvim-lspconfig",
    },

    {
        enabled = false,
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
        -- after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.servers.clangd"
        end,
    },

    {
        "ray-x/lsp_signature.nvim",
        lazy = true,
        ft = { "python" },
        config = function()
            require "modules.lsp.signature"
        end,
    },

    -- Uncomment this if you want lspsage
    {
        "glepnir/lspsaga.nvim",
        cmd = { "Lspsaga" },
        lazy = true,
        config = function()
            require "modules.lsp.saga"
        end,
        dependencies = "neovim/nvim-lspconfig",
    },

    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            require "modules.lsp.servers.rust_analyzer"
        end,
    },

    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require "modules.tools.crates"
        end,
    },

    {
        "stevearc/overseer.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        cmd = {
            "OverseerDebugParser",
            "OverseerRun",
            "OverseerRunCmd",
            "OverseerInfo",
            "OverseerToggle",
            "OverseerOpen",
        },
        keys = {
            { "<leader>oo", "<cmd>OverseerToggle<CR>", mode = "n" },
            { "<leader>or", "<cmd>OverseerRun<CR>", mode = "n" },
            { "<leader>oc", "<cmd>OverseerRunCmd<CR>", mode = "n" },
            { "<leader>ol", "<cmd>OverseerLoadBundle<CR>", mode = "n" },
            { "<leader>ob", "<cmd>OverseerBuild<CR>", mode = "n" },
            { "<leader>od", "<cmd>OverseerQuickAction<CR>", mode = "n" },
            { "<leader>os", "<cmd>OverseerTaskAction<CR>", mode = "n" },
        },
        config = function()
            require "modules.lsp.overseer"
        end,
    },

    -----------------------------------
    --             Tools             --
    -----------------------------------
    {
        "mbbill/undotree",
        -- after = "telescope.nvim",
        cmd = {
            "UndotreeToggle",
            "UndotreeShow",
            "UndotreeFocus",
            "UndotreeHide",
        },
    },

    {
        "natecraddock/workspaces.nvim",
        lazy = true,
        cmd = {
            "WorkspacesAdd",
            "WorkspacesRemove",
            "WorkspacesRename",
            "WorkspacesList",
            "WorkspacesOpen",
        },
        config = function()
            require "modules.tools.workspace"
        end,
    },

    -- Navigate nvim and tmux properly!
    {
        enabled = false,
        "christoomey/vim-tmux-navigator",
        after = "base16",
    },

    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            require "modules.tools.dap"
        end,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
        },
    },

    --[[ {
        "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        config = function()
            require "modules.tools.dapui"
        end,
    }, ]]

    --[[ {
        "mfussenegger/nvim-dap-python",
        after = "nvim-dap",
    }, ]]

    -- Quickly move around tabs
    {
        enabled = false,
        "ghillb/cybu.nvim",
        branch = "main", -- timely updates
        config = function()
            require "modules.tools.cybu"
        end,
    },

    {
        enabled = false,
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require "modules.tools.neodim"
        end,
    },

    -- Hex colours
    {
        -- "NvChad/nvim-colorizer.lua",
        -- config = function()
        --     require "modules.tools.colorizer"
        -- end,
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerAttachToBuffer" },
        config = function()
            require("colorizer").setup({
                "*",
            }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = false, -- #RRGGBBAA hex codes
                rgb_fn = false, -- CSS rgb() and rgba() functions
                hsl_fn = false, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode = "background", -- Set the display mode.
            })
            vim.cmd.ColorizerAttachToBuffer()
        end,
    },

    -- Change colors live in a window
    {
        enabled = false,
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require "modules.tools.colortils"
        end,
    },

    -- Show lsp progress when you enter a file
    {
        "j-hui/fidget.nvim",
        lazy = true,
        module = "lspconfig",
        config = function()
            require "modules.tools.fidget"
        end,
    },

    -- Share code
    {
        "rktjmp/paperplanes.nvim",
        cmd = "PP",
    },

    {
        -- enabld = false,
        "folke/todo-comments.nvim",
        after = "nvim-treesitter",
        config = function()
            require "modules.tools.todo"
        end,
    },

    {
        enabled = false,
        "kylechui/nvim-surround",
        after = "nvim-treesitter",
        config = function()
            require "modules.tools.surround"
        end,
    },

    {
        enabled = false,
        "RRethy/nvim-align",
    },

    -----------------------------------
    --               UI              --
    -----------------------------------
    {
        enabled = false,
        "karb94/neoscroll.nvim", -- NOTE: alternative: 'declancm/cinnamon.nvim'
        config = function()
            require("neoscroll").init {
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil, -- Function to run after the scrolling animation ends
            }
        end,
    },

    -- Zen mode
    {
        enabled = false,
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").init {}
        end,
    },

    -- True zen
    {
        enabled = false,
        "Pocco81/TrueZen.nvim",
        cmd = {
            "TZAtaraxis",
            "TZMinimalist",
            "TZFocus",
        },
        config = function()
            require "modules.ui.zen"
        end,
    },

    -- Presence
    {
        "andweeb/presence.nvim",
        lazy = true,
        config = function()
            require "modules.editor.presence"
        end,
    },

    -- Bufferline
    {
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
        config = function()
            require "modules.ui.bufferline"
        end,
    },

    -- Indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        -- event = "BufReadPost",
        init = function()
            require("custom.load").lazy_load "indent-blankline.nvim"
        end,
        lazy = true,
        config = function()
            require "modules.ui.blankline"
        end,
    },

    -- Notifications
    {
        "rcarriga/nvim-notify",
        event = "BufEnter",
        config = function()
            require "modules.ui.notify"
        end,
    },

    {
        enabled = false,
        "lewis6991/satellite.nvim",
        after = "bufferline.nvim",
        config = function()
            require "modules.ui.satellite"
        end,
    },

    -----------------------------------
    --              DOC              --
    -----------------------------------
    -- Neogen
    {
        "danymat/neogen",
        lazy = true,
        dependencies = { "L3MON4D3/LuaSnip" },
        config = function()
            require "modules.documentation.neogen"
        end,
    },

    {
        "romainl/vim-devdocs",
        cmd = { "DD" },
    },

    -----------------------------------
    --            Movement           --
    -----------------------------------
    {
        "ggandor/leap.nvim",
        config = function()
            require "modules.movement.leap"
        end,
    },

    -- Faster movement
    {
        enabled = false,
        "ggandor/lightspeed.nvim",
        keys = { "S", "s", "f", "F", "t", "T" },
        config = function()
            require "modules.movement.lightspeed"
        end,
    },
}
