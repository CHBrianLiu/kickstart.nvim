return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
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
      ['<leader>fp'] = {
        callback = function()
          local oil = require 'oil'
          local entry = oil.get_cursor_entry()
          if entry then
            local dir = oil.get_current_dir()
            local path = dir .. entry.name
            local rel_path = vim.fn.fnamemodify(path, ':.')
            vim.fn.setreg('+', rel_path)
            vim.notify('Copied relative path: ' .. rel_path)
          end
        end,
        mode = 'n',
        desc = 'Copy relative path',
      },
      ['<leader>fP'] = {
        callback = function()
          local oil = require 'oil'
          local entry = oil.get_cursor_entry()
          if entry then
            local dir = oil.get_current_dir()
            local path = dir .. entry.name
            vim.fn.setreg('+', path)
            vim.notify('Copied absolute path: ' .. path)
          end
        end,
        mode = 'n',
        desc = 'Copy absolute path',
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
