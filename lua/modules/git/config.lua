local config = {}

function config.neogit()
    local neogit = require("neogit")

    neogit.setup({
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
                ["<Space>"] = "Stage",
                ["p"] = "PushPopup",
                ["P"] = "PullPopup",
            },
        },
    })
end

function config.gitsigns()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
        return
    end

    gitsigns.setup({
        debug_mode = true,
        max_file_length = 1000000000,
        numhl = true,
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
    })
end

function config.diffview()
    local actions = require("diffview.actions")

    require("diffview").setup({
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        icons = {
            -- Only applies when use_icons is true.
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
        },
        file_panel = {
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = {
                -- Only applies when listing_style is 'tree'
                flatten_dirs = true, -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
            win_config = {
                -- See ':h diffview-config-win_config'
                position = "left",
                width = 35,
            },
        },
        file_history_panel = {
            log_options = {
                -- See ':h diffview-config-log_options'
                git = {
                    single_file = {
                        diff_merges = "combined",
                    },
                    multi_file = {
                        diff_merges = "first-parent",
                    },
                },
                hg = {
                    single_file = {},
                    multi_file = {},
                },
            },
            win_config = {
                -- See ':h diffview-config-win_config'
                position = "bottom",
                height = 16,
                win_opts = {},
            },
        },
        commit_log_panel = {
            win_config = {}, -- See ':h diffview-config-win_config'
        },
        default_args = {
            -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
    })
end

return config
