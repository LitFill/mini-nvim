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
    -- local opts = { buffer = bufnr, noremap = true, silent = true }
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

-- Helper function to start LSP client
local function start_lsp(name, cmd, root_files)
    vim.lsp.start {
        name = name,
        cmd = cmd,
        root_dir = vim.fs.root(0, root_files),
        on_attach = on_attach,
    }
end

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "lua",
    callback = function()
        start_lsp("lua_ls", { "lua-language-server" }, { ".git", "lua" })
    end,
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "rust",
    callback = function()
        start_lsp(
            "rust_analyzer",
            { "rust-analyzer" },
            { "Cargo.toml", ".git" }
        )
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
        start_lsp("denols", { "deno", "lsp" }, { "deno.json", ".git" })
    end,
})

-- C/C++
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
    callback = function()
        start_lsp("clangd", { "clangd" }, { "compile_commands.json", ".git" })
    end,
})

-- Racket
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "racket",
    callback = function()
        start_lsp(
            "racket_langserver",
            { "racket", "--lib", "racket-langserver" },
            { ".git" }
        )
    end,
})

-- Purescript
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "purescript",
    callback = function()
        start_lsp(
            "purescriptls",
            { "purescript-language-server", "--stdio" },
            { "spago.dhall", "psc-package.json", ".git" }
        )
    end,
})

-- Prolog
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "prolog",
    callback = function()
        start_lsp(
            "prolog",
            {
                "swipl",
                "-g",
                "main",
                "-t",
                "halt",
                "prolog/prolog_lsp.pl",
                "-f",
            },
            { ".git" }
        )
    end,
})

-- Unison
vim.api.nvim_create_autocmd("FileType", {
    group = lsp_group,
    pattern = "unison",
    callback = function()
        start_lsp("unison", { "ucm", "lsp" }, { "_ui" })
    end,
})

-- Keep this setting
vim.g.markdown_fenced_languages = {
    "ts=typescript",
}
