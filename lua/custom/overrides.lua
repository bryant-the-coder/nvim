local hl = vim.api.nvim_set_hl
local base = require("core.utils").get_base()
local colors = require("core.utils").get()
local config = require("core.default_config")

-- Code from nvchad
local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local light_grey = colors.light_grey
local vibrant_green = colors.vibrant_green
local baby_pink = colors.baby_pink
local dark_purple = colors.dark_purple
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pink = colors.pink
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local one_bg3 = colors.one_bg3
local teal = colors.teal
local grey_fg2 = colors.grey_fg2
local cyan = colors.cyan
local sun = colors.sun
local nord_blue = colors.nord_blue
local base00 = base.base00
local base01 = base.base01
local base02 = base.base02
local base03 = base.base03
local base04 = base.base04
local base05 = base.base05
local base06 = base.base06
local base07 = base.base07
local base08 = base.base08
local base09 = base.base09
local base0A = base.base0A
local base0B = base.base0B
local base0C = base.base0C
local base0D = base.base0D
local base0E = base.base0E
local base0F = base.base0F

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color, args)
    local arg = {}
    if args then
        vim.tbl_extend("keep", arg, args)
    end
    arg["bg"] = color
    vim.api.nvim_set_hl(0, group, arg)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color, args)
    local arg = {}
    if args then
        arg = args
    end
    arg["fg"] = color
    vim.api.nvim_set_hl(0, group, arg)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol, args)
    local arg = {}
    if args then
        arg = args
    end
    arg["fg"] = fgcol
    arg["bg"] = bgcol
    vim.api.nvim_set_hl(0, group, arg)
end

-- Toggle transparent / ui right here :D
local ui = {
    transparency = false,
    italic = true,
}

hl(0, "StatusNormal", { fg = "#181a1f", bg = "#98c379" })
hl(0, "StatusReplace", { fg = "#181a1f", bg = "#E5C07B" })
hl(0, "StatusInsert", { fg = "#181a1f", bg = "#61AFEF" })
hl(0, "StatusCommand", { fg = "#181a1f", bg = "#56B6C2" })
hl(0, "StatusVisual", { fg = "#181a1f", bg = "#C678DD" })
hl(0, "StatusTerminal", { fg = "#181a1f", bg = "#E06C75" })
hl(0, "Filename", { fg = "#a9b1d6" })
hl(0, "Branch", { fg = "#181a1f", bg = "#ff69b4" })
hl(0, "GitInfo", { fg = "#8b919c", bg = "NONE" })
-- hl(0, "Error", { fg = "#181a1f", bg = "#EE6D85", bold = true })
-- hl(0, "Warning", { fg = "#181a1f", bg = "#D7A65F", bold = true })
-- hl(0, "Hint", { fg = "#181a1f", bg = purple, bold = true })
-- hl(0, "Info", { fg = "#181a1f", bg = green, bold = true })
hl(0, "Error", { fg = "#EE6D85", bg = "NONE", bold = true })
hl(0, "Warning", { fg = "#D7A65F", bg = "NONE", bold = true })
hl(0, "Hint", { fg = purple, bg = "NONE", bold = true })
hl(0, "Info", { fg = green, bg = "NONE", bold = true })
hl(0, "Clock", { fg = "#181a1f", bg = "#41a6b5" })
hl(0, "SearchCount", { fg = "#181a1f", bg = base0E })
-- hl(0, "Coords", { fg = "#1E232A", bg = base0F })
hl(0, "MatchArea", { bg = one_bg })

if config.ui.italic then
    -- local light_grey = "#a9a9a9"
    -- fg("Comment", light_grey, { italic = true, bold = true })
    -- fg("TSComment", light_grey, { italic = true, bold = true })
    -- fg("Function", base0D, { italic = true })
    fg("DiagnosticHeader", "#2cb27f", { italic = true, bold = true })
    fg("GitSignsCurrentLineBlame", light_grey, { italic = true, bold = true })
    fg("CmpItemAbbr", white, { italic = true })
    -- fg("TSVariable", base05, { italic = true })
    -- fg("TSString", base0B, { italic = true })
    fg_bg("TelescopePreviewTitle", black, green, { italic = true })
    fg_bg("TelescopePromptTitle", black, red, { italic = true })
    fg_bg("BufferlineBufferSelected", white, black, { italic = true, bold = true })
    --[[ fg_bg("BufferlineBufferVisible", light_grey, black2, { italic = true, bold = true })
    fg_bg("BufferlineDuplicateSelected", white, grey, { italic = true, bold = true })
    fg_bg("BufferlineDuplicateVisible", white, black2, { italic = true, bold = true }) ]]
