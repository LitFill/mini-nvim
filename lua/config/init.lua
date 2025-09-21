require "config.minis"

require "core.options"
require "core.keymaps"
require "plugins"
require "core.autocmds"
require "utils"

vim.cmd "colorscheme miniwinter"

----------------------------------------
--- Plugin configurations
----------------------------------------
require  "config.treesitter"
require  "config.lsp"

require  "origami"        .setup()
require  "todo-comments"  .setup()
require  "colorizer"      .setup()
require  "sqlua"          .setup()

require  "stay-centered"  .setup
{
    skip_filetypes = {""},
}

require  "idris2"         .setup
{
    client = {
        hover = {
            use_split         = true,    -- Persistent split instead of popups for hover
            auto_resize_split = true,    -- Should resize split to use minimum space
            with_history      = true,    -- Show history of hovers instead of only last
            split_position    = "right", -- bottom, top, left or right
            split_size        = "20%",   -- Size of persistent split, if used
        },
    },
}

-- ensure this ↓ is the last line
require "config.neovide"
