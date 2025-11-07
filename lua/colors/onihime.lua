-- OniHime Colorscheme
-- Inspired by the two characters in the image.
-- Author: Raphael

local M = {}

---@class Palette
---@field bg string
---@field bg_alt string
---@field fg string
---@field fg_alt string
---@field comment string
---@field red string
---@field pink string
---@field blue string
---@field teal string
---@field gold string
---@field black string

---@type Palette
local p = {
    bg      = "#F9F9FB",
    bg_alt  = "#FFFFFF",
    fg      = "#3A3C4E",
    fg_alt  = "#8A8D9E",
    comment = "#9DA0B4",
    red     = "#E54B4B",
    pink    = "#F06292",
    blue    = "#61AFEF",
    teal    = "#4DB6AC",
    gold    = "#FFD700",
    black   = "#282A36",
}

function M.setup()
    -- Clear existing highlights
    vim.cmd "hi clear"
    if vim.fn.exists "syntax_on" then
        vim.cmd "syntax reset"
    end

    vim.g.colors_name   = "onihime"
    vim.o.termguicolors = true

    -- Editor UI
    local highlights    = {
        Normal                           = { fg = p.fg, bg = p.bg },
        NormalFloat                      = { fg = p.fg, bg = p.bg_alt },
        FloatBorder                      = { fg = p.pink, bg = p.bg_alt },

        CursorLine                       = { bg = "#EFF1F5" },
        CursorLineNr                     = { fg = p.fg, bg = "#EFF1F5" },
        LineNr                           = { fg = p.comment },

        SignColumn                       = { bg = p.bg },
        Folded                           = { fg = p.comment, bg = p.bg },

        Pmenu                            = { fg = p.fg, bg = p.bg_alt },
        PmenuSel                         = { fg = p.bg_alt, bg = p.blue },
        PmenuSbar                        = { bg = p.bg },
        PmenuThumb                       = { bg = p.comment },

        StatusLine                       = { fg = p.black, bg = p.pink },
        StatusLineNC                     = { fg = p.comment, bg = "#E4E6EC" },
        TabLine                          = { fg = p.comment, bg = "#E4E6EC" },
        TabLineFill                      = { bg = "#E4E6EC" },
        TabLineSel                       = { fg = p.black, bg = p.blue },

        Visual                           = { bg = "#DCE0E8" },
        Search                           = { fg = p.black, bg = p.gold, bold = true },
        IncSearch                        = { fg = p.black, bg = p.pink },

        Title                            = { fg = p.blue, bold = true },
        Directory                        = { fg = p.blue },

        DiffAdd                          = { bg = "#A6E3A1" },
        DiffChange                       = { bg = "#F9E2AF" },
        DiffDelete                       = { bg = "#F38BA8" },
        DiffText                         = { bg = "#DCE0E8" },

        ErrorMsg                         = { fg = p.red, bg = p.bg, bold = true },
        WarningMsg                       = { fg = p.gold, bg = p.bg, bold = true },

        -- Syntax Highlighting
        Comment                          = { fg = p.comment, italic = true },
        Constant                         = { fg = p.red },
        String                           = { fg = p.teal },
        Number                           = { fg = p.red },
        Boolean                          = { fg = p.red },

        Identifier                       = { fg = p.fg },
        Function                         = { fg = p.pink },

        Statement                        = { fg = p.blue },
        Keyword                          = { fg = p.blue, italic = true },
        Operator                         = { fg = p.blue },
        Conditional                      = { fg = p.blue, bold = true },
        Repeat                           = { fg = p.blue, bold = true },
        Label                            = { fg = p.pink },
        Exception                        = { fg = p.red, bold = true },

        Type                             = { fg = p.pink },
        StorageClass                     = { fg = p.blue },
        Structure                        = { fg = p.pink },
        Typedef                          = { fg = p.pink },

        Special                          = { fg = p.gold },
        SpecialChar                      = { fg = p.gold },
        Tag                              = { fg = p.blue },
        Delimiter                        = { fg = p.fg },

        Todo                             = { fg = p.black, bg = p.gold, bold = true },

        -- LSP
        LspDiagnosticsDefaultError       = { fg = p.red },
        LspDiagnosticsDefaultWarning     = { fg = p.gold },
        LspDiagnosticsDefaultInformation = { fg = p.blue },
        LspDiagnosticsDefaultHint        = { fg = p.teal },

        -- Treesitter
        ["@text.title"]                  = { fg = p.blue, bold = true },
        ["@text.uri"]                    = { fg = p.gold, underline = true },
        ["@text.emphasis"]               = { italic = true },
        ["@text.strong"]                 = { bold = true },
        ["@text.literal"]                = { fg = p.teal },
        ["@comment"]                     = { fg = p.comment, italic = true },
        ["@constant"]                    = { fg = p.red },
        ["@string"]                      = { fg = p.teal },
        ["@number"]                      = { fg = p.red },
        ["@function"]                    = { fg = p.pink },
        ["@keyword"]                     = { fg = p.blue, italic = true },
        ["@operator"]                    = { fg = p.blue },
        ["@type"]                        = { fg = p.pink },
        ["@variable"]                    = { fg = p.fg },
        ["@parameter"]                   = { fg = p.fg_alt, italic = true },
        ["@tag"]                         = { fg = p.blue },
        ["@property"]                    = { fg = p.teal },
        ["@namespace"]                   = { fg = p.pink },
    }

    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