else
    fg("Comment", light_grey, { bold = true })
    fg("DiagnosticHeader", "#2cb27f", { bold = true })
    fg("GitSignsCurrentLineBlame", light_grey, { bold = true })
    fg("CmpItemAbbr", white)
    fg_bg("TelescopePreviewTitle", black, green)
    fg_bg("TelescopePromptTitle", black, red)
    fg_bg("BufferlineBufferSelected", white, black, { bold = true })
    fg_bg("BufferlineBufferVisible", light_grey, black2, { bold = true })
    fg_bg("BufferlineDuplicateSelected", white, grey, { bold = true })
    fg_bg("BufferlineDuplicateVisible", white, black2, { bold = true })
end

if config.ui.transparency then
    -- bg("Normal", "none")
    fg_bg("Normal", "NONE", "NONE")
    bg("StatuslineNC", "NONE")
    bg("HarpoonWindow", "NONE")
    -- fg_bg("BufferlineFill", grey_fg, "NONE")
    fg_bg("Folded", white, "NONE")
else
    bg("StatusLineNC", "#15171c")
    bg("StatusLine", colors.black)
    fg_bg("BufferlineFill", grey_fg, darker_black)
    fg_bg("Folded", white, grey)
end

-----------------------------------
--           Basic               --
-----------------------------------
-- Line Number
fg("CursorLineNr", yellow)
fg("LineNr", light_grey)

-- Same as bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
-- fg("FloatBorder", blue)
bg("NormalFloat", darker_black)

-- testing
fg("FloatBorder", grey_fg)
fg("WinSeparator", blue)

-- Inactive statuslines as thin lines
fg("StatuslineNC", one_bg3)
fg("NvimInternalError", red)
fg("VertSplit", one_bg2)
fg("WinBarSeparator", grey)
fg_bg("WinBarContent", green, grey)

-- Visual mode highlighting
fg("Visual", blue)

-----------------------------------
--           Plugins             --
-----------------------------------
-- Neorg
bg("NeorgCodeBlock", darker_black)

-- Neogit
fg("NeogitNotificationInfo", green)
fg("NeogitNotificationWarning", yellow)
fg("NeogitNotificationError", red)

fg("LspSagaCodeActionTitle", purple)
fg("LspSagaCodeActionBorder", vibrant_green)
fg("LspSagaCodeActionContent", white)
fg("LSOutlinePreviewBorder", purple)
fg("OutlineIndentEven", orange)
fg("OutlineIndentOdd", dark_purple)
fg("OutlineFoldPrefix", red)
fg("OutlineDetail", grey)

-- Lsp
fg("DiagnosticHint", purple)
fg("DiagnosticError", red)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInformation", green)
fg_bg("RenamerTitle", black, yellow, { bold = true, italic = true })
fg("RenamerBorder", yellow)
fg("InlayHints", grey_fg)

-- Mason
fg_bg("MasonHeader", black, red)
fg("MasonHighlight", blue)
fg_bg("MasonHighlightBlock", black, green)
fg("MasonMuted", light_grey)
fg_bg("MasonMutedBlock", light_grey, one_bg)
hl(0, "MasonHighlightBlockBold", { link = "MasonHighlightBlock" })
hl(0, "MasonHeaderSecondary", { link = "MasonHighlightBlock" })

-- Pmenu
bg("Pmenu", black)
bg("PmenuSbar", one_bg)
bg("PmenuThumb", grey)
fg_bg("PmenuSel", black, blue)

-- GitSigns
fg("GitSignsAdd", green)
fg("GitSignsChange", orange)
fg("GitSignsDelete", red)

-- Neotree
fg("NeoTreeDirectoryIcon", folder_bg)
fg("NeoTreeDirectoryName", folder_bg)
fg("NeoTreeRootName", red, { underline = true })
fg("NeoTreeDirectoryName", folder_bg)
fg("NeoTreeFileNameOpened", folder_bg)
fg_bg("NeoTreeFloatBorder", darker_black, darker_black)
fg("NeoTreeFloatTitle", yellow)

-- CMP
fg("CmpItemAbbrDeprecated", "#808080", { strikethrough = true })

bg("CmPmenu", black2)

-- fg("CmpItemAbbrMatch", "#569CD6")
fg("CmpItemAbbrMatch", blue, { bold = true })
fg("CmpItemAbbrMatchFuzzy", "#569CD6")

