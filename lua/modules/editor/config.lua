local config = {}

function config.commit()
    local present, Comment = pcall(require, "Comment")
    if not present then
        return
    end

    Comment.setup({
        padding = true,
        sticky = true,
        ignore = "^$",
        toggler = {
            line = "gcc",
            block = "gcb",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        -- with nvim-ts-context-commentstring
        pre_hook = function(ctx)
            local U = require("Comment.utils")

            local location = nil
            if ctx.ctype == U.ctype.block then
                location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
                key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                location = location,
            })
        end,
    })
end

function config.comment_box()
    require("comment-box").setup({
        doc_width = 80, -- width of the document
        box_width = 70, -- width of the boxes
        borders = {
            -- symbols used to draw a box
            top = "─",
            bottom = "─",
            left = "│",
            right = "│",
            top_left = "╭",
            top_right = "╮",
            bottom_left = "╰",
            bottom_right = "╯",
        },
        line_width = 70, -- width of the lines
        line = {
            -- symbols used to draw a line
            line = "─",
            line_start = "─",
            line_end = "─",
        },
        outer_blank_lines = false, -- insert a blank line above and below the box
        inner_blank_lines = false, -- insert a blank line above and below the text
        line_blank_line_above = false, -- insert a blank line above the line
        line_blank_line_below = false, -- insert a blank line below the line
    })
end

function config.hydra()
    require("modules.editor.hydra")
end

function config.venn()
    -- venn.nvim: enable or disable keymappings
    function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
            vim.b.venn_enabled = true
            vim.cmd([[setlocal ve=all]])
            -- draw a line on HJKL keystokes
            vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
            -- draw a box by pressing "f" with visual selection
            vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
            vim.cmd([[setlocal ve=]])
            vim.cmd([[mapclear <buffer>]])
            vim.b.venn_enabled = nil
        end
    end

    -- toggle keymappings for venn using <leader>v
    vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
end

function config.comment()
    local present, Comment = pcall(require, "Comment")
    if not present then
        return
    end

    Comment.setup({
        padding = true,
        sticky = true,
        ignore = "^$",
        toggler = {
            line = "gcc",
            block = "gcb",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
    })
end

function config.ts_context_commentstring()
    require("ts_context_commentstring").setup({
        enable_autocmd = false,
    })
end

function config.todo()
    local present, todo = pcall(require, "todo-comments")
    if not present then
        return
    end

    todo.setup({
        signs = false, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info", alt = { "REVIST", "todo", "Todo", "TODO" } },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warning", "warn", "WARN", "Warn" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "optimize", "Optimize" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "Info" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
            before = "", -- "fg" or "bg" or empty
            keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
    })
end

function config.discord()
    require("presence"):setup({
        -- General options
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "Neovim the supremeleader", -- Text displayed when hovered over the Neovim image
        main_image = "neovim", -- Main image display (either "neovim" or "file")
        client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
        log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project
        blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time = true, -- Show the timer
        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    })
end

return config
