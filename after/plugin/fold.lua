-- [[ Configure Treesitter-based code folding ]]
-- See `:help foldmethod` and `:help fold-expr` for more info.
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- Keep buffers expanded by default
vim.wo.foldenable = false
