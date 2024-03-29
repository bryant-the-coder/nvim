local lang_lua = {}

local capabilities = require("modules.lsp.settings.capabilities")
-- Creating a function call on_attach
local function on_attach(client, bufnr)
    require("modules.lsp.settings.on_attach").setup(client, bufnr)
end

local defaults = {
    lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                        "neorg",
                    },
                },
                completion = {
                    callSnippet = "Replace",
                    displayContext = 5,
                    showWord = "Enable",
                },
                hint = {
                    enable = true,
                    paramType = true,
                    setType = true,
                    paramName = true,
                    arrayIndex = "Enable",
                },
                misc = {
                    parameters = {
                        "--log-level=trace",
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    maxPreload = 1000,
                    preloadFileSize = 1000,
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                },
            },
        },
    },
}
defaults.neodev = {
    library = {
        runtime = true,
        types = true,
        plugins = {},
    },
    lspconfig = defaults.lua_ls,
}

function lang_lua.setup(opts)
    defaults = vim.tbl_deep_extend("force", defaults, opts.opts or {})
    require("neodev").setup(defaults.neodev)
    require("lspconfig")["lua_ls"].setup(defaults.lua_ls)
end

return lang_lua
