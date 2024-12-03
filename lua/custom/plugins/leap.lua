return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'zj', '<Plug>(leap-forward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'zk', '<Plug>(leap-backward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'zs', '<Plug>(leap-from-window)')
  end,
}
