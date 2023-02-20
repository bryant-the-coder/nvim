local default = {
    colors = require("core.utils").get(),
}

vim.cmd [[
 function! Quit_vim(a,b,c,d)
     wqa
 endfunction
]]

-- Code from NvChad
require("bufferline").setup {
    options = {
        hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
        },
        numbers = "none",
        themable = true,
        close_command = "bdelete! %d",
        right_mouse_command = "sbuffer %d",
        middle_mouse_command = "vertical sbuffer %d",
        indicator = {
            icon = "▎",
            style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        view = "multiwindow",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     return "(" .. count .. ")"
        -- end,
        offsets = { { filetype = "NvimTree", text = "" } },
        separator_style = "thin",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        custom_filter = function(buf_number)
            -- Func to filter out our managed/persistent split terms
            local present_type, type = pcall(function()
                return vim.api.nvim_buf_get_var(buf_number, "term_type")
            end)

            if present_type then
                if type == "vert" then
                    return false
                elseif type == "hori" then
                    return false
                end
                return true
            end

            return true
        end,

        custom_areas = {
            right = function()
                -- Have an icon that u can click to exit vim
                return {
                    { text = "%@Quit_vim@  %X" },
                }
            end,
        },
    },
    -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
    --[[ highlights = {
        background = {
            fg = default.colors.mantle,
            bg = default.colors.black2,
        },

        -- buffers
        -- buffer_selected = {
        --     fg = default.colors.white,
        --     bg = default.colors.black,
        --     gui = "bold,italic",
        -- },
        -- buffer_visible = {
        --     fg = default.colors.light_grey,
        --     bg = default.colors.black2,
        --     gui = "bold,italic",
        -- },
        -- duplicate_visible = {
        --     fg = default.colors.white,
        --     bg = default.colors.black2,
        --     gui = "bold,italic",
        -- },

        -- for diagnostics = "nvim_lsp"
        error = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        error_diagnostic = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },

        -- close buttons
        close_button = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        close_button_visible = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        close_button_selected = {
            fg = default.colors.red,
            bg = default.colors.black,
        },
        -- fill = {
        --     fg = default.colors.grey_fg,
        --     bg = "NONE",
        -- },
        indicator_selected = {
            fg = default.colors.black,
            bg = default.colors.black,
        },

        -- modified
        modified = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        modified_visible = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        modified_selected = {
            fg = default.colors.green,
            bg = default.colors.black,
        },

        -- separators
        separator = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },
        separator_visible = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },
        separator_selected = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },

        -- tabs
        tab = {
            fg = default.colors.light_grey,
            bg = default.colors.one_bg3,
        },
        tab_selected = {
            fg = default.colors.black2,
            bg = default.colors.nord_blue,
        },
        tab_close = {
            fg = default.colors.red,
            bg = default.colors.black,
        },
    }, ]]
    highlights = {
        background = {
            bg = default.colors.mantle,
        },

        -- buffers
        buffer_selected = {
            fg = default.colors.white,
            bg = default.colors.black,
            -- gui = "bold,italic",
            bold = true,
            italic = true,
        },
        buffer_visible = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
            bold = true,
            italic = true,
        },
        duplicate_selected = {
            fg = default.colors.white,
            bg = default.colors.black,
            bold = true,
            italic = true,
        },
        duplicate_visible = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
            bold = true,
            italic = true,
        },
        duplicate = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
            bold = true,
            italic = true,
        },

        -- for diagnostics = "nvim_lsp"
        error = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        error_diagnostic = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        error_visible = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        error_selected = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        error_diagnostic_visible = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        error_diagnostic_selected = {
            fg = default.colors.red,
            bg = default.colors.black,
        },

        warning = {
            fg = default.colors.yellow,
            bg = default.colors.black2,
        },
        warning_visible = {
            fg = default.colors.yellow,
            bg = default.colors.black2,
        },
        warning_selected = {
            fg = default.colors.yellow,
            bg = default.colors.black2,
        },
        warning_diagnostic = {
            fg = default.colors.yellow,
            bg = default.colors.black2,
        },
        warning_diagnostic_visible = {
            fg = default.colors.yellow,
            bg = default.colors.black2,
        },
        warning_diagnostic_selected = {
            fg = default.colors.yellow,
            bg = default.colors.black,
        },

        info = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black2,
        },
        info_visible = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black2,
        },
        info_selected = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black2,
        },
        info_diagnostic = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black2,
        },
        info_diagnostic_visible = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black2,
        },
        info_diagnostic_selected = {
            fg = default.colors.vibrant_green,
            bg = default.colors.black,
        },

        hint = { fg = default.colors.teal, bg = default.colors.black2 },
        hint_visible = { fg = default.colors.teal, bg = default.colors.black2 },
        hint_selected = { fg = default.colors.teal, bg = default.colors.black2 },
        hint_diagnostic = { fg = default.colors.teal, bg = default.colors.black2 },
        hint_diagnostic_visible = { fg = default.colors.teal, bg = default.colors.black2 },
        hint_diagnostic_selected = { fg = default.colors.teal, bg = default.colors.black },

        -- close buttons
        close_button = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        close_button_visible = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        close_button_selected = {
            fg = default.colors.red,
            bg = default.colors.black,
        },
        --[[ fill = {
            fg = default.colors.grey_fg,
            bg = "NONE",
        }, ]]
        indicator_selected = {
            fg = default.colors.sun,
            bg = default.colors.black,
        },

        -- modified
        modified = {
            fg = default.colors.sun,
            bg = default.colors.black2,
        },
        modified_selected = {
            fg = default.colors.sun,
            bg = default.colors.black,
        },

        -- separators
        separator = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        separator_visible = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        separator_selected = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },

        -- tabs
        tab = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        tab_selected = {
            fg = default.colors.vibrant_green,
            bg = default.colors.base,
        },
        tab_close = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        tab_separator = {
            fg = default.colors.one_bg2,
            bg = default.colors.black2,
        },
        tab_separator_selected = {
            fg = default.colors.baby_pink,
            bg = default.colors.black,
        },
    },
}
