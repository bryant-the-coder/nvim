local config = {}

function config.saga()
    require("lspsaga").setup({
        -- Options with default value
        -- "single" | "double" | "rounded" | "bold" | "plus"
        border_style = "rounded",
        --the range of 0 for fully opaque window (disabled) to 100 for fully
        --transparent background. Values between 0-30 are typically most useful.
        saga_winblend = 0,
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = "<C-p>", next = "<C-n>" },
        diagnostic_header = { " ", " ", " ", " " },
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 30,
        -- use emoji lightbulb in default
        code_action_icon = "💡",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = true,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = false,
        },
        -- finder icons
        finder_icons = {
            def = "  ",
            ref = "諭 ",
            link = "  ",
        },
        -- custom finder title winbar function type
        -- param is current word with symbol icon string type
        -- return a winbar format string like `%#CustomFinder#Test%*`
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>", -- quit can be a table
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        rename_action_quit = "<Esc>",
        rename_in_select = true,
        -- show symbols in winbar must nightly
        symbol_in_winbar = {
            in_custom = false,
            enable = false,
            separator = " ",
            show_file = true,
            click_support = false,
        },
        -- show outline
        show_outline = {
            win_position = "right",
            --set special filetype win that outline window split.like NvimTree neotree
            -- defx, db_ui
            win_with = "",
            win_width = 30,
            auto_enter = true,
            auto_preview = true,
            virt_text = "┃",
            jump_key = "o",
            -- auto refresh when change buffer
            auto_refresh = true,
        },
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {},
    })
end

function config.signature()
    local border = require("custom.border").styles.type_1
    local opts = {
        bind = true,
        doc_lines = 0,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hint_prefix = "󰏚 ",
        hint_scheme = "String",
        hi_parameter = "Search",
        max_height = 22,

        transparency = 1,                       -- disabled by default, allow floating win transparent value 1~100
        max_width = 120,                        -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = {
            border = border,                    -- double, single, shadow, none
        },
        zindex = 50,                            -- by default it will be on top of all floating windows, set to 50 send it to bottom
        padding = "",                           -- character to pad on left and right of signature can be ' ', or '|'  etc
        always_trigger = true,
        floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
    }

    require("lsp_signature").setup(opts)
end

function config.rust_crates()
    require("crates").setup({
        smart_insert = true,
        insert_closing_quote = true,
        autoload = true,
        autoupdate = true,
        loading_indicator = true,
        date_format = "%Y-%m-%d",
        thousands_separator = ".",
        notification_title = "Crates",
        curl_args = { "-sL", "--retry", "1" },
        text = {
            loading = "   Loading",
            version = "   %s",
            prerelease = "   %s",
            yanked = "   %s",
            nomatch = "   No match",
            upgrade = "   %s",
            error = "   Error fetching crate",
        },
        highlight = {
            loading = "CratesNvimLoading",
            version = "CratesNvimVersion",
            prerelease = "CratesNvimPreRelease",
            yanked = "CratesNvimYanked",
            nomatch = "CratesNvimNoMatch",
            upgrade = "CratesNvimUpgrade",
            error = "CratesNvimError",
        },
        popup = {
            autofocus = false,
            copy_register = '"',
            style = "minimal",
            border = "none",
            show_version_date = false,
            show_dependency_version = true,
            max_height = 30,
            min_width = 20,
            padding = 1,
            text = {
                title = " %s",
                pill_left = "",
                pill_right = "",
                description = "%s",
                created_label = " created        ",
                created = "%s",
                updated_label = " updated        ",
                updated = "%s",
                downloads_label = " downloads      ",
                downloads = "%s",
                homepage_label = " homepage       ",
                homepage = "%s",
                repository_label = " repository     ",
                repository = "%s",
                documentation_label = " documentation  ",
                documentation = "%s",
                crates_io_label = " crates.io      ",
                crates_io = "%s",
                categories_label = " categories     ",
                keywords_label = " keywords       ",
                version = "  %s",
                prerelease = " %s",
                yanked = " %s",
                version_date = "  %s",
                feature = "  %s",
                enabled = " %s",
                transitive = " %s",
                normal_dependencies_title = " Dependencies",
                build_dependencies_title = " Build dependencies",
                dev_dependencies_title = " Dev dependencies",
                dependency = "  %s",
                optional = " %s",
                dependency_version = "  %s",
                loading = "  ",
            },
            highlight = {
                title = "CratesNvimPopupTitle",
                pill_text = "CratesNvimPopupPillText",
                pill_border = "CratesNvimPopupPillBorder",
                description = "CratesNvimPopupDescription",
                created_label = "CratesNvimPopupLabel",
                created = "CratesNvimPopupValue",
                updated_label = "CratesNvimPopupLabel",
                updated = "CratesNvimPopupValue",
                downloads_label = "CratesNvimPopupLabel",
                downloads = "CratesNvimPopupValue",
                homepage_label = "CratesNvimPopupLabel",
                homepage = "CratesNvimPopupUrl",
                repository_label = "CratesNvimPopupLabel",
                repository = "CratesNvimPopupUrl",
                documentation_label = "CratesNvimPopupLabel",
                documentation = "CratesNvimPopupUrl",
                crates_io_label = "CratesNvimPopupLabel",
                crates_io = "CratesNvimPopupUrl",
                categories_label = "CratesNvimPopupLabel",
                keywords_label = "CratesNvimPopupLabel",
                version = "CratesNvimPopupVersion",
                prerelease = "CratesNvimPopupPreRelease",
                yanked = "CratesNvimPopupYanked",
                version_date = "CratesNvimPopupVersionDate",
                feature = "CratesNvimPopupFeature",
                enabled = "CratesNvimPopupEnabled",
                transitive = "CratesNvimPopupTransitive",
                normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
                build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
                dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
                dependency = "CratesNvimPopupDependency",
                optional = "CratesNvimPopupOptional",
                dependency_version = "CratesNvimPopupDependencyVersion",
                loading = "CratesNvimPopupLoading",
            },
            keys = {
                hide = { "q", "<esc>" },
                open_url = { "<cr>" },
                select = { "<cr>" },
                select_alt = { "s" },
                toggle_feature = { "<cr>" },
                copy_value = { "yy" },
                goto_item = { "gd", "K", "<C-LeftMouse>" },
                jump_forward = { "<c-i>" },
                jump_back = { "<c-o>", "<C-RightMouse>" },
            },
        },
        completion = {
            insert_closing_quote = true,
            cmp = {
                enabled = true,
            },
            text = {
                prerelease = "  pre-release ",
                yanked = "  yanked ",
            },
            coq = {
                enabled = false,
                name = "Crates",
            },
            crates = {
                enabled = true,  -- disabled by default
                max_results = 8, -- The maximum number of search results to display
                min_chars = 3,   -- The minimum number of charaters to type before completions begin appearing
            },
        },
        null_ls = {
            enabled = false,
            name = "Crates",
        },
    })
end

function config.inlayhints()
    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("lsp-inlayhints").on_attach(client, bufnr)
        end,
    })

    require("lsp-inlayhints").setup({
        inlay_hints = {
            parameter_hints = {
                show = true,
                prefix = "  <- ",
                -- separator = ", ",
            },
            type_hints = {
                -- type and other hints
                show = false,
                prefix = "",
                separator = "  ",
                remove_colon_end = false,
                remove_colon_start = false,
            },
            -- separator between types and parameter hints. Note that type hints are
            -- shown before parameter
            labels_separator = "  ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- highlight group
            highlight = "InlayHints",
        },
        debug_mode = false,
    })
end

return config
