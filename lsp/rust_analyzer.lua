return {
    cmd          = { 'rust-analyzer' },
    filetypes    = { 'rust'          },
    root_markers = { 'Cargo.toml'    },
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = { group = "module" },
                prefix      = "self",
            },
            cargo = {
                buildScripts = { enable = true },
            },
            procMacro = { enable = true },
        },
    },
}
