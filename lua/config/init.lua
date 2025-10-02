local import = require

import "config.minis"

import "core.options"
import "core.keymaps"
import "plugins"
import "core.autocmds"
import "utils"

vim.cmd "colorscheme miniwinter"

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
