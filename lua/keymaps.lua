local set = vim.keymap.set

-- --- add desc to opts for set
-- ---@param opts vim.keymap.set.Opts
-- ---@param desc string
-- ---@return vim.keymap.set.Opts
-- local d = function(opts, desc)
--     opts.desc = desc
--     return opts
-- end

-- convenient
set({ "i", "t" }, "jk", "<Esc>", { nowait = true, desc = "exit to normal" })
set("n", "<leader>qw", "<cmd>wq<CR>", { desc = "save and quit" })

-- using makefile
set("n", "<leader>mr",  "<cmd>term make run<CR>",        { desc = "(m)ake (r)un" })
set("n", "<leader>mb",  "<cmd>term make build<CR>",      { desc = "(m)ake (b)uild" })
set("n", "<leader>mqb", "<cmd>term make build<CR>a<CR>", { desc = "quick build" })

set("n", "<leader>pv", vim.cmd.Ex, { desc = "preview pwd" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J",     "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n",     "nzz")
set("n", "N",     "Nzz")

set({ "n", "v" }, "<leader>d", [["_d]])

-- set("n", "<C-k>"    , "<cmd>cnext<CR>zz")
-- set("n", "<C-j>"    , "<cmd>cprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")

set(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "(r)eplace (w)ord" }
)

set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open parent dir" })

-- set("n", "<leader>utr", "<cmd>TransparentToggle<CR>", { desc = "Toggle transparent background" })

set("t", "<C-q>", "<C-\\><C-n>", { nowait = true })
set(
	"n",
	"<leader>ot",
	"<cmd>term<CR><cmd>set nonumber norelativenumber<CR>a",
	{ desc = "(o)pen (t)erminal" }
)

-- mini.pick
set("n", "<leader>pb", "<cmd>Pick buffers<CR>", { desc = "(p)ick (b)uffers" })
set("n", "<leader>pf", "<cmd>Pick files<CR>",   { desc = "(p)ick (f)iles" })

-- NeoGit
set("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "open NeoGit" })

-- Typst Preview
-- set("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview in browser" })

-- Idris2 lsp
-- local bufopts = { noremap = true }
-- local cmd = [[:lua require("idris2.code_action")]]
-- set("n", "<leader>iev", [[:lua require("idris2.repl").evaluate()<CR>]], d(bufopts, "evaluate"))
-- set("n", "<leader>ics", cmd .. ".case_split()<CR>",   d(bufopts, "case split"))
-- set("n", "<leader>imc", cmd .. ".make_case()<CR>",    d(bufopts, "make case"))
-- set("n", "<leader>iml", cmd .. ".make_lemma()<CR>",   d(bufopts, "make lemma"))
-- set("n", "<leader>iac", cmd .. ".add_clause()<CR>",   d(bufopts, "add clause"))
-- set("n", "<leader>ies", cmd .. ".expr_search()<CR>",  d(bufopts, "search expression"))
-- set("n", "<leader>igd", cmd .. ".generate_def()<CR>", d(bufopts, "generate definition"))
-- set("n", "<leader>irh", cmd .. ".refine_hole()<CR>",  d(bufopts, "refine hole"))
-- set("n", "<leader>iin", cmd .. ".intro()<CR>",        d(bufopts, "intro"))
