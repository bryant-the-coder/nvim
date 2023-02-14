local status_ok, hl_match_area = pcall(require, "hl_match_area")
if not status_ok then
    return
end

hl_match_area.setup {
    n_lines_to_search = 500, -- how many lines should be searched for a matching delimite
    highlight_in_insert_mode = false, -- should highlighting also be done in insert mode
    delay = 100, -- delay before the highglight
}
