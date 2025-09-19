---@diagnostic disable: different-requires
----------------------------------------
--- PLUGINS
----------------------------------------

local function add(plugin)
    require("mini.deps").add(plugin)
end

---@param modname string
-- HACK: untuk tetap mendapakan completion untuk file plugins
local require = function(modname)
    add(require(modname))
end

add "echasnovski/mini.nvim"
add "rafamadriz/friendly-snippets"

-- Colorschemes
require "plugins.flexoki"

-- UI
require "plugins.nvim-focus"
require "plugins.nvim-origami"
require "plugins.rainbow-delimiters"
require "plugins.stay-centered"
require "plugins.todo-comments"
require "plugins.transparent"
require "plugins.colorizer"
require "plugins.sqlua"
require "plugins.csvview"

-- Tools
require "plugins.neogit"
require "plugins.haskell-tools"
require "plugins.ghcid"
require "plugins.render-markdown"
require "plugins.idris2"

-- Treesitter
require "plugins.nvim-treesitter"

-- Completion
require "plugins.blink-cmp"
