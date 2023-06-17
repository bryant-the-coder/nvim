local lspconfig = require("lspconfig")

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
    tsserver = {},
    vimls = {},
    bashls = {},
    jsonls = {},
    texlab = {
        texlab = {
            auxDirectory = "build",
            bibtexFormatter = "texlab",
            build = {
                executable = "latexmk",
                args = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "%f",
                },
                on_save = true,
                forward_search_after = false,
            },
            chktex = {
                on_open_and_save = false,
                on_edit = false,
            },
            forward_search = {
                executable = nil,
                args = {},
            },
            latexindent = {
                ["local"] = nil,
                modify_line_breaks = false,
            },
            diagnostics = {
                virtual_text = { spacing = 0, prefix = "" },
                signs = true,
                underline = true,
            },
            linters = { "chktex" },
            auto_save = false,
            ignore_errors = {},
            diagnosticsDelay = 300,
            formatterLineLength = 120,
            latexFormatter = "latexindent",
        }
    },
    gopls = {},
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
                diagnosticmode = "openfilesonly",
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
    settings = {
        python = {
            analysis = {
                indexing = true,
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                },
                stubPath = vim.fn.expand("$HOME/typings"),
                diagnosticSeverityOverrides = {
                    reportMissingTypeStubs = "information",
                    reportGeneralTypeIssues = "warning",
                    reportUnboundVariable = "warning",
                    reportUndefinedVariable = "error",
                    reportUnknownMemberType = "information",
                    reportUnknownVariableType = "information",
                    reportUntypedClassDecorator = "none",
                    reportUntypedFunctionDecorator = "none",
                    reportFunctionMemberAccess = "warning",
                    reportUnknownArgumentType = "warning",
                    reportUnknownParameterType = "warning",
                    reportUnknownLambdaType = "warning",
                    reportUnusedImport = "information",
                    reportUnusedFunction = "information",
                    reportUnusedVariable = "information",
                    reportUnusedClass = "information",
                    strictParameterNoneValue = false,
                    reportOptionalSubscript = "warning",
                    reportOptionalMemberAccess = "warning",
                    reportOptionalIterable = "warning",
                    reportOptionalCall = "none",
                },
            },
        },
    },
}

local use_pyright = true
if use_pyright then
    require("lspconfig").pyright.setup(pyright)
else
    require("lspconfig").jedi_language_server.setup(jedi)
end
