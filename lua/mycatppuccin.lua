local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
    vim.print "catppuccin error"
    return
end

catppuccin.setup {
    color_overrides = {
        frappe = {
            rosewater   = "#efc9c2",
            flamingo    = "#ebb2b2",
            pink        = "#f2a7de",
            -- mauve    = "#bd81ff",
            mauve       = "#ab4eff",
            red         = "#ff5779",
            maroon      = "#ff657d",
            -- peach    = "#ff8b3b",
            peach       = "#ce5e00",
            -- yellow   = "#eaca89",
            yellow      = "#ffc100",
            -- green    = "#48e500",
            green       = "#14c200",
            teal        = "#78cec1",
            sky         = "#91d7e3",
            -- sapphire = "#68bae0",
            sapphire    = "#00a6e4",
            -- blue     = "#689bff",
            blue        = "#3777fd",
            -- lavender = "#9da5ff",
            lavender    = "#7075d7",
            -- text     = "#b5c1f1",
            text        = "#d5cffb",
            subtext1    = "#a6b0d8",
            subtext0    = "#959ec2",
            overlay2    = "#848cad",
            overlay1    = "#717997",
            overlay0    = "#63677f",
            surface2    = "#505469",
            surface1    = "#3e4255",
            surface0    = "#2c2f40",
            base        = "#1a1c2a",
            mantle      = "#141620",
            crust       = "#0e0f16",
        },
    },
}
