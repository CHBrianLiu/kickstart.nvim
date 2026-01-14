return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['<leader>/'] = {
        callback = function()
          local oil = require 'oil'
          local telescope = require 'telescope.builtin'
          local current_dir = oil.get_current_dir()
          oil.close()
          telescope.live_grep { cwd = current_dir }
        end,
        mode = 'n',
        desc = 'Live grep from Oil dir',
      },
      ['<leader>gh'] = {
        callback = function()
          local oil = require 'oil'
          local current_dir = oil.get_current_dir()
          oil.close()
          vim.cmd('Gclog! -- ' .. current_dir)
        end,
        mode = 'n',
        desc = 'Git log (Gclog) of dir',
      },
    },
  },
  -- Optional dependencies
  dependencies = {
    { 'nvim-mini/mini.icons', opts = {} },
    'nvim-telescope/telescope.nvim',
  },
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
