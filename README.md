# LitFill's Mini Neovim Configuration

Konfigurasi Neovim yang ringan dan cepat menggunakan `mini.nvim` sebagai
basisnya. Dibuat karena `lazy.nvim` mulai terasa berat dan bertujuan untuk
menyediakan lingkungan pengembangan yang minimalis namun tetap fungsional.

## Fitur Utama

*   **Manajemen Plugin**: Menggunakan `mini.nvim` untuk manajemen plugin yang
    efisien.
*   **Dukungan LSP**: Konfigurasi siap pakai untuk beberapa Language Server,
    termasuk `clangd`, `denols`, `lua_ls`, `rust_analyzer`, dan lainnya.
*   **Tema**: Termasuk tema populer seperti `Catppuccin` dan `Flexoki`.
*   **Integrasi Git**: Disediakan melalui `Neogit`.
*   **Highlight Sintaks**: Ditingkatkan dengan `nvim-treesitter`.

## Prasyarat

Sebelum menginstal, pastikan Anda telah menginstal perangkat lunak berikut:

*   `Neovim` (v0.9.0 atau lebih baru)
*   `git`
*   (Opsional) [Nerd Font](https://www.nerdfonts.com/) untuk tampilan ikon yang benar.

## Instalasi

Salin dan jalankan perintah berikut di terminal Anda. Perintah ini akan
mencadangkan konfigurasi lama (jika ada), mengkloning yang baru, dan langsung
menjalankannya.

```sh
if [ -d ~/.config/nvim ] || [ -L ~/.config/nvim ]; then mv ~/.config/nvim ~/.config/nvim-backup; fi; \
git clone https://github.com/LitFill/mini-nvim.git ~/.config/nvim && \
nvim
```

Saat pertama kali dijalankan, `mini.nvim` akan secara otomatis mengunduh dan
mengatur semua plugin yang diperlukan.
