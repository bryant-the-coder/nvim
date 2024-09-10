local lspconfig = require("lspconfig")
local py = require("modules.lsp.utils.python_help")

-- WARN: Dont remove this files
require("modules.lsp.installer")
require("modules.lsp.settings.lsp_config")

-- Creating a function call on_attach
local function on_attach(client, bufnr)
    require("modules.lsp.settings.on_attach").setup(client, bufnr)
end

--[[ local function on_attach_16(client, bufnr)
    require("modules.lsp.settings.on_attach").setup(client, bufnr)
end ]]
local capabilities = require("modules.lsp.settings.capabilities")

-- Loading the LSP servers in a list
local servers = {
    ts_ls = {},
    vimls = {},
    bashls = {},
    jsonls = {},
    texlab = require("modules.lsp.servers.texlab"),
    gopls = {},
    clangd = {
        cmd = {
            "clangd",
            -- NOTE: don't remove this if you don't want errors
            "--offset-encoding=utf-16",
            "-j=4",
            "--background-index",
            "--clang-tidy",
            "--fallback-style=llvm",
            "--all-scopes-completion",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--pch-storage=memory",
        },
    },
    -- basedpyright = {},
    -- pyright = {},
}
for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, config))
end

local pyright = {
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                indexing = true,
                typecheckingmode = "basic",
                -- diagnosticmode = "openfilesonly",
                diagnosticmode = "workspace",
                inlayhints = {
                    variabletypes = true,
                    functionreturntypes = true,
                },
                stubpath = vim.fn.expand("$home/typings"),
                diagnosticseverityoverrides = {
                    reportunusedimport = "information",
                    reportunusedfunction = "information",
                    reportunusedvariable = "information",
                },
            },
        },
    },
}

local jedi = {
    on_attach = on_attach,
    -- capabilities = capabilities,
    init_options = {
        jediSettings = {
            case_insensitive_completion = true,
            add_bracket_after_function = true,
            dynamic_params = true,
            -- Allot of machine learning models that are set from default.
            autoImportModules = { "numpy", "matplotlib", "random", "math", "scipy" },
        },
    },

    on_new_config = function(new_config, new_root_dir)
        new_config.settings.python.pythonPath = vim.fn.exepath("python")
        print(new_config.settings.python.pythonPath)
        new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH

        local pep582 = py.pep582(new_root_dir)
        if pep582 ~= nil then
            new_config.settings.python.analysis.extraPaths = { pep582 }
        end
    end,
}

require("lspconfig").jedi_language_server.setup(jedi)
-- local use_pyright = true
-- if use_pyright then
--     require("lspconfig").pyright.setup(pyright)
-- else
--     require("lspconfig").jedi_language_server.setup(jedi)
-- end
