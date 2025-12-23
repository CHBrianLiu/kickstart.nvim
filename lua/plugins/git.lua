return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_create_user_command('Gfa', 'G fetch --all', {})
      vim.api.nvim_create_user_command('Gpra', 'G pull --autostash --rebase', {})
      vim.api.nvim_create_user_command('Gc', 'G commit', {})
      vim.api.nvim_create_user_command('Gcb', 'G checkout -b <args>', { nargs = 1 })
      vim.api.nvim_create_user_command('Glol', 'G log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"', {})
      vim.api.nvim_create_user_command('Grb', 'G rebase', {})
      vim.api.nvim_create_user_command('Grba', 'G rebase --abort', {})
      vim.api.nvim_create_user_command('Grbc', 'G rebase --continue', {})
      vim.api.nvim_create_user_command('Grbi', 'G rebase --interactive', {})
      vim.api.nvim_create_user_command('Gtsc', 'G tag --sort=-creatordate', {})
    end,
    keys = {
      {
        '<leader>gB',
        '<cmd>G blame<CR>',
        desc = 'Toggle Git blame panel',
      },
    },
  },
  {
    'linrongbin16/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      {
        '<leader>gl',
        function()
          require('gitlinker').get_buf_range_url('n', {
            action = require('gitlinker.actions').copy_to_clipboard,
          })
        end,
        desc = 'Copy remote [G]it [L]ink (current line/range)',
      },
      {
        '<leader>gl',
        function()
          require('gitlinker').get_buf_range_url('v', {
            action = require('gitlinker.actions').copy_to_clipboard,
          })
        end,
        mode = 'v',
        desc = 'Copy remote [G]it [L]ink for selection',
      },
    },
  },

  {
    'isak102/telescope-git-file-history.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'tpope/vim-fugitive',
    },
  },
}
