local fn = vim.fn
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

local lazy = require "lazy"
local plugins = require("core.default_config").plugins

lazy.setup {
    -----------------------------------
    --          Dependencies         --
    -----------------------------------
    "bryant-the-coder/base16",

    "nvim-lua/plenary.nvim",
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require "modules.ui.devicons"
        end,
    },
    "MunifTanjim/nui.nvim",

    -----------------------------------
    --           Completion          --
    -----------------------------------
    -- Nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            {
                enabled = plugins.cmp_luasnip,
                "saadparwaiz1/cmp_luasnip",
            },
            {
                enabled = plugins.cmp_lsp,
                "hrsh7th/cmp-nvim-lsp",
            },
            {
                enabled = plugins.cmp_buffer,
                "hrsh7th/cmp-buffer",
            },
            {
                enabled = plugins.cmp_path,
                "hrsh7th/cmp-path",
            },
            -- { "rcarriga/cmp-dap", after = "nvim-cmp", enabled = plugins.cmp_dap },
            {
                enabled = plugins.cmp_git,
                "petertriho/cmp-git",
                config = function()
                    require "modules.completion.cmp_git"
                end,
            },
        },
        config = function()
            require "modules.completion.cmp"
        end,
        enabled = plugins.cmp,
    },

    -- Snippets
    {
        enabled = plugins.luasnip,
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        config = function()
            require "modules.completion.snippets"
        end,
    },
    {
        enabled = plugins.friendly_snippets,
        "bryant-the-coder/friendly-snippets",
        event = "InsertEnter",
    },

    -- Nvim-autopairs
    {
        enabled = plugins.autopairs,
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
        enabled = plugins.hl_match_area,
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
        enabled = plugins.comment,
        "numToStr/Comment.nvim",
        config = function()
            require "modules.editor.comment"
        end,
    },

    -- Neorg
    {
        enabled = plugins.neorg,
        "nvim-neorg/neorg",
        ft = "norg",
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
    {
        enabled = plugins.neotree,
        "nvim-neo-tree/neo-tree.nvim",
        cmd = { "Neotree", "NeoTreeShow", "NeoTreeFocus", "NeoTreeFocusToggle" },
        config = function()
            require "modules.files.neo-tree"
        end,
    },

    {
        enabled = plugins.harpoon,
        "bryant-the-coder/harpoon",
        events = "VeryLazy",
        config = function()
            require "modules.files.harpoon"
        end,
    },

    {
        enabled = plugins.telescope,
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                enabled = plugins.telescope_fzf_native,
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                after = "telescope.nvim",
            },
            {
                enabled = plugins.telescope_file_browser,
                "nvim-telescope/telescope-file-browser.nvim",
                after = "telescope.nvim",
            },
            {
                enabled = plugins.telescope_ui_select,
                "nvim-telescope/telescope-ui-select.nvim",
                after = "telescope.nvim",
            },
        },
        config = function()
            require "modules.files.telescope"
        end,
    },

    -----------------------------------
    --              Git              --
    -----------------------------------
    {
        enabled = plugins.gitsigns,
        "lewis6991/gitsigns.nvim",
        config = function()
            require "modules.git.gitsigns"
        end,
    },

    -----------------------------------
    --            Language           --
    -----------------------------------
    {
        enabled = plugins.formatter,
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

    {
        enabled = plugins.null,
        "Jose-elias-alvarez/null-ls.nvim",
        event = { "InsertEnter" },
        config = function()
            require "modules.lang.null-ls"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require "modules.lang.treesitter"
        end,
    },

    {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        enabled = plugins.ts_rainbow,
    },

    {
        enabled = plugins.playground,
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    },

    {
        enabled = plugins.ts_context,
        "lewis6991/nvim-treesitter-context",
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    },

    -- LSP
    {
        enabled = plugins.lsp,
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = function()
            require "modules.lsp.init"
            require "modules.lsp.installer"
        end,
    },

    {
        enabled = plugins.lsp_installer,
        "williamboman/mason-lspconfig.nvim",
        -- after = "mason.nvim",
    },

    "williamboman/mason.nvim",

    {
        enabled = plugins.lua_dev,
        "max397574/lua-dev.nvim",
        ft = { "lua" },
        after = "nvim-lspconfig",
    },

    {
        enabled = plugins.inlay,
        "lvimuser/lsp-inlayhints.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.inlay"
        end,
    },

    {
        enabled = plugins.clangd_ext,
        "p00f/clangd_extensions.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.servers.clangd"
        end,
    },

    {
        enabled = plugins.lsp_signature,
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.signature"
        end,
    },

    {
        enabled = plugins.lspsaga,
        "glepnir/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.saga"
        end,
    },

    {
        enabled = plugins.rust_tools,
        "simrat39/rust-tools.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "modules.lsp.servers.rust_analyzer"
        end,
    },

    {
        enabled = plugins.crates,
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require "modules.tools.crates"
        end,
    },

    -----------------------------------
    --             Tools             --
    -----------------------------------
    {
        "mbbill/undotree",
        after = "telescope.nvim",
    },

    {
        enabled = plugins.workspaces,
        "natecraddock/workspaces.nvim",
        after = "telescope.nvim",
        config = function()
            require "modules.tools.workspace"
        end,
    },

    {
        enabled = plugins.dapui,
        "rcarriga/nvim-dap-ui",
        config = function()
            require "modules.tools.dapui"
        end,
        after = "nvim-dap",
    },

    {
        enabled = plugins.dap,
        "mfussenegger/nvim-dap",
        config = function()
            require "modules.tools.dap"
        end,
        after = "nvim-lspconfig",
    },

    {
        enabled = plugins.dap_python,
        "mfussenegger/nvim-dap-python",
        after = "nvim-dap",
    },

    {
        enabled = plugins.colorizer,
        "NvChad/nvim-colorizer.lua",
        cmd = { "ColorizerAttachToBuffer" },
        config = function()
            require "modules.tools.colorizer"
        end,
    },

    {
        enabled = plugins.fidget,
        "j-hui/fidget.nvim",
        module = "lspconfig",
        config = function()
            require "modules.tools.fidget"
        end,
    },

    {
        enabled = plugins.paperplanes,
        "rktjmp/paperplanes.nvim",
        cmd = "PP",
    },

    -- Faster movements
    {
        enabled = plugins.lightspeed,
        "ggandor/lightspeed.nvim",
        keys = { "S", "s", "f", "F", "t", "T" },
        config = function()
            require "modules.tools.lightspeed"
        end,
    },

    {
        enabled = plugins.todo_comments,
        "folke/todo-comments.nvim",
        after = "nvim-treesitter",
        config = function()
            require "modules.tools.todo"
        end,
    },

    -----------------------------------
    --               UI              --
    -----------------------------------
    {
        enabled = plugins.presence,
        "andweeb/presence.nvim",
        lazy = true,
        config = function()
            require "modules.editor.presence"
        end,
    },

    {
        "akinsho/bufferline.nvim",
        -- Taken from https://github.com/max397574/omega-nvim
        init = function()
            vim.api.nvim_create_autocmd({ "BufAdd", "TabEnter" }, {
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
        enabled = plugins.bufferline,
    },

    {
        enabled = plugins.indent_blankline,
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require "modules.ui.indent"
        end,
    },

    {
        enabled = plugins.notify,
        "rcarriga/nvim-notify",
        event = "BufEnter",
        config = function()
            require "modules.ui.notify"
        end,
    },

    -----------------------------------
    --              DOC              --
    -----------------------------------
    -- Neogen
    {
        enabled = plugins.neogen,
        "danymat/neogen",
        config = function()
            require "modules.documentation.neogen"
        end,
    },

    {
        "romainl/vim-devdocs",
        cmd = { "DD" },
    },
}
