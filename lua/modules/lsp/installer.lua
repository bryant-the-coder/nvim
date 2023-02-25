local servers = {
    "clangd",
    "jsonls",
    "tsserver",
    "ltex",
    "texlab",
    "lua_ls",
    "jedi_language_server",
    "pyright",
    "rust_analyzer",
    "taplo",
    "vimls",
    "yamlls",
}

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

mason.setup({
    ui = {
        icons = {
            server_installed = " ",
            server_pending = " ",
            server_uninstalled = " ﮊ",
        },
    },
    PATH = "skip",
    -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
    -- servers that are requested to be installed will be put in a queue.

    -- NOTE: to prevent lack
    -- max_concurrent_installers = 5,
})

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})
