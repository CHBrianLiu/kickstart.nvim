return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesitter-context').setup {
      -- avoid multiline comments flooding the window
      multiline_threshold = 1,
      -- separate the context area and the current editor scope
      separator = '-',
    }
    vim.keymap.set('n', '[C', function()
      require('treesitter-context').go_to_context(vim.v.count1)
    end, { silent = true })
  end,
}
