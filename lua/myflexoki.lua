---@alias Palette { base: string, surface: string, overlay: string, muted: string, subtle: string, text: string, red_two: string, orange_two: string, magenta_two: string, blue_two: string, cyan_two: string, purple_two: string }

---@type Palette
local overide = {
    red_two     = "#ff5779",
    orange_two  = "#ffc100",
    magenta_two = "#7075d7",
    blue_two    = "#3777fd",
    cyan_two    = "#00a6e4",
    purple_two  = "#ab4eff",
    green_two   = "#14c200",
}

require("flexoki").setup {
    variant = "auto", -- auto, moon, or dawn
    dark_variant = true,
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = { terminal = true },

    styles = {
        bold = true,
        italic = false,
    },

    groups = {
        border = "muted",
        link   = "purple_two",
        panel  = "surface",

        error = "red_one",
        hint  = "purple_one",
        info  = "cyan_one",
        ok    = "green_one",
        warn  = "orange_one",
        note  = "blue_one",
        todo  = "magenta_one",

        git_add       = "green_one",
        git_change    = "yellow_one",
        git_delete    = "red_one",
        git_dirty     = "yellow_one",
        git_ignore    = "muted",
        git_merge     = "purple_one",
        git_rename    = "blue_one",
        git_stage     = "purple_one",
        git_text      = "magenta_one",
        git_untracked = "subtle",

        h1 = "purple_two",
        h2 = "cyan_two",
        h3 = "magenta_two",
        h4 = "orange_two",
        h5 = "blue_two",
        h6 = "cyan_two",
    },

    palette = {
        -- Override the builtin palette per variant
        moon = overide,
    },

    highlight_groups = {
        Comment = { fg = "subtle", italic = true },
        VertSplit = { fg = "muted", bg = "muted" },
    },

    -- before_highlight = function(group, highlight, palette)
    before_highlight = function(_, _, _)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --	 highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.blue_two then
        --	 highlight.fg = palette.cyan_two
        -- end
    end,
}
