local present, tree = pcall(require, "neo-tree")
if not present then
    return
end

vim.g.neo_tree_remove_legacy_commands = 1

tree.setup({
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
    },
    source_selector = {
        winbar = true,
        separator_active = " ",
    },
    open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "Outline",
        "Vista",
        "edgy",
    },
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "solid", -- "double", "none", "rounded", "shadow", "single" or "solid
    enable_git_status = true,
    enable_diagnostics = true,
    git_status_async = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            default = "*",
            highlight = "NeoTreeFileIcon",
        },
        modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = "✖", -- this can only be used in the git_status source
                renamed = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "",
                staged = "",
                conflict = "",
            },
        },
    },
    window = {
        position = "right",
        width = 30,
        mappings = {
            ["<space>"] = "toggle_node",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<c-s>"] = "open_split",
            ["<c-v>"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["a"] = "add",
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination
            ["m"] = "move", -- takes text input for destination
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["e"] = function()
                vim.api.nvim_exec("Neotree focus filesystem left", true)
            end,
            ["b"] = function()
                vim.api.nvim_exec("Neotree focus buffers left", true)
            end,
            ["g"] = function()
                vim.api.nvim_exec("Neotree focus git_status left", true)
            end,
        },
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
                ".DS_Store",
                "thumbs.db",
                --"node_modules"
            },
        },
        follow_current_file = {
            enabled = true,
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default",
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["<C-h>"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
            },
        },
    },
    buffers = {
        follow_current_file = {
            enabled = true,
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
            },
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            },
        },
    },
})
