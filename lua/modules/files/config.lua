local config = {}

function config.fzf()
    require("fzf-lua").setup({
        files = {
            prompt = "Files>",
            file_ignore_patterns = {
                "__pycache__",
                "node_modules",
                ".jpg",
                ".jpeg",
                ".png",
                ".ico",
                ".add",
            },
        },
        grep = {
            rg_opts = "--sort-files --hidden --column --line-number --no-heading "
                .. "--color=always --smart-case -g '!{.git,node_modules}/*'",
        },
    })
end

return config
