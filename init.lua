local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path    = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
	vim.cmd 'echo "Installing `mini.nvim`" | redraw'
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd 'packadd mini.nvim | helptags ALL'
	vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup { path = { package = path_package } }

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
}

for _, module in ipairs(enabled_modules) do
	local mod = 'mini.' .. module
	require(mod).setup()
end

require "options"
require "keymaps"

---@type function(plugin: { source: string })
local add   = MiniDeps.add
---@type function(function())
local now   = MiniDeps.now
-- local later = MiniDeps.later

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
	hooks    = { post_checkout = function() vim.cmd('TSUpdate') end },
}

require('nvim-treesitter.configs').setup {
	ensure_installed = { 'lua', 'vimdoc' },
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
	source = "nuvic/flexoki-nvim",
	name   = "flexoki",
}

require("flexoki").setup {
	variant                          = "auto", -- auto, moon, or dawn
	dark_variant                     = true,
	dim_inactive_windows             = false,
	extend_background_behind_borders = true,

	enable = {
		terminal = true,
	},

	styles = {
		bold   = true,
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
		-- moon = {
		--	 base    = '#100f0f',
		--	 overlay = '#1c1b1a',
		-- },
	},

	highlight_groups = {
		Comment   = { fg = "subtle", italic = true    },
		VertSplit = { fg = "muted" , bg     = "muted" },
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

vim.cmd "colorscheme flexoki"
