local function setup_haskell_keymaps()
    local ht    = require "haskell-tools"
    local bufnr = vim.api.nvim_get_current_buf()
    local opt   = { buffer = bufnr }
    local set   = vim.keymap.set

    local nset = function(key, cmd, opts)
        set("n", key, cmd, opts)
    end

    ---@param desc string
    ---@return { buffer: number, desc: string}
    local desc = function(desc)
        opt.desc = desc
        return opt
    end

    vim.o.makeprg = "cabal build"

    -- Leader-c mappings untuk Cabal
    nset("<Leader>cb", "<CMD>vs | term cabal build<CR>", desc "Cabal Build")
    nset("<Leader>cr", "<CMD>vs | term cabal run<CR>",   desc "Cabal Run")
    nset("<Leader>ct", "<CMD>vs | term cabal test<CR>",  desc "Cabal Test")
    nset("<Leader>cc", "<CMD>edit *.cabal<CR>",          desc "Open Cabal File")
    nset(
        "<leader>ci",
        "<CMD>vs | term cabal install --installdir=./bin --overwrite-policy=always<CR>",
        desc "Cabal Install in bin directory"
    )

    -- Leader-h mappings untuk Haskell Tools
    nset("<Leader>hh", ht.hoogle.hoogle_signature, desc "Hoogle Search")
    nset("<Leader>hr", ht.repl.toggle,             desc "Toggle REPL")
    nset("<Leader>ht", vim.lsp.buf.hover,          desc "Show Type Signature")
end

return {
    setup_haskell_keymaps = setup_haskell_keymaps
}
