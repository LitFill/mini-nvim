----------------------------------------
--- PLUGINS
----------------------------------------

local function add(plugin)
    require("mini.deps").add(plugin)
end

add "echasnovski/mini.nvim"
add "rafamadriz/friendly-snippets"

-- Colorschemes
add(require "plugins.flexoki")
add(require "plugins.neo-solarized")
add(require "plugins.catppuccin")

-- UI
add(require "plugins.nvim-focus")
add(require "plugins.nvim-origami")
add(require "plugins.rainbow-delimiter")
add(require "plugins.stay-centered")
add(require "plugins.todo-comments")
add(require "plugins.transparent")
add(require "plugins.clock")
add(require "plugins.colorizer")

-- Tools
add(require "plugins.neogit")
add(require "plugins.haskell-tools")
add(require "plugins.render-markdown")
add(require "plugins.lean")

-- Treesitter
add(require "plugins.nvim-treesitter")

-- Completion
add(require "plugins.blink-cmp")
