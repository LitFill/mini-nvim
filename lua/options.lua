---@diagnostic disable: undefined-global

-- Konfigurasi opsi
vim.g.mapleader = " " -- Set leader key ke spasi
vim.g.maplocalleader = " " -- Leader key lokal

-- Opsi dasar
vim.opt.tabstop = 4 -- Jumlah spasi per tab
vim.opt.shiftwidth = 4 -- Jumlah spasi untuk indentasi
vim.opt.expandtab = true -- Konversi tab ke spasi
vim.opt.smartindent = true -- Indentasi cerdas
vim.opt.wrap = false -- Tidak wrap text
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Case-sensitive jika ada huruf besar
vim.opt.termguicolors = true -- Enable true color
vim.opt.cursorline = true -- Highlight baris kursor
vim.opt.mouse = "a" -- Enable mouse
vim.opt.clipboard = "unnamedplus" -- Sync dengan clipboard sistem
vim.opt.signcolumn = "yes:2" -- ensure 2 signcolumns

-- Opsi khusus
vim.opt.undofile = true -- Simpan undo history
vim.opt.splitright = true -- Split vertical ke kanan
vim.opt.splitbelow = true -- Split horizontal ke bawah
vim.opt.foldmethod = "indent"

-- Neovim 0.11
vim.diagnostic.config {
    virtual_lines = {
        current_line = true,
    },
}

-- Highlight untuk matching parent
vim.api.nvim_set_hl(0, "MatchParen", { bg = "darkblue" })
