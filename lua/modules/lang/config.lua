local config = {}

function config.trouble()
    local status_ok, trouble = pcall(require, "trouble")
    if not status_ok then
        return
    end

    trouble.setup({
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        auto_jump = { "lsp_definitions" },
        auto_fold = true,
        use_diagnostic_signs = true,
    })
end

function config.dap_ui()
    require("modules.lang.debugger.dap_ui")
end

function config.dap_py()
    require("modules.lang.debugger.dap_py")
end

function config.dap()
    require("modules.lang.debugger.dap")
end

return config
