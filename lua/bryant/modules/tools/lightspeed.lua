local default_keymaps = {
    { "n", "s", "<Plug>Lightspeed_omni_s" },
    { "x", "s", "<Plug>Lightspeed_omni_s" },
    { "o", "s", "<Plug>Lightspeed_omni_s" },
}
for _, m in ipairs(default_keymaps) do
    vim.keymap.set(m[1], m[2], m[3], { noremap = true, silent = true })
end

require("lightspeed").setup {
    ignore_case = false,
    exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
    --- s/x ---
    jump_to_unique_chars = { safety_timeout = 400 },
    match_only_the_start_of_same_char_seqs = true,
    force_beacons_into_match_width = true,
    -- Display characters in a custom way in the highlighted matches.
    substitute_chars = { ["\r"] = "¬" },
    -- Leaving the appropriate list empty effectively disables "smart" mode,
    -- and forces auto-jump to be on or off.
    -- These keys are captured directly by the plugin at runtime.
    special_keys = {
        next_match_group = "<space>",
        prev_match_group = "<tab>",
    },
    --- f/t ---
    limit_ft_matches = nil,
    repeat_ft_with_target_char = false,
}
