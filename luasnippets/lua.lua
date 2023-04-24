---@diagnostic disable: undefined-global
local module = [[
local $1 = {}

${0:local test = "test}

return $1
]]

local nmap = [[
map("n", "$1", "$0")
]]

local imap = [[
map("i", "$1", "$0")
]]

local status = [[
local status_ok, ${1:module_var_name} = pcall(require, "${2:module_name}")
if not status_ok then
    return
end
]]

return {
    parse({ trig = "M" }, module),
    parse({ trig = "nmap" }, nmap),
    parse({ trig = "imap" }, imap),
    parse({ trig = "status" }, status),
    s(
        {
            trig = "if",
            condition = function()
                local ignored_nodes = { "string", "comment" }

                local pos = vim.api.nvim_win_get_cursor(0)
                -- Use one column to the left of the cursor to avoid a "chunk" node
                -- type. Not sure what it is, but it seems to be at the end of lines in
                -- some cases.
                local row, col = pos[1] - 1, pos[2] - 1

                local node_type = vim.treesitter
                    .get_node({
                        pos = { row, col },
                    })
                    :type()

                return not vim.tbl_contains(ignored_nodes, node_type)
            end,
        },
        fmt(
            [[
        if {} then
            {}
        end
        ]],
            { i(1), i(2) }
        )
    ),
}
