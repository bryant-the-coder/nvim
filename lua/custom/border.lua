-- Taken from https://github.com/vsedov/nvim/blob/master/lua/core/lambda/styles.lua#L28
local border = {}

border.styles = {
    type_0 = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
    type_1 = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    type_3 = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    type_4 = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
    type_5 = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
}

return border
