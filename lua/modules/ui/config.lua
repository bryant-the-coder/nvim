local config = {}

function config.notify()
    -- Most of the setup is taken from akinsho
    local notify = require("notify")

    local border = require("custom.border").styles.type_5

    local default = {
        stages = "fade",
        timeout = 2000,
        max_width = function()
            return math.floor(vim.o.columns * 0.8)
        end,
        max_height = function()
            return math.floor(vim.o.lines * 0.8)
        end,
        icons = {
            ERROR = " ",
            WARN = " ",
            INFO = " ",
            DEBUG = " ",
            TRACE = " ",
        },
        background_colour = "#000000",
        on_open = function(win)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_config(win, { border = border })
            end
        end,
    }

    vim.opt.termguicolors = true

    notify.setup(default)

    vim.notify = function(msg, level, opts)
        notify(msg, level, opts)
    end

    function _G.P(...)
        print(vim.inspect(...))
        return ...
    end

    vim.notify = require("notify")
end

function config.neo_tree()
    require("modules.ui.neo-tree")
end

function config.blankline()
    local status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not status_ok then
        return
    end

    -- See :h indent_blankline.txt
    -- Included by default
    -- vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile", "help" }
    vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
    vim.g.indent_blankline_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "norg",
        "markdown",
    }
    vim.g.indentLine_enabled = 1
    -- vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_char = "▏"
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {
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
    }
    indent_blankline.setup({
        show_current_context = true,
        show_current_context_start = false,
    })
end

function config.hl_area()
    local status_ok, hl_match_area = pcall(require, "hl_match_area")
    if not status_ok then
        return
    end

    hl_match_area.setup({
        n_lines_to_search = 500, -- how many lines should be searched for a matching delimite
        highlight_in_insert_mode = false, -- should highlighting also be done in insert mode
        delay = 100, -- delay before the highglight
    })
end

function config.fidget()
    local status_ok, fidget = pcall(require, "fidget")
    if not status_ok then
        return
    end
    local relative = "editor"
    fidget.setup({
        text = {
            spinner = "moon",
            -- spinner = {
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            --     " ",
            -- },
            done = " ",
            commenced = " ",
            completed = " ",
        },
        align = {
            bottom = true,
            right = true,
        },
        timer = {
            spinner_rate = 100,
            fidget_decay = 500,
            task_decay = 300,
        },
        window = {
            relative = relative,
            blend = 0,
            zindex = nil,
        },
        fmt = {
            leftpad = true,
            stack_upwards = true,
            max_width = 0,
            -- function to format fidget title
            fidget = function(fidget_name, spinner)
                return string.format("%s %s", spinner, fidget_name)
            end,
            -- function to format each task line
            task = function(task_name, message, percentage)
                return string.format(
                    "%s%s [%s]",
                    message,
                    percentage and string.format(" (%s%%)", percentage) or "",
                    task_name
                )
            end,
        },
        sources = {
            ["null-ls"] = {
                ignore = true,
            },
        },
        debug = {
            logging = false,
            strict = false,
        },
    })
end

function config.heirline()
    require("modules.ui.heirline.init")
end

function config.nvim_tree()
    require("modules.ui.nvim_tree")
end

function config.barbecue()
    require("barbecue").setup({
        ---Whether to attach navic to language servers automatically.
        ---
        ---@type boolean
        attach_navic = false,

        ---Whether to create winbar updater autocmd.
        ---
        ---@type boolean
        create_autocmd = true,

        ---Buftypes to enable winbar in.
        ---
        ---@type string[]
        include_buftypes = { "" },

        ---Filetypes not to enable winbar in.
        ---
        ---@type string[]
        exclude_filetypes = { "toggleterm" },

        modifiers = {
            ---Filename modifiers applied to dirname.
            ---
            ---See: `:help filename-modifiers`
            ---
            ---@type string
            dirname = ":~:.",

            ---Filename modifiers applied to basename.
            ---
            ---See: `:help filename-modifiers`
            ---
            ---@type string
            basename = "",
        },

        ---Whether to display path to file.
        ---
        ---@type boolean
        show_dirname = false,

        ---Whether to display file name.
        ---
        ---@type boolean
        show_basename = false,

        ---Whether to replace file icon with the modified symbol when buffer is
        ---modified.
        ---
        ---@type boolean
        show_modified = false,

        ---Get modified status of file.
        ---
        ---NOTE: This can be used to get file modified status from SCM (e.g. git)
        ---
        ---@type fun(bufnr: number): boolean
        modified = function(bufnr)
            return vim.bo[bufnr].modified
        end,

        ---Whether to show/use navic in the winbar.
        ---
        ---@type boolean
        show_navic = true,

        ---Get leading custom section contents.
        ---
        ---NOTE: This function shouldn't do any expensive actions as it is run on each
        ---render.
        ---
        ---@type fun(bufnr: number): barbecue.Config.custom_section
        lead_custom_section = function()
            return " "
        end,

        ---@alias barbecue.Config.custom_section
        ---|string # Literal string.
        ---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
        ---
        ---Get custom section contents.
        ---
        ---NOTE: This function shouldn't do any expensive actions as it is run on each
        ---render.
        ---
        ---@type fun(bufnr: number): barbecue.Config.custom_section
        custom_section = function()
            return " "
        end,

        ---@alias barbecue.Config.theme
        ---|'"auto"' # Use your current colorscheme's theme or generate a theme based on it.
        ---|string # Theme located under `barbecue.theme` module.
        ---|barbecue.Theme # Same as '"auto"' but override it with the given table.
        ---
        ---Theme to be used for generating highlight groups dynamically.
        ---
        ---@type barbecue.Config.theme
        theme = "auto",

        ---Whether context text should follow its icon's color.
        ---
        ---@type boolean
        context_follow_icon_color = false,

        symbols = {
            ---Modification indicator.
            ---
            ---@type string
            modified = "●",

            ---Truncation indicator.
            ---
            ---@type string
            ellipsis = "…",

            ---Entry separator.
            ---
            ---@type string
            separator = "",
        },

        ---@alias barbecue.Config.kinds
        ---|false # Disable kind icons.
        ---|table<string, string> # Type to icon mapping.
        ---
        ---Icons for different context entry kinds.
        ---
        ---@type barbecue.Config.kinds
        kinds = {
            File = " ",
            Module = " ",
            Namespace = " ",
            Package = " ",
            Class = " ",
            Method = " ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = " ",
            Interface = " ",
            Function = " ",
            Variable = " ",
            Constant = " ",
            String = " ",
            Number = " ",
            Boolean = " ",
            Array = " ",
            Object = " ",
            Key = " ",
            Null = " ",
            EnumMember = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " ",
        },
    })
end

return config
