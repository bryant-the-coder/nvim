local lsp = require("utils.pack").package

lsp({
    "neovim/nvim-lspconfig",
    -- event ={"BufEnter", "BufFilePost", "BufFilePre"},
    -- event = "BufRead",
    init = function()
        require("custom.load").lazy_load("nvim-lspconfig")
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    config = function()
        require("modules.lsp.main")
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
    config = function()
        require("modules.lsp.inlay")
    end,
})

lsp({
    enabled = false,
    "max397574/lua-dev.nvim",
    ft = { "lua" },
    after = "nvim-lspconfig",
})

lsp({
    "folke/neodev.nvim",
    ft = { "lua" },
    after = "nvim-lspconfig",
})

lsp({
    enabled = false,
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
    config = function()
        require("modules.lsp.signature")
    end,
})

-- Uncomment this if you want lspsage
lsp({
    "glepnir/lspsaga.nvim",
    cmd = { "Lspsaga" },
    lazy = true,
    config = function()
        require("modules.lsp.saga")
    end,
    dependencies = "neovim/nvim-lspconfig",
})

lsp({
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
        require("modules.lsp.servers.rust_analyzer")
    end,
})

lsp({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
        require("modules.lsp.crates")
    end,
})

lsp({
    "Jose-elias-alvarez/null-ls.nvim",
    event = { "InsertEnter" },
    config = function()
        require("modules.lsp.null-ls")
    end,
})

lsp({
    "max397574/lua-dev.nvim",
    ft = { "lua" },
    after = "nvim-lspconfig",
})
