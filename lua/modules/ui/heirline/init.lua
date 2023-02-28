-- Credits: https://github.com/vsedov/nvim/blob/master/lua/modules/ui/heirline.lua
-- Credits: https://github.com/max397574/omega-nvim/blob/feat/make_usable_for_outsiders/lua/omega/modules/ui/heirline/round_blended.lua

local use_dev_icons = false
local conditions = require("heirline.conditions")
local utilities = require("heirline.utils")
local utils = require("heirline.utils")
local colors = require("core.utils").get()
local base = require("core.utils").get_base()
local fn = vim.fn
local api = vim.api
local fmt = string.format
local align = { provider = "%=" }
local space = { provider = " " }

local mode_colors = {
    n = colors.green,
    i = colors.nord_blue,
    v = colors.purple,
    V = colors.purple,
    ["^V"] = colors.purple,
    c = colors.teal,
    s = vim.g.terminal_color_3,
    S = vim.g.terminal_color_3,
    ["^S"] = colors.yellow,
    R = colors.yellow,
    r = colors.yellow,
    ["!"] = colors.light_grey,
    t = colors.red,
}

local file_icons = {
    typescript = " ",
    json = " ",
    jsonc = " ",
    tex = "ﭨ ",
    ts = " ",
    python = " ",
    py = " ",
    java = " ",
    html = " ",
    css = " ",
    scss = " ",
    javascript = " ",
    js = " ",
    javascriptreact = " ",
    markdown = " ",
    md = " ",
    sh = " ",
    zsh = " ",
    vim = " ",
    rust = " ",
    rs = " ",
    cpp = " ",
    c = " ",
    go = " ",
    lua = " ",
    conf = " ",
    haskel = " ",
    hs = " ",
    ruby = " ",
    norg = " ",
    txt = " ",
}

local Mode = {
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,

        static = {
            mode_names = { -- change the strings if you like it vvvvverbose!
                n = "NORMAL",
                no = "NORMAL",
                v = "VISUAL",
                V = "VISUAL LINE",
                [""] = "VISUAL BLOCK",
                s = "SELECT",
                S = "SELECT LINE",
                [""] = "SELECT BLOCK",
                i = "INSERT",
                ic = "INSERT",
                R = "REPLACE",
                Rv = "VISUAL REPLACE",
                c = "COMMAND",
                cv = "VIM EX",
                ce = "EX",
                r = "PROMPT",
                rm = "MOAR",
                ["r?"] = "?",
                ["!"] = "!",
                t = "TERMINAL",
            },
        },
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return {
                fg = mode_colors[mode] or colors.blue,
                -- fg = colors.black,
            }
        end,
        provider = function(self)
            -- return "%2(" .. self.mode_names[self.mode:sub(1, 1)] .. "%)" .. " "
            return string.format(" %s ", self.mode_names[self.mode:sub(1, 1)]):upper()
        end,
    },
}

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    { -- git branch name
        provider = function(self)
            return "  " .. self.status_dict.head .. " "
        end,
        -- hl = { fg = "#181a1f", bg = "#ff69b4", italic = true },
        hl = { italic = true, fg = colors.pink },
    },
}

local Search_count = {
    provider = function(self)
        local res = vim.fn.searchcount({ recomput = 1, maxcount = 1000 })

        if res.total ~= nil and res.total > 0 then
            return string.format(
                " 爵%s/%d %s ",
                -- ' %s/%d %s ',
                res.current,
                res.total,
                vim.fn.getreg("/")
            )
        else
            return ""
        end
    end,
    hl = { fg = base.base0E },
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local FileName = {
    provider = function(self)
        local icon = ""
        local filename = fn.pathshorten(fn.expand("%:t"), ":r")
        -- local filename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ":."))
        local extension = fn.expand("%:e")

        if filename == "" then
            icon = icon .. "  Empty "
        else
            filename = " " .. filename .. " "
        end

        local devicons_present, devicons = pcall(require, "nvim-web-devicons")

        if not devicons_present then
            return " "
        end

        local ft_icon = devicons.get_icon(filename, extension)
        icon = (ft_icon ~= nil and " " .. ft_icon) or icon

        -- return icon .. filename
        return filename
    end,
    hl = { fg = colors.white },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = colors.white },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = colors.white },
    },
}

local WorkDir = {
    {
        provider = function()
            return " 󰉋"
        end,
        hl = function(_)
            return { fg = colors.green }
        end,
    },
    {
        provider = function()
            local cwd = vim.fn.getcwd(0)
            cwd = vim.fn.fnamemodify(cwd, ":~")
            cwd = vim.fn.pathshorten(cwd)
            local trail = cwd:sub(-1) == "/" and "" or "/"
            local filename = fn.pathshorten(fn.expand("%:t"), ":r")
            -- local filename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ":."))
            local extension = fn.expand("%:e")
            return " " .. cwd .. trail .. filename .. " "
        end,
        hl = { fg = colors.white },
    },
}

local TerminalName = {
    -- icon = ' ', -- 
    {
        provider = function()
            local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
            return " " .. tname
        end,
        hl = { fg = colors.blue, bold = true },
    },
    { provider = " - " },
    {
        provider = function()
            return vim.b.term_title
        end,
    },
    {
        provider = function()
            return " "
        end,
        hl = { fg = colors.blue, italic = true },
    },
}

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = "Type",
}

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = colors.red, bold = true },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = colors.yellow, bold = true },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = colors.green, bold = true },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
        end,
        hl = { fg = colors.purple, bold = true },
    },
}

local Clock = {
    {
        provider = function()
            return " 󱑒 " .. os.date("%H:%M ")
        end,
        hl = { fg = colors.cyan },
    },
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = colors.white, bg = colors.black },
}

local inactive_statusline = {
    condition = function()
        return not conditions.is_active()
    end,
    WorkDir,
    FileName,
}

local default_statusline = {
    condition = conditions.is_active,
    -- { flexible = 5, WorkDir },
    Mode,
    Git,
    WorkDir,
    FileFlags,
    align,
    Diagnostics,
    Search_count,
    Clock,
}

local help_file_line = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,
    FileType,
    { provider = "%q" },
    space,
    HelpFileName,
    align,
}

local startup_nvim_statusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "startup", "TelescopePrompt" },
        })
    end,
    align,
}

local GitStatusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "^git.*", "fugitive" },
        })
    end,
    FileType,
    space,
    {
        provider = function()
            return vim.fn.FugitiveStatusline()
        end,
    },
    space,
    align,
}

local TerminalStatusline = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    align,
}

local Statuslines = {
    fallthrough = false,

    startup_nvim_statusline,
    help_file_line,
    inactive_statusline,
    default_statusline,
    -- TerminalStatusline,
    GitStatusline,
}

require("heirline").setup({
    statusline = Statuslines,
})
