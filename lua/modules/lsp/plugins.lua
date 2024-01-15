local lsp = require("utils.pack").package
local conf = require("modules.lsp.config")

lsp({
    "neovim/nvim-lspconfig",
    -- event ={"BufEnter", "BufFilePost", "BufFilePre"},
    -- event = "BufRead",
    --[[ init = function()
        require("custom.load").lazy_load("nvim-lspconfig")
    end, ]]
    -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    config = function()
        require("modules.lsp.settings.main")
    end,
})

lsp({
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
})

lsp({
    enabled = false,
    "lvimuser/lsp-inlayhints.nvim",
    after = "nvim-lspconfig",
    --[[ config = function()
        require("modules.lsp.inlay")
    end, ]]
    config = conf.inlayhints,
})

lsp({
    enabled = false,
    "max397574/lua-dev.nvim",
    ft = { "lua" },
    after = "nvim-lspconfig",
})

lsp({
    enabled = true,
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    -- after = "nvim-lspconfig",
    config = function()
        require("modules.lsp.servers.clangd")
    end,
})

lsp({
    "ray-x/lsp_signature.nvim",
    lazy = true,
    ft = { "python" },
    config = conf.signature,
})

lsp({
    "nvimdev/lspsaga.nvim",
    cmd = { "Lspsaga" },
    lazy = true,
    config = conf.saga,
    dependencies = "neovim/nvim-lspconfig",
})

lsp({
    enabled = false,
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
        require("modules.lsp.servers.rust_analyzer")
    end,
})

lsp({
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {},
            -- LSP configuration
            server = {
                on_attach = function(client, bufnr)
                    -- you can also put keymaps in here
                end,
                settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {},
                },
            },
            -- DAP configuration
            dap = {},
        }
    end,
})

lsp({
    "saecki/crates.nvim",
    ft = "rust",
    event = { "BufRead Cargo.toml" },
    config = conf.rust_crates,
})

lsp({
    "nvimtools/none-ls.nvim",
    event = { "InsertEnter" },
    config = function()
        require("modules.lsp.null-ls")
    end,
})

lsp({
    "folke/neodev.nvim",
    config = function(_, opts)
        require("modules.lsp.servers.lua_ls").setup(opts)
    end,
})
