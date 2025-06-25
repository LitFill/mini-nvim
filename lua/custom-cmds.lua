local vim = vim

local function setup_haskell_keymaps()
    local ht = require "haskell-tools"
    local bufnr = vim.api.nvim_get_current_buf()
    local opt = { buffer = bufnr }
    local set = vim.keymap.set

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
    nset("<Leader>cr", "<CMD>vs | term cabal run<CR>", desc "Cabal Run")
    nset("<Leader>ct", "<CMD>vs | term cabal test<CR>", desc "Cabal Test")
    nset("<Leader>cc", "<CMD>edit *.cabal<CR>", desc "Open Cabal File")
    nset(
        "<leader>ci",
        "<CMD>vs | term cabal install --installdir=./bin --overwrite-policy=always<CR>",
        desc "Cabal Install in bin directory"
    )

    -- Leader-h mappings untuk Haskell Tools
    nset("<Leader>hh", ht.hoogle.hoogle_signature, desc "Hoogle Search")
    nset("<Leader>hr", ht.repl.toggle, desc "Toggle REPL")
    nset("<Leader>ht", vim.lsp.buf.hover, desc "Show Type Signature")

    -- nset ('<Leader>hca', vim.lsp.code_actions,        desc 'Code Actions'       )
    -- nset ('<Leader>hd',  ht.docs.buf.hover,          desc 'Show Documentation' )
    -- nset ('<Leader>hf', '<CMD>lua vim.lsp.buf.format ()<CR>', desc 'Format File')
end

-- Aktifkan keymaps hanya untuk file Haskell
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "cabal", "*.hs", "*.cabal" },
    callback = setup_haskell_keymaps,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "cargo", "*rs", "Cargo.toml" },
    callback = function()
        vim.o.makeprg = "cargo build"
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.o.winbar = "%{%v:lua.GetShortPath()%}"
    end,
})

---@return string
function GetShortPath()
    local buf_path = vim.api.nvim_buf_get_name(0)
    if buf_path == "" then
        return "" -- Jika buffer kosong, tidak tampilkan apa-apa
    end

    local home = vim.fn.expand "$HOME"
    local project_home = home .. "/proyek"

    -- Ganti bagian depan jika cocok
    if buf_path:find("^" .. vim.pesc(project_home)) then
        buf_path = buf_path:gsub("^" .. vim.pesc(project_home) .. "/", "")
    elseif buf_path:find("^" .. vim.pesc(home)) then
        buf_path = buf_path:gsub("^" .. vim.pesc(home) .. "/", "")
    end

    -- Format path menggunakan '->' sebagai separator
    local display_path1 = buf_path:gsub("//", "/")
    local display_path = display_path1:gsub("/", " -> ")

    return "%#MiniIconsPurple#  LitFill :: " .. display_path
end

vim.api.nvim_create_user_command("WithUnison", function(opts)
    local filename = opts.args
    local win = vim.api.nvim_get_current_win()
    vim.cmd "vsplit"
    vim.cmd "term ucm"
    vim.defer_fn(function()
        vim.api.nvim_set_current_win(win)
        vim.cmd("e " .. vim.fn.fnameescape(filename))
    end, 200)
end, { nargs = 1 })

local signcolumnGroup =
    vim.api.nvim_create_augroup("PersistentSigncolumn", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = signcolumnGroup,
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" and vim.wo.signcolumn ~= "yes:2" then
            vim.opt.signcolumn = "yes:2"
        end
    end,
    desc = "Ensure signcolumn is always 'yes:2' in normal buffers",
})

-- Autocommand to set makeprg for Mercury (.m) files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.m",
    callback = function()
        local file_path = vim.api.nvim_buf_get_name(0)
        local dir_path = vim.fn.fnamemodify(file_path, ":h")
        local dir_name = vim.fn.fnamemodify(dir_path, ":t")
        vim.opt_local.makeprg = "mmc --make " .. vim.fn.escape(dir_name, " ")
    end,
})

vim.api.nvim_create_user_command("Cd", [[cd %:h]], {})
