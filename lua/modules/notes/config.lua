local config = {}

function config.neorg()
    local present, neorg = pcall(require, "neorg")
    if not present then
        return
    end

    neorg.setup({
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.tempus"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.upgrade"] = {},
            ["core.looking-glass"] = {}, -- Enable the looking_glass module
            ["core.itero"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = "all",
                },
            },

            ["core.concealer"] = {},
            ["core.esupports.metagen"] = {
                config = {
                    type = "auto",
                },
            },
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = "\\",
                },
            },
            ["core.dirman"] = { -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        home = "~/neorg",
                        personal = "~/neorg/personal",
                        work = "~/neorg/work",
                        notes = "~/neorg/notes",
                        recipes = "~/neorg/notes/recipes",
                    },
                    index = "index.norg",
                    autodetect = true,
                    [[ -- autochdir = false, ]],
                },
            },

            ["core.qol.toc"] = {
                config = {
                    close_split_on_jump = true,
                    toc_split_placement = "left",
                },
            },
            ["core.journal"] = {
                config = {
                    workspace = "home",
                    journal_folder = "journal",
                    use_folders = true,
                },
            },
            ["core.summary"] = {},
            ["core.manoeuvre"] = {},
        },
    })
end

return config
