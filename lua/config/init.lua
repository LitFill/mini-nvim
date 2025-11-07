local import = require

import "config.minis"

import "core.options"
import "core.keymaps"
import "plugins"
import "core.autocmds"
import "utils"


-- Load dynamic Noctalia colorscheme
local noctalia = require("colors.noctalia")
noctalia.load()

-- Command to manually update colors
vim.api.nvim_create_user_command("UpdateColors", noctalia.load, {})

-- Watch for changes in colors.json using libuv
local colors_file = vim.fn.expand("~/.config/noctalia/colors.json")
local color_watcher = vim.loop.new_fs_event()

local function reload_colors()
    -- Use pcall to safely load colors, as file events can be noisy
    local ok, _ = pcall(noctalia.load)
    if not ok then
        vim.notify("Failed to reload Noctalia colors.", vim.log.levels.WARN)
    end
end

-- Schedule the reload to run on the main loop
local scheduled_reload = vim.schedule_wrap(reload_colors)

color_watcher:start(colors_file, {}, function(err, filename, events)
    vim.notify("Color watcher started.", vim.log.levels.INFO)
    if err then
        vim.notify("Color watcher error: " .. tostring(err), vim.log.levels.ERROR)
        return
    end

    -- Reload on change or rename
    if events.change or events.rename then
        scheduled_reload()
    end
end)

-- Stop the watcher when Neovim exits
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        color_watcher:stop()
    end,
    desc = "Stop Noctalia color watcher",
})

----------------------------------------
---      Plugin configurations       ---
----------------------------------------
import  "config.treesitter"
import  "config.lsp"

import  "origami"        .setup()
import  "todo-comments"  .setup()
import  "colorizer"      .setup()
import  "sqlua"          .setup()

import  "stay-centered"  .setup
{
    skip_filetypes = {""},
}

import  "idris2"         .setup
{
    client = { hover = {
        use_split         = true,    -- Persistent split instead of popups for hover
        auto_resize_split = true,    -- Should resize split to use minimum space
        with_history      = true,    -- Show history of hovers instead of only last
        split_position    = "right", -- bottom, top, left or right
        split_size        = "20%",   -- Size of persistent split, if used
    }},
}

-- ensure this ↓ is the last line
import "config.neovide"
