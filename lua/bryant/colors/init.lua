local colors = {}

-- credits to https://github.com/EdenEast/nightfox.nvim
function colors.compile_theme(theme)
    vim.g.colors_name = theme
    package.loaded["bryant.colors.highlights"] = nil
    local highlights = require "bryant.colors.highlights"
    local lines = {
        string.format(
            [[
            require"bryant.colors".compiled=string.dump(function()
                vim.g.colors_name="%s"
            ]],
            vim.g.colors_name
        ),
    }
    for group, values in pairs(highlights) do
        local options = ""
        for optionname, value in pairs(values) do
            if type(value) == "boolean" then
                value = tostring(value)
            else
                value = '"' .. value .. '"'
            end
            options = options .. optionname .. "=" .. value .. ","
        end
        table.insert(lines, string.format([[vim.api.nvim_set_hl(0,"%s", {%s})]], group, options))
    end
    local ok, highlights = pcall(require, "bryant.colors.custom." .. vim.g.colors_name)
    if ok then
        for group, values in pairs(highlights) do
            local options = ""
            for optionname, value in pairs(values) do
                if type(value) == "boolean" then
                    value = tostring(value)
                else
                    value = '"' .. value .. '"'
                end
                options = options .. optionname .. "=" .. value .. ","
            end
            table.insert(lines, string.format([[vim.api.nvim_set_hl(0,"%s", {%s})]], group, options))
        end
    end
    table.insert(lines, "end)")
    local highlight_folder = vim.fn.stdpath "cache" .. "/bryant/"
    if not vim.loop.fs_stat(highlight_folder) then
        vim.fn.mkdir(highlight_folder, "p")
    end
    local file = io.open(highlight_folder .. "highlights", "wb")
    if not file then
        print("error opening", highlight_file)
        return
    end
    loadstring(table.concat(lines, "\n"), "=")()
    file:write(require("bryant.colors").compiled)
    file:close()
end

function colors.new_theme(theme)
    vim.g.colors_name = theme
    package.loaded["bryant.colors.highlights"] = nil
    package.loaded["bryant.colors.custom"] = nil
    require("bryant.colors").compile_theme(theme)
    local highlights_raw = vim.split(vim.api.nvim_exec("filter BufferLine hi", true), "\n")
    local highlight_groups = {}
    for _, raw_hi in ipairs(highlights_raw) do
        table.insert(highlight_groups, string.match(raw_hi, "BufferLine%a+"))
    end
    for _, highlight in ipairs(highlight_groups) do
        vim.cmd([[hi clear ]] .. highlight)
    end
    package.loaded["bryant"] = nil
    package.loaded["bufferline"] = nil
    -- require("bryant.modules.bufferline").config()
    -- require("bryant.modules.heirline").config()
    loadfile(vim.fn.stdpath "cache" .. "/bryant/highlights")()
    -- require("colorscheme_switcher").new_scheme()
end

return colors
