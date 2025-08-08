---@diagnostic disable: undefined-global, different-requires

require "minis"

require "options"
require "keymaps"
require "plugins"
require "autocmds"

-- Colorscheme
require "myflexoki"

vim.cmd "colorscheme flexoki"

require "lackluster" .setup
{ tweak_syntax =
    { comment = "#dddddd"
    }
}

-- vim.cmd "colorscheme lackluster-mint"

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

parser_conf.laras = mk_parser_conf_proyek_dir "laras-ts"              "laras"
parser_conf.simp  = mk_parser_conf_proyek_dir "tree-sitter-simp-lang" "simp"
parser_conf.lamb  = mk_parser_conf_proyek_dir "tree-sitter-lamb"      "lamb"

require  "origami"        .setup()
require  "todo-comments"  .setup()
require  "stay-centered"  .setup()
require  "colorizer"      .setup()
require  "sqlua"          .setup()

-- require "lean"          .setup()

-- LSP
-- require "lspconfig" .setup()

vim.lsp.enable "ts_ls"

-- ensure this ↓ is the last line
require "neovide"
