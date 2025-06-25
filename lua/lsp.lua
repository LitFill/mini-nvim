local vim = vim
----------------------------------------
--- LSP
----------------------------------------

vim.lsp.enable "lua_ls"
vim.lsp.enable "unison"
vim.lsp.enable "denols"
vim.lsp.enable "racket_langserver"
vim.lsp.enable "purescriptls"
vim.lsp.enable "clangd"
vim.lsp.enable "prolog"
vim.lsp.enable "rust_analyzer"

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
