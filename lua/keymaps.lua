local set = vim.keymap.set

--- add desc to opts for set
---
---@param opts? vim.keymap.set.Opts
---@param description string
---@return vim.keymap.set.Opts
local function desc(description, opts)
    if not opts then return { desc = description } end
    opts.desc = description
    return opts
end

-- convenient
set("n", "<leader>qw", "<cmd>wq<CR>",   desc "save and quit")
set("n", "<Esc>",      "<cmd>nohl<CR>", desc("No Highlight", { silent = true }))

set("n", "<C-s>",     "<cmd>write<CR>", desc "save")
set("n", "<leader>w", "<cmd>write<CR>", desc "save")

set({ "i", "v" }, "kj", "<Esc>", desc "exit to normal")

set("n", "<leader>cd", "<cmd>Cd<CR>", desc "cd to this file dir")

-- using makefile
set("n",  "<leader>mr",  "<cmd>term make run<CR>",        desc "(m)ake (r)un")
set("n",  "<leader>mb",  "<cmd>term make build<CR>",      desc "(m)ake (b)uild")
set( "n", "<leader>mqb", "<cmd>term make build<CR>a<CR>", desc "quick build")

set({ "n", "v" }, "J",         "mzJ`z", desc "shift+j but the cursor stay in place")
set({ "n", "v" }, "<leader>d", '"_d',   desc "delete without saving to register")

--- using fixlist
set("n", "<C-k>",     "<cmd>cnext<CR>", desc "Next quickfix")
set("n", "<C-j>",     "<cmd>cprev<CR>", desc "Previous quickfix")
set("n", "<leader>k", "<cmd>lnext<CR>", desc "Next location")
set("n", "<leader>j", "<cmd>lprev<CR>", desc "Previous location")

set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    desc "(r)eplace (w)ord"
)

--- open MiniFiles
set("n", "-", "<cmd>lua MiniFiles.open()<CR>", desc "Open parent dir")

-- toggle transparency
set( "n", "<leader>utr", "<cmd>TransparentToggle<CR>", desc "Toggle transparent background")

-- Terminal
set("t", "<C-q>",      "<C-\\><C-n>",         desc("quit terminal", { nowait = true }))
set("n", "<leader>ot", "<cmd>term<CR>a",      desc "(o)pen (t)erminal")
set("n", "<leader>vt", "<cmd>vs | term<CR>a", desc "(v)ertical pane (t)erminal")
set("n", "<leader>st", "<cmd>sp | term<CR>a", desc "(v)ertical pane (t)erminal")

-- mini.pick
set("n", "<leader>pb", "<cmd>Pick buffers<CR>",  desc "(p)ick (b)uffers")
set("n", "<leader>pf", "<cmd>Pick files<CR>",    desc "(p)ick (f)iles")
set("n", "<leader>ph", "<cmd>Pick help<CR>",     desc "(p)ick (h)elp")
set("n", "<leader>:",  "<cmd>Pick commands<CR>", desc "(p)ick (c)ommand")
set("n", "<leader>po", "<cmd>Pick options<CR>",  desc "(p)ick (o)ption")

-- NeoGit
set("n", "<leader>gn", "<cmd>Neogit<CR>", desc "open NeoGit")

-- LSP
local lsp_action = vim.lsp.buf
set("n", "<leader>ca", lsp_action.code_action, desc "(c)ode (a)ction LSP")
set("n", "<leader>rn", lsp_action.rename,      desc "rename using lsp")
set("n", "<leader>gd", lsp_action.definition,  desc "go to definition LSP")

-- --- Typst Preview
-- set("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", desc "Toggle Typst Preview in browser")

-- --- Idris2 lsp
local bufopts = { noremap = true }
local cmd = [[:lua require("idris2.code_action")]]
set("n", "<leader>iev", [[:lua require("idris2.repl").evaluate()<CR>]], desc("evaluate", bufopts))

set("n", "<leader>ics", cmd .. ".case_split()<CR>",   desc("case split",          bufopts))
set("n", "<leader>imc", cmd .. ".make_case()<CR>",    desc("make case",           bufopts))
set("n", "<leader>iml", cmd .. ".make_lemma()<CR>",   desc("make lemma",          bufopts))
set("n", "<leader>iac", cmd .. ".add_clause()<CR>",   desc("add clause",          bufopts))
set("n", "<leader>ies", cmd .. ".expr_search()<CR>",  desc("search expression",   bufopts))
set("n", "<leader>igd", cmd .. ".generate_def()<CR>", desc("generate definition", bufopts))
set("n", "<leader>irh", cmd .. ".refine_hole()<CR>",  desc("refine hole",         bufopts))
set("n", "<leader>iin", cmd .. ".intro()<CR>",        desc("intro",               bufopts))
