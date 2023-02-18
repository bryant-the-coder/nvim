require("oil").setup {
    columns = {
        "icon",
        -- "permissions",
        "mtime",
    },
    buf_options = {
        buflisted = true,
    },
    -- Window-local options to use for oil buffers
    win_options = {
        wrap = true,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
    },
    -- Restore window options to previous values when leaving an oil buffer
    restore_win_options = true,
    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["c"] = "actions.cd",
        ["C"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
        show_hidden = false,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
            winblend = 10,
        },
    },
}
