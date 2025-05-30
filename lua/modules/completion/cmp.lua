local present, cmp = pcall(require, "cmp")
if not present then
    return
end

-- luasnip
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local luasnip = require("luasnip")

local icons = require("custom.icons")
local kind_icons = icons.kind

local border = require("custom.border").styles.type_5

cmp.setup({
    window = {
        completion = {
            border = border,
            scrollbar = "┃",
            -- scrollbar = "║",
        },
        documentation = {
            border = border,
            -- scrollbar = "║",
            scrollbar = "┃",
        },
    },
    experimental = {
        ghost_text = true,
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Insert,
            }),
            c = cmp.mapping.confirm({
                select = false,
                behavior = cmp.ConfirmBehavior.Select,
            }),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sorting = {
        --[[ comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            -- require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        }, ]]
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find("^_+")
                local _, entry2_under = entry2.completion_item.label:find("^_+")
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    -- formatting = {
    --     -- fields = { "kind", "abbr", "menu" },
    --     --[[ format = function(entry, vim_item)
    --         local icons = require("custom.icons").lspkind
    --         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
    --         vim_item.menu = ({
    --             buffer = "[BUF]",
    --             nvim_lsp = "[LSP]",
    --             nvim_lua = "[API]",
    --             path = "[PATH]",
    --             luasnip = "[SNIP]",
    --             npm = "[NPM]",
    --             neorg = "[NEORG]",
    --         })[entry.source.name]
    --         return vim_item
    --     end, ]]
    --     -- fields = { "abbr", "kind", "menu" },
    --     -- format = function(_, vim_item)
    --     ---    local icons = require("custom.icons").lspkind
    --     --     vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
    --     --    return vim_item
    --     -- end,
    --     fields = { "kind", "menu", "abbr" },
    --     format = function(_, vim_item)
    --         vim_item.kind = string.format("%s", kind_icons[vim_item.kind], vim_item.kind, " %s")
    --         return vim_item
    --     end,
    -- },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (kind_icons[vim_item.kind] or "") .. vim_item.kind
            return vim_item
        end,
    },
    sources = cmp.config.sources({
        -- { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", priority = "9" },
        { name = "nvim_lsp_signature_help", priority = "7" },
        { name = "luasnip", priority = "8" },
        { name = "buffer", keyword_length = 5 },
        { name = "npm", keyword_length = 2 },
        { name = "neorg" },
        { name = "path" },
        { name = "git" },
        { name = "crates" },
    }),
    enabled = function()
        if vim.bo.buftype == "prompt" then
            return false
        end
        -- disable completion in comments
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,
})

--[[ cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline", group_index = 1 },
        -- { name = "cmdline" },
        { name = "cmdline_history", group_index = 2 },
    },
    view = {
        entries = { name = "wildmenu", separator = " | " },
    },
}) ]]
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline_history" },
        { name = "buffer" },
    },
    view = {
        entries = { name = "wildmenu", separator = " | " },
    },
})
