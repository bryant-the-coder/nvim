local config = {}

function config.notify()
    -- Most of the setup is taken from akinsho
    local notify = require "notify"

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

    vim.notify = require "notify"
end

function config.neo_tree()
    require "modules.ui.neo-tree"
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
    indent_blankline.setup {
        show_current_context = true,
        show_current_context_start = false,
    }
end

function config.hl_area()
    local status_ok, hl_match_area = pcall(require, "hl_match_area")
    if not status_ok then
        return
    end

    hl_match_area.setup {
        n_lines_to_search = 500, -- how many lines should be searched for a matching delimite
        highlight_in_insert_mode = false, -- should highlighting also be done in insert mode
        delay = 100, -- delay before the highglight
    }
end

function config.fidget()
    local status_ok, fidget = pcall(require, "fidget")
    if not status_ok then
        return
    end
    local relative = "editor"
    fidget.setup {
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
    }
end

return config
