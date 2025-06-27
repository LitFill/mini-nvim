return {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },

    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },

    ---@type lean.Config
    opts = { -- see below for full configuration options
        mappings = true,
        lsp = {
            init_options = {
                editDelay = 0,
                hasWidgets = true,
            },
        },
        infoview = {
            autoopen = true,
            width = 50,
            height = 20,
            horizontal_position = "bottom",
            separate_tab = false,
            indicators = "auto",
        },
        progress_bars = {
            enable = true,
            character = "│",
            priority = 10,
        },
        stderr = {
            enable = true,
            height = 5,
            on_lines = nil,
        },
    },
}
