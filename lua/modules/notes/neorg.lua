local present, neorg = pcall(require, "neorg")
if not present then
    return
end

neorg.setup({
    load = {
        ["core.defaults"] = {},
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
        ["core.export"] = {},
        ["core.export.markdown"] = {
            config = {
                extensions = "all",
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        --[[ ["core.gtd.base"] = {
            config = {
                workspace = "task",
            },
        }, ]]
        ["core.concealer"] = {
            config = {
                -- markup_preset = "dimmed",
                markup_preset = "conceal",
                -- icon_preset = "diamond",
                -- icon_preset = "varied",
                dim_code_blocks = {
                    width = "content",
                    padding = {
                        left = 10,
                        right = 10,
                    },
                },
                icons = {
                    marker = {
                        enabled = true,
                        icon = " ",
                    },
                    todo = {
                        enable = true,
                        recurring = {
                            -- icon="ﯩ",
                            icon = "",
                        },
                        pending = {
                            -- icon = ""
                            icon = "",
                        },
                        uncertain = {
                            icon = "?",
                        },
                        urgent = {
                            icon = "",
                        },
                        on_hold = {
                            icon = "",
                        },
                        cancelled = {
                            icon = "",
                        },
                    },
                    heading = {
                        enabled = true,
                        level_1 = {
                            icon = "◈",
                        },
                        level_2 = {
                            icon = " ◇",
                        },
                        level_3 = {
                            icon = "  ◆",
                        },
                        level_4 = {
                            icon = "   ❖",
                        },
                        level_5 = {
                            icon = "    ⟡",
                        },
                        level_6 = {
                            icon = "     ⋄",
                        },
                    },
                },
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
    },
})
