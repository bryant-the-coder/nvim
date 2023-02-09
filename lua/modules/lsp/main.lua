local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- Load lua-dev because i am lazyloading it
-- require("lazy").load "lua-dev.nvim"

-- WARN: Dont remove this files
require "modules.lsp.installer"
require "modules.lsp.config"
local capabilities = require "modules.lsp.capabilities"

-- Creating a function call on_attach
local function on_attach(client, bufnr)
    require("modules.lsp.on_attach").setup(client, bufnr)
end

local function on_attach_16(client, bufnr)
    require("modules.lsp.on_attach").setup(client, bufnr)
end

lspconfig.tsserver.setup {}
lspconfig.vimls.setup {}
lspconfig.bashls.setup {}

-- sumneko_lua
local sumneko = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                workspaceWord = true,
                callSnippet = "Both",
            },
            misc = {
                parameters = {
                    "--log-level=trace",
                },
            },
            diagnostics = {
                globals = { "vim" },
                -- enable = false,
                groupSeverity = {
                    strong = "Warning",
                    strict = "Warning",
                },
                groupFileStatus = {
                    ["ambiguity"] = "Opened",
                    ["await"] = "Opened",
                    ["codestyle"] = "None",
                    ["duplicate"] = "Opened",
                    ["global"] = "Opened",
                    ["luadoc"] = "Opened",
                    ["redefined"] = "Opened",
                    ["strict"] = "Opened",
                    ["strong"] = "Opened",
                    ["type-check"] = "Opened",
                    ["unbalanced"] = "Opened",
                    ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
            },
            format = {
                enable = false,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent_size = "2",
                },
            },
        },
    },
}
local use_lua_dev = true
if use_lua_dev then
    local luadev = require("lua-dev").setup {
        library = {
            vimruntime = true,
            types = true,
            plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        lspconfig = sumneko,
    }

    lspconfig.sumneko_lua.setup(luadev)
else
    lspconfig.sumneko_lua.setup(sumneko)
end

-- JSON
lspconfig.jsonls.setup {
    on_attach = on_attach,
}

require("lspconfig").texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = true,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = true,
            },
            diagnosticsDelay = 100,
            formatterLineLength = 100,
            forwardSearch = {
                args = {},
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
}

local pyright = {
    on_attach = on_attach,
    capabilities = capabilities,
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
                stubpath = vim.fn.expand "$home/typings",
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
    capabilities = capabilities,
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
                stubPath = vim.fn.expand "$HOME/typings",
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
    lspconfig.pyright.setup(pyright)
else
    lspconfig.jedi_language_server.setup(jedi)
end
