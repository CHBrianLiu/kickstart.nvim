return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_create_user_command('Gfa', 'G fetch --all', {})
      vim.api.nvim_create_user_command('Gpra', 'G pull --autostash --rebase', {})
      vim.api.nvim_create_user_command('Gc', 'G commit', {})
      vim.api.nvim_create_user_command('Gcb', 'G checkout -b <args>', { nargs = 1 })
      vim.api.nvim_create_user_command('Glol', 'G log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"', {})
      vim.api.nvim_create_user_command('Glod', 'G log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"', {})
      vim.api.nvim_create_user_command('Grb', 'G rebase <args>', { nargs = 1 })
      vim.api.nvim_create_user_command('Grba', 'G rebase --abort', {})
      vim.api.nvim_create_user_command('Grbc', 'G rebase --continue', {})
      vim.api.nvim_create_user_command('Grbi', 'G rebase --interactive <args>', { nargs = 1 })
      vim.api.nvim_create_user_command('Gtsc', 'G tag --sort=-creatordate', {})

      vim.api.nvim_create_user_command('Gpsup', function()
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then
          vim.cmd('G push --set-upstream origin ' .. branch)
        else
          vim.notify('Not in a git repository or no branch checked out', vim.log.levels.ERROR)
        end
      end, { desc = 'Push and set upstream to current branch' })

      vim.api.nvim_create_user_command('GpF', 'G push --force', { desc = 'Force push' })

      -- Fix line mismatch between blame window and source window when winbar is present
      -- We need this because the top line of each editor window is the breadcrumb.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fugitiveblame',
        callback = function() vim.wo.winbar = ' ' end,
      })

      vim.g.fugitive_summary_format = '(%ci) %s'
    end,
    keys = {
      {
        '<leader>gb',
        '<cmd>G blame<CR>',
        desc = 'Toggle Git blame panel',
      },
    },
    lazy = false,
  },
  {
    'linrongbin16/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>gl', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
      { '<leader>go', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
    },
  },
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    opts = {
      picker = 'telescope',
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      -- {
      --   '<leader>oi',
      --   '<CMD>Octo issue list<CR>',
      --   desc = 'List GitHub Issues',
      -- },
      -- {
      --   '<leader>op',
      --   '<CMD>Octo pr list<CR>',
      --   desc = 'List GitHub PullRequests',
      -- },
      -- {
      --   '<leader>od',
      --   '<CMD>Octo discussion list<CR>',
      --   desc = 'List GitHub Discussions',
      -- },
      -- {
      --   '<leader>on',
      --   '<CMD>Octo notification list<CR>',
      --   desc = 'List GitHub Notifications',
      -- },
      -- {
      --   '<leader>os',
      --   function() require('octo.utils').create_base_search_command { include_current_repo = true } end,
      --   desc = 'Search GitHub',
      -- },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
