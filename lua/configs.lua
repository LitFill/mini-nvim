require "minis"

require "options"
require "keymaps"
require "plugins"
require "autocmds"

-- Colorscheme
require "myflexoki"

-- vim.cmd "colorscheme flexoki"
vim.cmd "colorscheme miniwinter"

-- Plugin configurations
require "nvim-treesitter.configs" .setup
{ ensure_installed =
    { "lua"
    , "vimdoc"
    , "haskell"
    }
, highlight =
    { enable = true

    , disable = function (_, buf)
            local max_filesize = 1000 * 1024
            local ok, stats =
                pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if  ok and stats and
                stats.size > max_filesize
            then
                return true
            end
        end
    }
}

--- @class ParserConf
--- @field install_info table
--- @field filetype string

--- make a parser config for treesitter
--- @param url string
--- @param file_type string
--- @return ParserConf
local mk_parser_conf = function(url, file_type)
    return {
        install_info = {
            url = url,
            files = { "src/parser.c" },
            generate_requires_npm = false,
            requires_generate = false,
        },
        filetype = file_type,
    }
end

local mk_parser_conf_proyek_dir =
function(url)
    return function(filetype)
        return mk_parser_conf("/home/litfill/proyek/" .. url, filetype)
    end
end

local parser_conf = require "nvim-treesitter.parsers" .get_parser_configs()

parser_conf.laras = mk_parser_conf_proyek_dir "laras-ts"                     "laras"
parser_conf.simp  = mk_parser_conf_proyek_dir "tree-sitter-simp-lang"        "simp"
parser_conf.lamb  = mk_parser_conf_proyek_dir "tree-sitter-lamb"             "lamb"
parser_conf.lbnf  = mk_parser_conf_proyek_dir "third-party/tree-sitter-lbnf" "lbnf"

vim.filetype.add { extension = { cf = "lbnf" } }

require  "origami"        .setup()
require  "todo-comments"  .setup()
require  "colorizer"      .setup()
require  "sqlua"          .setup()

require  "stay-centered"  .setup
{
    skip_filetypes = {""},
}

-- require "lean"          .setup()

-- Idris2

require 'idris2'
.setup {
    client = {
        hover = {
            use_split         = true,    -- Persistent split instead of popups for hover
            split_size        = '20%',   -- Size of persistent split, if used
            auto_resize_split = true,    -- Should resize split to use minimum space
            split_position    = 'right', -- bottom, top, left or right
            with_history      = true,    -- Show history of hovers instead of only last
        },
    },
}

-- LSP
-- require "lspconfig" .setup()

function ToggleSplitDirection()
    if vim.fn.winnr('$') ~= 2 then
        print("Error: Requires exactly two windows")
        return
    end
    local win_pos1 = vim.fn.win_screenpos(1)
    local win_pos2 = vim.fn.win_screenpos(vim.fn.winnr('$'))
    if win_pos1[1] == win_pos2[1] then  -- Vertical split
        if vim.fn.winnr() == 1 then
            vim.cmd('wincmd K')
        else
            vim.cmd('wincmd J')
        end
    else  -- Horizontal split
        if vim.fn.winnr() == 1 then
            vim.cmd('wincmd H')
        else
            vim.cmd('wincmd L')
        end
    end
end
vim.keymap.set('n', '<leader>ts', ':lua ToggleSplitDirection()<CR>', { noremap = true, silent = true })

function ListBuffers()
    local buffers = vim.fn.getbufinfo()
    for _, buf in ipairs(buffers) do
        local mod = buf.changed == 1 and '[+]' or ''
        print(buf.bufnr .. ': ' .. buf.name .. ' ' .. mod)
    end
end
vim.keymap.set('n', '<leader>bl', ':lua ListBuffers()<CR>', { noremap = true, silent = true })

function DeleteInactiveBuffers()
    local buffers = vim.fn.getbufinfo()
    for _, buf in ipairs(buffers) do
        if buf.hidden == 1 and buf.changed == 0 then
            vim.cmd('bdelete ' .. buf.bufnr)
        end
    end
    print('Inactive buffers deleted')
end
vim.keymap.set('n', '<leader>bd', ':lua DeleteInactiveBuffers()<CR>', { noremap = true, silent = true })

function SwitchBuffer()
    local bufnum = vim.fn.input('Buffer number: ')
    if tonumber(bufnum) and vim.fn.bufexists(tonumber(bufnum)) == 1 then
        vim.cmd('buffer ' .. bufnum)
    else
        print(' Invalid buffer')
    end
end
vim.keymap.set('n', '<leader>bs', ':lua SwitchBuffer()<CR>', { noremap = true, silent = true })

function WipeoutBuffers()
    vim.cmd('silent! %bdelete|edit #|normal `"')
end
vim.keymap.set('n', '<leader>bw', ':lua WipeoutBuffers()<CR>', { noremap = true, silent = true })

-- ensure this ↓ is the last line
require "neovide"
