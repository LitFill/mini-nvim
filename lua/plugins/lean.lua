local deps = require('mini.deps')
local later = deps.later
local vim = vim

later(function()
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
        pattern = '*.lean',
        callback = function()
            require('lean').setup({
                mappings = true,
            })
        end,
    })
end)

return {
    source = 'Julian/lean.nvim',
    depends = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',

        -- Optional dependencies (uncomment if you use them)
        -- 'hrsh7th/nvim-cmp',              -- or 'Saghen/blink.cmp' for completion
        -- 'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
        -- 'andymass/vim-matchup',          -- for enhanced % motion
        -- 'andrewradev/switch.vim',        -- for switch support
        -- 'tomtom/tcomment_vim',           -- for commenting
    },
}
