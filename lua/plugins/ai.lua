return {
  -- Copilot provider
  { 'zbirenbaum/copilot.lua', opts = {} },

  -- OpenCode AI assistant integration
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = {
      -- Core actions
      {
        '<leader>aa',
        function() require('opencode').ask('@this: ', { submit = true }) end,
        mode = { 'n', 'x' },
        desc = 'Ask OpenCode with context',
      },
      {
        '<leader>aA',
        function() require('opencode').ask '' end,
        mode = { 'n', 'x' },
        desc = 'Ask OpenCode',
      },
      {
        '<leader>as',
        function() require('opencode').select() end,
        mode = { 'n', 'x' },
        desc = 'Select OpenCode action',
      },
      {
        '<leader>at',
        function() require('opencode').toggle() end,
        mode = { 'n', 't' },
        desc = 'Toggle OpenCode',
      },

      -- Operator mode
      {
        '<leader>ao',
        function() return require('opencode').operator '@this ' end,
        mode = { 'n', 'x' },
        expr = true,
        desc = 'Add range to OpenCode',
      },
      {
        '<leader>aO',
        function() return require('opencode').operator '@this ' .. '_' end,
        mode = 'n',
        expr = true,
        desc = 'Add line to OpenCode',
      },

      -- Scroll OpenCode output
      {
        '<leader>au',
        function() require('opencode').command 'session.half.page.up' end,
        desc = 'OpenCode scroll up',
      },
      {
        '<leader>ad',
        function() require('opencode').command 'session.half.page.down' end,
        desc = 'OpenCode scroll down',
      },
    },
    config = function()
      -- Configuration
      vim.g.opencode_opts = {
        provider = {
          enabled = 'tmux',
          tmux = {
            options = '-h', -- Horizontal split
          },
        },
      }

      -- Required for auto-reload
      vim.o.autoread = true
    end,
  },
}
