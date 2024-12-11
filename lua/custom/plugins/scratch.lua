return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy',
  config = function()
    require('scratch').setup()
    vim.keymap.set('n', '<leader>n', '<cmd>Scratch<cr>')
  end,
}
