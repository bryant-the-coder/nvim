local config = {}

function config.neogen()
    local present, neogen = pcall(require, "neogen")
    if not present then
        return
    end

    neogen.setup {
        snippet_engine = "luasnip",
        enabled = true,
        languages = {
            lua = {
                template = { annotation_convention = "emmylua" },
            },
            python = {
                template = { annotation_convention = "numpydoc" },
            },
        },
    }
end

function config.browse()
    local browse = require "browse"
    local bookmarks = {
        ["github"] = {
            ["name"] = "search github from neovim",
            ["code_search"] = "https://github.com/search?q=%s&type=code",
            ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
            ["issues_search"] = "https://github.com/search?q=%s&type=issues",
            ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
        },
    }
    browse.setup {
        -- search provider you want to use
        provider = "duckduckgo", -- duckduckgo, bing, google

        -- either pass it here or just pass the table to the functions
        -- see below for more
        bookmarks = bookmarks,
    }
end

return config
