local vim = vim
local set = vim.keymap.set

---@param opts table
local function nset(opts) end

-- --- add desc to opts for set
-- ---@param opts vim.keymap.set.Opts
-- ---@param desc string
-- ---@return vim.keymap.set.Opts
-- local d = function(opts, desc)
--     opts.desc = desc
--     return opts
-- end

-- convenient
set("n", "<leader>qw", "<cmd>wq<CR>", { desc = "save and quit" })
set("n", "<Esc>", "<cmd>nohl<CR>", { silent = true })

set("n", "<C-s>", "<cmd>write<CR>", { desc = "save" })

set({ "i", "v" }, "kj", "<Esc>", { desc = "exit to normal" })

set("n", "<leader>cd", "<cmd>Cd<CR>", { desc = "cd to this file dir" })

set("n", "<leader>cd", "<cmd>Cd<CR>", { desc = "cd to this file dir" })

-- using makefile
set("n", "<leader>mr", "<cmd>term make run<CR>", { desc = "(m)ake (r)un" })
set("n", "<leader>mb", "<cmd>term make build<CR>", { desc = "(m)ake (b)uild" })
set(
    "n",
    "<leader>mqb",
    "<cmd>term make build<CR>a<CR>",
    { desc = "quick build" }
)

--- fixed shift j
set("n", "J", "mzJ`z")

--- non save delete
set({ "n", "v" }, "<leader>d", [["_d]])

--- using fixlist
set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "(r)eplace (w)ord" }
)

--- open MiniFiles
set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open parent dir" })

set(
    "n",
    "<leader>utr",
    "<cmd>TransparentToggle<CR>",
    { desc = "Toggle transparent background" }
)

-- Terminal
set("t", "<C-q>", "<C-\\><C-n>", { nowait = true })
set(
    "n",
    "<leader>ot",
    "<cmd>set nonumber norelativenumber | term<CR>a",
    { desc = "(o)pen (t)erminal" }
)
set(
    "n",
    "<leader>vt",
    "<cmd>vs | set nonumber norelativenumber | term<CR>a",
    { desc = "(v)ertical pane (t)erminal" }
)
set(
    "n",
    "<leader>st",
    "<cmd>sp | set nonumber norelativenumber | term<CR>a",
    { desc = "(v)ertical pane (t)erminal" }
)

-- mini.pick
set("n", "<leader>pb", "<cmd>Pick buffers<CR>", { desc = "(p)ick (b)uffers" })
set("n", "<leader>pf", "<cmd>Pick files<CR>", { desc = "(p)ick (f)iles" })
set("n", "<leader>ph", "<cmd>Pick help<CR>", { desc = "(p)ick (h)elp" })
set("n", "<leader>:", "<cmd>Pick commands<CR>", { desc = "pick command" })
set("n", "<leader>po", "<cmd>Pick options<CR>", { desc = "(p)ick (o)ption" })

-- NeoGit
set("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "open NeoGit" })

-- LSP
set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "(c)ode (a)ction LSP" }
)
set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename using lsp" })
set(
    "n",
    "<leader>gd",
    vim.lsp.buf.definition,
    { desc = "go to definition LSP" }
)

-- --- Typst Preview
-- set("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview in browser" })

-- --- Idris2 lsp
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
