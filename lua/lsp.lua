-- lua/lsp.lua
-- LSP servers are loaded on-demand based on file type.

local vim = vim

-- Create an autocommand group to ensure commands are cleared on reload
local lsp_group = vim.api.nvim_create_augroup("OnDemandLsp", { clear = true })

-- Generic on_attach function
-- This runs each time an LSP attaches to a buffer.
-- You can add buffer-local keymaps and other settings here.
local function on_attach(client, bufnr)
    -- For example, uncomment these to set keymaps for LSP features
    local nset  = vim.keymap.set
    local lsp   = vim.lsp.buf
    local opts  = {
        buffer  = bufnr,
        noremap = true,
        silent  = true,
    }

    nset("n", "K",          lsp.hover,          opts)
    nset("n", "gd",         lsp.definition,     opts)
    nset("n", "gi",         lsp.implementation, opts)
    nset("n", "<leader>ca", lsp.code_action,    opts)
    nset("n", "<leader>rn", lsp.rename,         opts)
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

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    group    = lsp_group,
    pattern  = "lua",
    callback = function()
        start_lsp {
            name       = "lua_ls",
            cmd        = { "lua-language-server" },
            root_files = { ".git", "lua" },
        }
    end,
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "rust",
    callback = function()
        start_lsp {
            name = "rust_analyzer",
            cmd = { "rust-analyzer" },
            root_files = { "Cargo.toml", ".git" },
        }
        vim.o.makeprg = "cargo build"
    end,
})

-- Deno (JS/TS)
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
    },
    callback = function()
        start_lsp {
            name = "denols",
            cmd = { "deno", "lsp" },
            root_files = { "deno.json", ".git" },
        }
        vim.o.makeprg = "deno build"
    end,
})

-- C/C++
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
    callback = function()
        start_lsp {
            name = "clangd",
            cmd = { "clangd" },
            root_files = { "compile_commands.json", ".git" },
        }
    end,
})

-- Racket
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "racket",
    callback = function()
        start_lsp {
            name = "racket_langserver",
            cmd = { "racket", "--lib", "racket-langserver" },
            root_files = { ".git" },
        }
    end,
})

-- Purescript
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "purescript",
    callback = function()
        start_lsp {
            name = "purescriptls",
            cmd = { "purescript-language-server", "--stdio" },
            root_files = { "spago.dhall", "psc-package.json", ".git" },
        }
    end,
})

-- Prolog
vim.api.nvim_create_autocmd("FileType", {
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
})

-- Unison
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "unison",
    callback = function()
        start_lsp {
            name = "unison",
            cmd = { "ucm", "lsp" },
            root_files = { "_ui" },
        }
    end,
})

-- Lean
vim.api.nvim_create_autocmd("FileType", {
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
})

-- vim.g.markdown_fenced_languages = {
--     "ts=typescript",
-- }
