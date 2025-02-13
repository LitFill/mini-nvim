local enabled_modules = {
    'git',
    'diff',
    'icons',
    'statusline',
    'starter',
    'indentscope',
    'files',
    'comment',
    'completion',
    'notify',
    'bracketed',
    'pick',
    'jump',
    'jump2d',
    'align',
    'surround',
    'ai',
    'operators',
    'move',
    'pairs',
    'trailspace',
    'splitjoin',
}

for _, module in ipairs(enabled_modules) do
	local mod = 'mini.' .. module
    require(mod).setup()
end

require('mini.clue').setup {
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"'     },
		{ mode = 'x', keys = '"'     },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },
    },

    clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		-- miniclue.gen_clues.builtin_completion(),
		-- miniclue.gen_clues.g(),
		-- miniclue.gen_clues.marks(),
		-- miniclue.gen_clues.registers(),
		-- miniclue.gen_clues.windows(),
		-- miniclue.gen_clues.z(),
    },
}

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
}

require "options"
require "keymaps"

-- -@type function(function())
-- local now   = MiniDeps.now
-- local later = MiniDeps.later

---@type function(plugin: { source: string })
local add = MiniDeps.add

add {
    source  = 'neovim/nvim-lspconfig',
    depends = { 'williamboman/mason.nvim' },
    name    = 'lspconfig',
}

require('mason').setup()
local lsp = require 'lspconfig'
lsp.lua_ls.setup {}
lsp.hls.setup {}

add {
	source   = 'nvim-treesitter/nvim-treesitter',
	checkout = 'master',
	monitor  = 'main',
	hooks    = {
	    post_checkout = function() vim.cmd('TSUpdate') end
	},
}

require('nvim-treesitter.configs').setup {
	ensure_installed = {
	    'lua',
	    'vimdoc',
        'haskell',
	},
	highlight = { enable = true },
}

add {
	source  = "NeogitOrg/neogit",
	depends = {
		"nvim-lua/plenary.nvim", -- required
		-- "sindrets/diffview.nvim", -- optional - Diff integration
		-- "nvim-telescope/telescope.nvim", -- optional
	},
	config  = true,
}

add {
    source = "rafamadriz/friendly-snippets"
}

add {
	source = "nuvic/flexoki-nvim",
	name   = "flexoki",
}

require('myflexoki')

add {
    source = "xiyaowong/transparent.nvim",
    name   = "transparent",
}

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    {"Folded", "NormalFloat", "FloatBorder"}
)

add {
    source = "chrisgrieser/nvim-origami",
    name   = "origami",
}

require("origami").setup()

-- add {
--     source = "anuvyklack/pretty-fold.nvim",
--     name   = "pretty-fold"
-- }
--
-- require("pretty-fold").setup()
