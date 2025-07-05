---@diagnostic disable: undefined-global, different-requires

require "minis"

require "options"
require "keymaps"
require "plugins"
require "autocmds"

-- Colorscheme
require "myflexoki"

vim.cmd "colorscheme flexoki"

-- Plugin configurations
require "nvim-treesitter.configs"
.setup {
    ensure_installed = {
        "lua",
        "vimdoc",
        "haskell",
    },
    highlight = { enable = true },
}

require "origami"            .setup()
require "todo-comments"      .setup()
require "stay-centered"      .setup()
require "colorizer"          .setup()
require "sqlua"              .setup()

-- require "lean"          .setup()

-- ensure this ↓ is the last line
require "neovide"
