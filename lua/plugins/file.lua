return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    { '<leader>f;', '<cmd>Oil --float<cr>', desc = 'Open Oil' },
    {
      '<leader>f:',
      function() require('oil').open_float(vim.fn.getcwd()) end,
      desc = 'Open Oil floating window at session directory',
    },
  },
}
