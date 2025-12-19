return {
  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>gfa',
        '<cmd>G fetch --all<CR>',
        desc = 'Git fetch all',
      },
      {
        '<leader>gpra',
        '<cmd>G pull --autostash --rebase<CR>',
        desc = 'Git pull with autostash and rebase',
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
