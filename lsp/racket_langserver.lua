local vim = vim

return {
    cmd = { "xvfb-run", "racket", "-l", "racket-langserver" },
    filetypes = { "racket", "scheme" },
    root_markers = {},
    root_dir = function(_)
        return vim.fn.getcwd()
    end,
    on_attach = function(_, bufnr)
        local opt = {
            noremap = true,
            silent = true,
            buffer = bufnr,
        }
        local nset = function(key, cmd, opts)
            vim.keymap.set("n", key, cmd, opts)
        end

        nset("gd", vim.lsp.buf.definition, opt)
        nset("gr", vim.lsp.buf.references, opt)
        nset("K", vim.lsp.buf.hover, opt)
    end,
}
