require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Uses ruff. If ruff unavailable, use isort and black
        python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_format", "ruff_organize_imports", "docformatter" }
            else
                return { "isort", "black", "docformatter" }
            end
        end,
        -- python = { "isort", "black", "docformatter" },
        rust = { "rustfmt", lsp_format = "fallback" },
        cpp = { "clang-format" },
    },

    format_on_save = {
        -- timeout_ms = 200,
        -- async = true,
        lsp_format = "fallback",
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
