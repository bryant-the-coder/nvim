local config = {}

function config.neorg()
    local present, neorg = pcall(require, "neorg")
    if not present then
        return
    end

    neorg.setup({
        load = {
            ["core.defaults"] = {},
            ["core.upgrade"] = {},
            ["core.looking-glass"] = {}, -- Enable the looking_glass module
            ["core.itero"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = "all",
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        home = "~/neorg",
                        notes = "~/neorg/notes",
                        task = "~/neorg/task",
                    },
                    open_last_workspace = false,
                    index = "index.norg",
                },
            },
            ["core.promo"] = {},
            ["core.presenter"] = {
                config = {
                    zen_mode = "zen-mode",
                    slide_count = {
                        enable = true,
                        position = "top",
                        count_format = "[%d/%d]",
                    },
                },
            },
            ["core.esupports.metagen"] = {
                config = {
                    type = "auto",
                },
            },
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.keybinds"] = {
                config = {
                    hook = function(keybinds)
                        keybinds.remap_event("norg", "n", "tc", "core.norg.qol.todo_items.todo.task_cycle")
                    end,
                },
            },
            ["core.journal"] = {
                config = {
                    workspace = "home",
                    journal_folder = "journal",
                    use_folders = false,
                    strategy = "flat",
                    toc_format = "{dd, mm, yy}",
                },
            },
            -- ["external.kanban"] = {},
            -- ["core.integrations.telescope"] = {}, -- Enable the telescope module
            ["core.highlights"] = {},
            ["core.ui.calendar"] = {},
            ["core.summary"] = {},
            ["core.manoeuvre"] = {},
        },
    })
end

return config
