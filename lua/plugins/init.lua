---@diagnostic disable: different-requires
----------------------------------------
--- PLUGINS
----------------------------------------

local function add(plugin)
    require("mini.deps").add(plugin)
end

-- HACK: untuk tetap mendapakan completion untuk file plugins
-- it has to be an assignment not a function definition to
-- avoid stack overflow from wrong recursion
---@param modname string
local require = function(modname) add(require(modname)) end

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
require "plugins.render-markdown"
require "plugins.idris2"
require "plugins.cornelis"  -- for Agda-mode
-- require "plugins.ghcid"

-- Treesitter
require "plugins.nvim-treesitter"
require "plugins.kmonad"

-- Completion
require "plugins.blink-cmp"
