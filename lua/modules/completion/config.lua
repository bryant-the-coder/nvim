local config = {}

function config.cmp()
    require "modules.completion.cmp"
end

function config.cmp_git()
    require "modules.completion.cmp_git"
end

function config.nvim_autopairs()
    local status_ok, npairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        return
    end

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp = require "cmp"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    npairs.setup {
        check_ts = true,
        -- enable_check_bracket_line = true,
    }
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

function config.autopair()
    return {
        bs = {
            enable = true,
            overjump = true,
            space = true,
            multichar = true,
            fallback = nil,
        },
        cr = {
            enable = true,
            autoclose = false,
            multichar = {
                enable = false,
                markdown = { { "```", "```", pair = true, noalpha = true, next = true } },
                lua = { { "then", "end" }, { "do", "end" } },
            },
            addsemi = { "c", "cpp", "rust" },
            fallback = nil,
        },
        fastwarp = {
            enable = true,
            hopout = true,
            map = "<c-c>",
            rmap = "<C-E>",
            Wmap = "<C-e>",
            cmap = "<c-e>",
            rcmap = "<c-E>",
            Wcmap = "<c-e>",
            multiline = true,
            fallback = nil,
        },
        fastend = {
            enable = true,
            map = "<c-;>",
            cmap = "<c-;>",
            smart = true,
            fallback = nil,
        },
    }
end

return config
