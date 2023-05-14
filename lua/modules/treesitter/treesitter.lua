local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

local incremental_selection = require("nvim-treesitter.incremental_selection")
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

local langs = {
    "lua",
    "json",
    "rust",
    "norg",
    "norg_meta",
    "norg_table",
    "toml",
    "html",
    "javascript",
    "scss",
    "python",
    "cpp",
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main",
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main",
    },
}
require("nvim-treesitter.install").compilers = { "clang", "gcc" }
treesitter.setup({
    ensure_installed = langs,
    sync_install = true,
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = false,
    },
    autotag = {
        enable = true,
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    -- query_linter = {
    --    enable = true,
    --    use_virtual_text = true,
    --    lint_events = { "BufWrite", "CursorHold" },
    -- },
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
})
