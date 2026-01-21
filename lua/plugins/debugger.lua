-- keys = {
--   {
--     '<leader>dO',
--     function() require('dap').continue() end,
--     desc = 'c[O]ntinue',
--   },
--   {
--     '<leader>dn',
--     function() require('dap').step_into() end,
--     desc = 'Step I[n]to',
--   },
--   {
--     '<leader>dN',
--     function() require('dap').step_out() end,
--     desc = 'Step out',
--   },
--   {
--     '<leader>do',
--     function() require('dap').step_over() end,
--     desc = 'step [o]ver',
--   },
--   {
--     '<leader>dS',
--     function() require('dap').stop() end,
--     desc = 'Stop',
--   },
--   {
--     '<leader>b',
--     function() require('dap').toggle_breakpoint() end,
--     desc = 'Toggle [b]reakpoint',
--   },
--   {
--     '<leader>B',
--     function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
--     desc = 'Debug: Set Breakpoint with Condition',
--   },
--   {
--     '<leader>dr',
--     function() require('dap').repl.open() end,
--     desc = 'Debug: Open REPL',
--   },
-- },
return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    -- opts can't be used here since the 'require' statement are evaluated
    -- before Lazy parses the config.
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python',
        },
      }

      -- User commands
      vim.api.nvim_create_user_command('Trun', function(opts)
        local neotest = require 'neotest'
        if opts.nargs == 0 then
          neotest.run.run()
          return
        else
          -- Unfinished
          neotest.run.run(vim.fn.getcwd() .. opts.fargs[1])
          neotest.summary.open()
        end
      end, { nargs = '?' })
      vim.api.nvim_create_user_command('Trunfile', function()
        require('neotest').run.run(vim.fn.expand '%')
        require('neotest').summary.open()
      end, {})
      vim.api.nvim_create_user_command('Tout', function() require('neotest').output.open { enter = true } end, {})
      vim.api.nvim_create_user_command('Tsum', require('neotest').summary.toggle, {})
      -- Keymap/command ideas
      -- - Run all test cases
      -- - Run failed test cases
      -- - Project specific path (CC integration test)
    end,
    keys = {
      -- { '<leader>tt' },
    },
    ft = {
      'python',
      'go',
    },
  },
}
