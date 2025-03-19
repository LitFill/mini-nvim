---@diagnostic disable: undefined-global

--- list of mini.nvim family ofplugins I want to be activated
---@type string[]
local enabled_modules = {
    'ai',
    'align',
    'bracketed',
    'comment',
    'completion',
    'cursorword',
    'diff',
    'doc',
    'extra',
    'files',
    'git',
    'icons',
    'indentscope',
    'jump',
    'jump2d',
    'move',
    'notify',
    'operators',
    'pairs',
    'pick',
    'splitjoin',
    'starter',
    'statusline',
    'surround',
    'tabline',
    'trailspace',
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

---@param plugin string | { source: string, name?: string, depends?: string | string[] }
local function add(plugin)
    MiniDeps.add(plugin)
end

add {
    source  = 'neovim/nvim-lspconfig',
    depends = { 'williamboman/mason.nvim' },
    name    = 'lspconfig',
}

require('mason').setup()
local lsp = require 'lspconfig'
lsp.lua_ls.setup {}
-- lsp.hls.setup {}
lsp.unison.setup {
    on_attach = function(_, bufnr)
        vim.o.signcolumn = 'yes'
        vim.o.updatetime = 250
        vim.diagnostic.config { virtual_text = false }

        vim.api.nvim_create_autocmd("CursorHold", {
            buffer   = bufnr,
            callback = function()
                local opts = {
                    focusable    = false,
                    close_events = {
                        "BufLeave",
                        "CursorMoved",
                        "InsertEnter",
                        "FocusLost",
                    },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope  = 'cursor',
                }
                vim.diagnostic.open_float(nil, opts)
            end
        })
    end
}

lsp.denols.setup {
    root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
    init_options = {
        lint = true,
        unstable = true,
    },
}

-- lsp.denols.setup {}

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}

add(require "plugins.flexoki")
require('myflexoki')

add(require "plugins.nvim-treesitter")
require('nvim-treesitter.configs').setup {
	ensure_installed = {
	    'lua',
	    'vimdoc',
        'haskell',
	},
	highlight = { enable = true },
}

add(require "plugins.neogit")

add "rafamadriz/friendly-snippets"

add(require "plugins.transparent")

add(require "plugins.nvim-origami")
require("origami").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        MiniTrailspace.trim()
    end
})

add {
    source = "mrcjkb/haskell-tools.nvim",
    name   = "haskell-tools"
}

local function setup_haskell_keymaps()
    local ht    = require('haskell-tools')
    local bufnr = vim.api.nvim_get_current_buf()
    local opt   = { buffer = bufnr }
    local set   = vim.keymap.set

    local nset = function(key, cmd, opts)
        set('n', key, cmd, opts)
    end

    ---@param desc string
    ---@return { buffer: number, desc: string}
    local desc = function(desc)
        opt.desc = desc
        return opt
    end

    -- Leader-c mappings untuk Cabal
    nset('<Leader>cb', '<CMD>vs | term cabal build<CR>', desc 'Cabal Build'    )
    nset('<Leader>cr', '<CMD>vs | term cabal run<CR>',   desc 'Cabal Run'      )
    nset('<Leader>ct', '<CMD>vs | term cabal test<CR>',  desc 'Cabal Test'     )
    nset('<Leader>cc', '<CMD>edit *.cabal<CR>',          desc 'Open Cabal File')
    nset(
        '<leader>ci',
        '<CMD>vs | term cabal install --installdir=./bin --overwrite-policy=always<CR>',
        desc 'Cabal Install in bin directory'
    )

    -- Leader-h mappings untuk Haskell Tools
    nset('<Leader>hh',  ht.hoogle.hoogle_signature, desc 'Hoogle Search'      )
    nset('<Leader>hr',  ht.repl.toggle,             desc 'Toggle REPL'        )
    nset('<Leader>ht',  vim.lsp.buf.hover,          desc 'Show Type Signature')

    -- nset('<Leader>hca', vim.lsp.code_actions,        desc 'Code Actions'       )
    -- nset('<Leader>hd',  ht.docs.buf.hover,          desc 'Show Documentation' )
    -- nset('<Leader>hf', '<CMD>lua vim.lsp.buf.format()<CR>', desc 'Format File')
end

-- Aktifkan keymaps hanya untuk file Haskell
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "haskell", "cabal", "*.hs", "*.cabal" },
    callback = setup_haskell_keymaps,
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = "*",
    callback = function()
        vim.o.winbar = "%{%v:lua.GetShortPath()%}"
    end
})

---@return string
function GetShortPath()
    local buf_path = vim.api.nvim_buf_get_name(0)
    if buf_path == "" then
        return "" -- Jika buffer kosong, tidak tampilkan apa-apa
    end

    local home         = vim.fn.expand("$HOME")
    local project_home = home .. "/proyek"

    -- Ganti bagian depan jika cocok
    if buf_path:find("^" .. vim.pesc(project_home)) then
        buf_path = buf_path:gsub(
            "^" .. vim.pesc(project_home) .. "/",
            ""
        )
    elseif buf_path:find("^" .. vim.pesc(home)) then
        buf_path = buf_path:gsub(
            "^" .. vim.pesc(home) .. "/",
            ""
        )
    end

    -- Format path menggunakan '->' sebagai separator
    local display_path1 = buf_path:gsub("//", "/")
    local display_path  = display_path1:gsub("/", " -> ")

    return "%#Normal#  LitFill :: " .. display_path
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = "*",
    once = true,
    callback = function() vim.opt.scrolloff = 8 end
})

add(require "plugins.render-markdown")

add(require "plugins.nvim-focus")
require("focus").setup()