fg("CmpItemMenuInterface", "#9CDCFE")
fg("CmpItemMenuText", light_grey, { italic = true })
fg("CmpItemMenu", light_grey, { italic = true })

-- fg("CmpBorder", blue)
fg_bg("CmpBorder", black2, black2)
fg_bg("CmpDocBorder", darker_black, darker_black)
fg("CmpDoc", darker_black)

fg("CmpItemKindConstant", base09)
fg("CmpItemKindInterface", base0D)
fg("CmpItemKindFunction", base0D)
fg("CmpItemKindIdentifier", base08)
fg("CmpItemKindField", base08)
fg("CmpItemKindVariable", base0E)
fg("CmpItemKindSnippet", red)
fg("CmpItemKindText", base0B)
fg("CmpItemKindStructure", base0E)
fg("CmpItemKindType", base0A)
fg("CmpItemKindKeyword", base07)
fg("CmpItemKindMethod", base0D)
fg("CmpItemKindConstructor", blue)
fg("CmpItemKindEnum", blue)
fg("CmpItemKindEnumMember", purple)
fg("CmpItemKindClass", teal)
fg("CmpItemKindEvent", yellow)
fg("CmpItemKindFolder", base07)
fg("CmpItemKindModule", base0A)
fg("CmpItemKindProperty", base08)
fg("CmpItemKindUnit", base0E)
fg("CmpItemKindValue", cyan)
fg("CmpItemKindFile", base07)
fg("CmpItemKindColor", white)
fg("CmpItemKindReference", base05)
fg("CmpItemKindStruct", base0E)
fg("CmpItemKindOperator", base05)
fg("CmpItemKindTypeParameter", base08)

-- Telescope
bg("TelescopeNormal", darker_black)
fg_bg("TelescopeSelection", white, black2)
fg_bg("TelescopeBorder", darker_black, darker_black)
fg_bg("TelescopePromptBorder", black2, black2)
fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", red, black2)
fg_bg("TelescopeResultsTitle", darker_black, darker_black)
bg("TelescopePreviewLine", light_grey)
fg("TelescopeResultsDiffAdd", green)
fg("TelescopeResultsDiffChange", yellow)
fg("TelescopeResultsDiffDelete", red)

-- Nvim-Tree
bg("NvimTreeNormal", darker_black)
bg("NvimTreeCursorLine", darker_black)
bg("NvimTreeNormalNC", darker_black)
fg("NvimTreeEmptyFolderName", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeOpenedFolderName", folder_bg)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", grey_fg)
fg("NvimTreeRootFolder", red, { underline = true })
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg_bg("NvimTreeVertSplit", darker_black, darker_black)
fg_bg("NvimTreeWindowPicker", black2, red)

-- Dev icon
fg("DevIconDefault", red)
fg("DevIconc", blue)
fg("DevIcondeb", cyan)
fg("DevIconcss", blue)
fg("DevIconDockerfile", cyan)
fg("DevIconhtml", baby_pink)
fg("DevIconjpeg", dark_purple)
fg("Deviconjpg", dark_purple)
fg("DevIconjs", sun)
fg("DevIconkt", orange)
fg("DevIconlock", red)
fg("DevIconlua", blue)
fg("DevIconmp3", white)
fg("DevIconmp4", white)
fg("DevIconout", white)
fg("DevIconttf", white)
fg("DevIconpng", dark_purple)
fg("DevIconpy", cyan)
fg("DevIcontoml", blue)
fg("DevIconts", teal)
fg("DevIconrb", pink)
fg("DevIconrpm", orange)
fg("DevIconvue", vibrant_green)
fg("DevIconwoff", white)
fg("DevIconwoff2", white)
fg("DevIconxz", sun)
fg("DevIconzip", sun)

-- Notify
fg("NotifyERRORBorder", red)
fg("NotifyERRORIcon", red)
fg("NotifyERRORTitle", red)
fg("NotifyWARNBorder", orange)
fg("NotifyWARNIcon", orange)
fg("NotifyWARNTitle", orange)
fg("NotifyINFOBorder", green)
fg("NotifyINFOIcon", green)
fg("NotifyINFOTitle", green)
fg("NotifyDEBUGBorder", grey)
fg("NotifyDEBUGIcon", grey)
fg("NotifyDEBUGTitle", grey)
fg("NotifyTRACEBorder", purple)
fg("NotifyTRACEIcon", purple)
fg("NotifyTRACETitle", purple)
