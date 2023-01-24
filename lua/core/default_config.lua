local config = {}

config.plugins = {
    -- INFO: Dont disable this
    -- They are dependencies
    plenary = true,
    icons = true,
    base16 = true,
    nui = true,

    -----------------------------------
    --              Theme            --
    -----------------------------------
    catppuccin = true,
    everblush = true,
    tokyonight = true,

    -----------------------------------
    --           Completion          --
    -----------------------------------
    cmp = true,
    cmp_luasnip = true,
    cmp_lsp = true,
    cmp_buffer = true,
    cmp_path = true,
    cmp_git = true,
    luasnip = true,
    friendly_snippets = true,
    autopairs = true,

    -----------------------------------
    --             Editor            --
    -----------------------------------
    hl_match_area = true,
    comment = true,
    commentstring = true,
    neorg = true,

    -----------------------------------
    --              Files            --
    -----------------------------------
    neotree = true,
    harpoon = true,
    telescope = true,
    telescope_fzf_native = true,
    telescope_file_browser = true,
    telescope_ui_select = true,
    formatter = false,
    neogen = true,
    null = true,
    treesitter = true,
    ts_rainbow = true,
    autotag = false,
    playground = true,
    ts_context = true,
    trouble = false,
    lsp = true,
    lsp_installer = true,
    inlay = false,
    lua_dev = true,
    clangd_ext = true,
    rust_analyzer = true,
    crates = true,
    lsp_signature = true,
    lspsaga = true,

    -----------------------------------
    --              Git              --
    -----------------------------------
    gitsigns = true,

    -----------------------------------
    --             Tools             --
    -----------------------------------
    workspaces = true,
    colorizer = true,
    colortils = false,
    cybu = false,
    fidget = true,
    toggleterm = true,
    paperplanes = true,
    lightspeed = true,
    todo_comments = true,
    nvim_surround = false,
    align = false,
    neodim = false,
    dap = true,
    dapui = true,
    dap_python = true,

    -----------------------------------
    --               UI              --
    -----------------------------------
    neoscroll = false,
    true_zen = false,
    presence = true,
    bufferline = true,
    indent_blankline = true,
    notify = true,
    satellite = false,
}

return config
