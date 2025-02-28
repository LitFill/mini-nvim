local vim = vim

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    {"Folded", "NormalFloat", "FloatBorder"}
)

return {
    source = "xiyaowong/transparent.nvim",
    name   = "transparent",
}

