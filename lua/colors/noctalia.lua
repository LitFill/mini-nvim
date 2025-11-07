-- /home/litfill/.config/nvim/lua/colors/noctalia.lua

local M = {}

-- Function to read and parse the colors.json file
local function get_colors()
    local path = vim.fn.expand("~/.config/noctalia/colors.json")
    local file = io.open(path, "r")
    if not file then
        vim.notify("Noctalia colors file not found: " .. path, vim.log.levels.ERROR)
        return nil
    end
    local content = file:read("*a")
    file:close()
    local colors, err = vim.fn.json_decode(content)
    if not colors then
        vim.notify("Failed to parse noctalia/colors.json: " .. err, vim.log.levels.ERROR)
        return nil
    end
    return colors
end

-- Function to apply the colors as a Neovim colorscheme
function M.load()
    -- Set terminal colors to ensure they match the GUI
    vim.g.terminal_color_0  = "#192028" -- mSurfaceVariant
    vim.g.terminal_color_1  = "#ffb4ab" -- mError
    vim.g.terminal_color_2  = "#80d4d8" -- mSecondary
    vim.g.terminal_color_3  = "#9dcbfc" -- mTertiary
    vim.g.terminal_color_4  = "#4cd9df" -- mPrimary
    vim.g.terminal_color_5  = "#80d4d8" -- mSecondary
    vim.g.terminal_color_6  = "#4cd9df" -- mPrimary
    vim.g.terminal_color_7  = "#dce3ee" -- mOnSurface
    vim.g.terminal_color_8  = "#192028" -- mSurfaceVariant
    vim.g.terminal_color_9  = "#ffb4ab" -- mError
    vim.g.terminal_color_10 = "#80d4d8" -- mSecondary
    vim.g.terminal_color_11 = "#9dcbfc" -- mTertiary
    vim.g.terminal_color_12 = "#4cd9df" -- mPrimary
    vim.g.terminal_color_13 = "#80d4d8" -- mSecondary
    vim.g.terminal_color_14 = "#4cd9df" -- mPrimary
    vim.g.terminal_color_15 = "#dce3ee" -- mOnSurface

    local c                 = get_colors()
    if not c then return end

    -- Define highlight groups
    local highlights = {
        -- UI Elements
        Normal               = { fg = c.mOnSurface, bg = c.mSurface },
        SignColumn           = { bg = c.mSurface },
        MsgArea              = { fg = c.mOnSurface, bg = c.mSurfaceVariant },
        ModeMsg              = { fg = c.mOnSurface, bg = c.mPrimary, style = "bold" },
        MoreMsg              = { fg = c.mPrimary, style = "bold" },
        Question             = { fg = c.mSecondary, style = "bold" },
        NonText              = { fg = c.mOutline },
        LineNr               = { fg = c.mSecondary, bg = c.mSurface },
        CursorLineNr         = { fg = c.mPrimary, bg = c.mSurface, style = "bold" },
        StatusLine           = { fg = c.mOnSurface, bg = c.mSurfaceVariant },
        StatusLineNC         = { fg = c.mOnSurfaceVariant, bg = c.mSurface },
        TabLine              = { fg = c.mOnSurfaceVariant, bg = c.mSurface },
        TabLineSel           = { fg = c.mOnSurface, bg = c.mPrimary },
        TabLineFill          = { bg = c.mSurface },
        Pmenu                = { fg = c.mOnSurface, bg = c.mSurfaceVariant },
        PmenuSel             = { fg = c.mOnPrimary, bg = c.mPrimary },
        PmenuSbar            = { bg = c.mOutline },
        PmenuThumb           = { bg = c.mOnSurfaceVariant },
        WildMenu             = { fg = c.mOnPrimary, bg = c.mPrimary },

        -- Custom StatusLine Parts
        StatusLineModeNormal = { fg = c.mOnPrimary, bg = c.mPrimary, style = "bold" },
        StatusLineModeInsert = { fg = c.mOnSecondary, bg = c.mSecondary, style = "bold" },
        StatusLineModeVisual = { fg = c.mOnTertiary, bg = c.mTertiary, style = "bold" },
        StatusLineInfo       = { fg = c.mOnSurface, bg = c.mSurfaceVariant, style = "NONE" },


        -- Syntax Highlighting
        Comment                          = { fg = c.mOnSurfaceVariant, style = "italic" },
        Constant                         = { fg = c.mSecondary },
        String                           = { fg = c.mTertiary },
        Character                        = { fg = c.mTertiary },
        Number                           = { fg = c.mSecondary },
        Boolean                          = { fg = c.mSecondary },
        Float                            = { fg = c.mSecondary },
        Identifier                       = { fg = c.mPrimary },
        Function                         = { fg = c.mPrimary, style = "bold" },
        Statement                        = { fg = c.mSecondary, style = "bold" },
        Conditional                      = { fg = c.mSecondary, style = "bold" },
        Repeat                           = { fg = c.mSecondary, style = "bold" },
        Label                            = { fg = c.mSecondary, style = "bold" },
        Operator                         = { fg = c.mOnSurface },
        Keyword                          = { fg = c.mSecondary },
        Exception                        = { fg = c.mError, style = "bold" },
        PreProc                          = { fg = c.mTertiary },
        Include                          = { fg = c.mPrimary },
        Define                           = { fg = c.mTertiary },
        Macro                            = { fg = c.mTertiary },
        PreCondit                        = { fg = c.mTertiary },
        Type                             = { fg = c.mPrimary },
        StorageClass                     = { fg = c.mSecondary },
        Structure                        = { fg = c.mPrimary },
        Typedef                          = { fg = c.mSecondary },
        Special                          = { fg = c.mTertiary },
        SpecialChar                      = { fg = c.mOutline },
        Tag                              = { fg = c.mSecondary },
        Delimiter                        = { fg = c.mOnSurfaceVariant },
        SpecialComment                   = { fg = c.mOnSurfaceVariant, style = "italic" },
        Debug                            = { fg = c.mError },
        Underlined                       = { style = "underline" },
        Ignore                           = { fg = c.mOutline },
        Error                            = { fg = c.mOnError, bg = c.mError },
        Todo                             = { fg = c.mSurface, bg = c.mTertiary, style = "bold" },

        -- Diffs
        DiffAdd                          = { bg = c.mSecondary .. "20" }, -- Add transparency
        DiffChange                       = { bg = c.mPrimary .. "20" },
        DiffDelete                       = { bg = c.mError .. "20" },
        DiffText                         = { bg = c.mPrimary .. "40" },

        -- LSP
        LspDiagnosticsDefaultError       = { fg = c.mError },
        LspDiagnosticsDefaultWarning     = { fg = c.mTertiary },
        LspDiagnosticsDefaultInformation = { fg = c.mSecondary },
        LspDiagnosticsDefaultHint        = { fg = c.mPrimary },

        -- Treesitter
        ["@text.literal"]                = { fg = c.mOnSurfaceVariant },
        ["@text.reference"]              = { fg = c.mPrimary },
        ["@text.title"]                  = { fg = c.mSecondary, style = "bold" },
        ["@text.uri"]                    = { fg = c.mTertiary, style = "underline" },
        ["@text.underline"]              = { style = "underline" },
        ["@comment"]                     = { fg = c.mOnSurfaceVariant, style = "italic" },
        ["@punctuation"]                 = { fg = c.mOnSurfaceVariant },
        ["@constant"]                    = { fg = c.mSecondary },
        ["@constant.builtin"]            = { fg = c.mSecondary, style = "bold" },
        ["@string"]                      = { fg = c.mTertiary },
        ["@string.escape"]               = { fg = c.mPrimary },
        ["@character"]                   = { fg = c.mTertiary },
        ["@number"]                      = { fg = c.mSecondary },
        ["@boolean"]                     = { fg = c.mSecondary, style = "bold" },
        ["@float"]                       = { fg = c.mSecondary },
        ["@function"]                    = { fg = c.mPrimary },
        ["@function.builtin"]            = { fg = c.mPrimary, style = "bold" },
        ["@method"]                      = { fg = c.mPrimary },
        ["@keyword"]                     = { fg = c.mSecondary, style = "bold" },
        ["@operator"]                    = { fg = c.mOnSurface },
        ["@variable"]                    = { fg = c.mOnSurface },
        ["@variable.builtin"]            = { fg = c.mPrimary, style = "bold" },
        ["@type"]                        = { fg = c.mPrimary },
        ["@type.definition"]             = { fg = c.mPrimary, style = "bold" },
        ["@tag"]                         = { fg = c.mSecondary },
        ["@tag.attribute"]               = { fg = c.mOnSurfaceVariant },
        ["@tag.delimiter"]               = { fg = c.mOnSurfaceVariant },
        ["@constructor"]                 = { fg = c.mPrimary },
        ["@property"]                    = { fg = c.mOnSurface },
        ["@exception"]                   = { fg = c.mError, style = "bold" },
        ["@conditional"]                 = { fg = c.mSecondary, style = "bold" },
        ["@label"]                       = { fg = c.mSecondary },
    }

    -- Clear existing highlights and apply new ones
    vim.cmd("highlight clear")
    for group, settings in pairs(highlights) do
        local style = settings.style or "NONE"
        local fg = settings.fg or "NONE"
        local bg = settings.bg or "NONE"
        vim.cmd(string.format("highlight %s guifg=%s guibg=%s gui=%s", group, fg, bg, style))
    end

    vim.notify("Noctalia colors updated!", vim.log.levels.INFO)
end

return M
