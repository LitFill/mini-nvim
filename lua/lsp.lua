-- Create an autocommand group to ensure commands are cleared on reload
local lsp_group = vim.api.nvim_create_augroup("OnDemandLsp", { clear = true })

-- Generic on_attach function
-- This runs each time an LSP attaches to a buffer.
-- You can add buffer-local keymaps and other settings here.
local function on_attach(client, bufnr)
    -- For example, uncomment these to set keymaps for LSP features
    local nset = vim.keymap.set
    local lsp  = vim.lsp.buf
    local opts = {
        buffer  = bufnr,
        noremap = true,
        silent  = true,
    }

    nset("n", "K", lsp.hover, opts)
    nset("n", "gd", lsp.definition, opts)
    nset("n", "gi", lsp.implementation, opts)
    nset("n", "<leader>ca", lsp.code_action, opts)
    nset("n", "<leader>rn", lsp.rename, opts)
end

-- Helper function to start LSP client
---@class LSPOpts
---@field name string
---@field cmd string[]
---@field root_files string[]

---@param opts LSPOpts
local function start_lsp(opts)
    vim.lsp.start {
        name = opts.name,
        cmd = opts.cmd,
        root_dir = vim.fs.root(0, opts.root_files),
        on_attach = on_attach,
    }
end

---@class aucmdopts
---@field group any
---@field pattern string | string[]
---@field callback function

--- Helper function for making autocommands
---@param trigger string
---@return function
local function mk_aucmd(trigger)
    ---@param opts vim.api.keyset.create_autocmd
    return function(opts)
        vim.api.nvim_create_autocmd(trigger, opts)
    end
end

--#region LSP
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                }
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})

vim.lsp.enable {
    "bashls",
    "clangd",
    "docker_language_server",
    "jsonls",
    "lua_ls",
    "rust_analyzer",
    "sqls",
    "ts_ls",
}

-- Racket
mk_aucmd "FileType" {
    group = lsp_group,
    pattern = "racket",
    callback = function()
        start_lsp {
            name = "racket_langserver",
            cmd = { "racket", "--lib", "racket-langserver" },
            root_files = { ".git" },
        }
    end,
}

-- Purescript
mk_aucmd "FileType" {
    group = lsp_group,
    pattern = "purescript",
    callback = function()
        start_lsp {
            name = "purescriptls",
            cmd = { "purescript-language-server", "--stdio" },
            root_files = { "spago.dhall", "psc-package.json", ".git" },
        }
    end,
}

-- Prolog
mk_aucmd "FileType" {
    group = lsp_group,
    pattern = "prolog",
    callback = function()
        start_lsp {
            name = "prolog",
            cmd = {
                "swipl",
                "-g",
                "main",
                "-t",
                "halt",
                "prolog/prolog_lsp.pl",
                "-f",
            },
            root_files = { ".git" },
        }
    end,
}

-- Unison
mk_aucmd "FileType" {
    group = lsp_group,
    pattern = "unison",
    callback = function()
        start_lsp {
            name = "unison",
            cmd = { "ucm", "lsp" },
            root_files = { "_ui" },
        }
    end,
}

-- Lean
mk_aucmd "FileType" {
    group = lsp_group,
    pattern = "lean",
    callback = function()
        start_lsp {
            name = "lean",
            cmd = { "lake", "serve", "--" },
            root_files = {
                "lakefile.toml",
                "lake-manifest.json",
                "lean-toolchain",
            },
        }
        vim.o.makeprg = "lake build"
    end,
}
--#endregion LSP
