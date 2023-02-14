local neogit = require "neogit"

neogit.setup {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    kind = "tab",
    console_timeout = 2000,
    auto_show_console = true,
    commit_popup = {
        kind = "split",
    },
    popup = {
        kind = "split",
    },
    signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
    },
    integrations = {
        diffview = true,
    },
    mappings = {
        status = {
            -- To override lightspeed "s" keybinding
            ["s"] = "Stage",
            ["p"] = "PushPopup",
            ["P"] = "PullPopup",
        },
    },
}
