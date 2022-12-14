local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup {
    debug_mode = true,
    max_file_length = 1000000000,
    signs = {
        add = { show_count = false, text = "│" },
        change = { show_count = false, text = "│" },
        delete = { show_count = true, text = "ﬠ" },
        topdelete = { show_count = true, text = "ﬢ" },
        changedelete = { show_count = true, text = "┊" },
    },
    preview_config = {
        border = "rounded",
    },
    current_line_blame = true,
    current_line_blame_formatter = "  : <author> | <author_time:%m-%d-%Y | %X> | <summary>",
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
    current_line_blame_opts = {
        delay = 0,
    },
    count_chars = {
        "⒈",
        "⒉",
        "⒊",
        "⒋",
        "⒌",
        "⒍",
        "⒎",
        "⒏",
        "⒐",
        "⒑",
        "⒒",
        "⒓",
        "⒔",
        "⒕",
        "⒖",
        "⒗",
        "⒘",
        "⒙",
        "⒚",
        "⒛",
    },
    _refresh_staged_on_update = false,
    watch_gitdir = { interval = 1000, follow_files = true },
    sign_priority = 6,
    status_formatter = nil, -- Use default
    update_debounce = 0,
    word_diff = false,
    diff_opts = { internal = true },
}
