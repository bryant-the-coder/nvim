local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

vim.g.indentLine_enabled = 1
indent_blankline.setup {
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "norg",
        "NvimTree",
        "Trouble",
    },
    char = "▏",
    context_char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = true,
    context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^do",
        "^switch",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
    },
}
-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"
