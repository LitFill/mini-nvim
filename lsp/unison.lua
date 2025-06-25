return {
    cmd = { "nc", "localhost", os.getenv "UNISON_LSP_PORT" or "5757" },
    filetypes = { "unison" },
    root_dir = {},
    settings = {},
    on_attach = function(_, _)
        vim.o.signcolumn = "yes"
        vim.o.updatetime = 250
    end,
}
