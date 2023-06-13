local config = {}

function config.vimtex()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
            "-pdf",
            "-shell-escape",
            "-pdflatex",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-outdir=.build",
            "-pvc",
        },
    }
    vim.g.vimtex_imaps_enabled = true
    -- TOC settings
    vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = "['content', 'todo']",
        resize = 1,
        split_width = 50,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
        mode = 2,
    }

    -- Ignore undesired errors and warnings
    vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "undefined references",
        "(re)run Biber",
        "Unused global option(s)",
    }

    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtext_quickfix_mode = 1
    -- QuickFix is just annoying
    vim.g.vimtex_quickfix_enabled = 0
end

return config
