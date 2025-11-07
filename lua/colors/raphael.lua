-- File: ~/.config/nvim/colors/raphael_scheme.lua

-- 1. Definisi Palet Warna
-- Tetapkan nilai HEX untuk setiap elemen warna yang Anda inginkan
local colors = {
    bg = "#1A1B26",        -- Latar belakang gelap (Optimal)
    fg = "#A9B6C7",        -- Teks latar depan
    red = "#F7768E",       -- Warna untuk error/penting
    green = "#9ECE6A",     -- Warna untuk sukses/string
    blue = "#7AA2F7",      -- Warna untuk fungsi/keyword
    yellow = "#E0AF68",    -- Warna untuk konstanta
    comment = "#565F89",   -- Warna untuk komentar
}

-- 2. Fungsi Pembantu untuk Set Highlight
-- Fungsi ini menyederhanakan pemanggilan vim.api.nvim_set_hl
local function set_hl(group, fg, bg, style)
    vim.api.nvim_set_hl(0, group, {
        fg = fg and colors[fg], -- Ambil warna dari palet
        bg = bg and colors[bg],
        italic = style == "italic" or nil,
        bold = style == "bold" or nil,
        underline = style == "underline" or nil,
    })
end

-- 3. Reset dan Pengaturan Awal
-- Wajib mengatur latar belakang default dan membersihkan highlight lama
set_hl("Normal", "fg", "bg") -- Background dan Foreground default
set_hl("Comment", "comment", nil, "italic") -- Komentar dengan gaya miring

-- 4. Definisi Highlight Group Kunci
-- Definisikan elemen sintaksis utama (Syntax Highlighting)

-- Untuk Keyword (misalnya: local, function, end)
set_hl("Keyword", "blue", nil, "bold")

-- Untuk String (teks di dalam kutip)
set_hl("String", "green")

-- Untuk Numerik dan Konstanta (misalnya: true, nil)
set_hl("Number", "yellow")
set_hl("Constant", "yellow")

-- Untuk Fungsi dan Pemanggilan Fungsi
set_hl("Function", "blue")

-- Untuk Error (pesan kesalahan)
set_hl("Error", "red", "bg")

-- **Contoh Tambahan Penting (UI Groups):**

-- Statusline
set_hl("StatusLine", "fg", "blue")
set_hl("StatusLineNC", "comment", "bg") -- NC = Not Current

-- Line Number
set_hl("LineNr", "comment")

-- Cursor Line
set_hl("CursorLine", nil, "bg", "underline")

-- Akhiri dengan menetapkan nama skema
vim.g.colors_name = "raphael_scheme"
