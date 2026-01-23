return {
  { -- Core DAP plugin with keybindings
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
      { '<leader>dn', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<leader>dN', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Conditional Breakpoint' },
      { '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug: Open REPL' },
      { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    },
  },
  { -- Mason integration for debug adapters
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = 'mason-org/mason.nvim',
    config = function()
      require('mason-nvim-dap').setup {
        ensure_installed = { 'python' },
      }
    end,
  },
  { -- DAP UI
    'rcarriga/nvim-dap-ui',
    opts = {},
  },
  { -- Virtual text for variables
    'theHamsta/nvim-dap-virtual-text',
    opts = {},
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      -- choose it over 'neotest-go' because the repo seems active.
      {
        'fredrikaverpil/neotest-golang',
        version = '*',
        build = function() vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() end,
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python',
          require 'neotest-golang' { runner = 'gotestsum' },
        },
      }
    end,
    keys = {
      {
        '<leader>tr',
        function() require('neotest').run.run() end,
        desc = 'Run the nearest test.',
      },
      {
        '<leader>tf',
        function() require('neotest').run.run(vim.fn.expand '%') end,
        desc = 'Run tests in the file.',
      },
      {
        '<leader>td',
        function() require('neotest').run.run { suite = false, strategy = 'dap' } end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>to',
        function() require('neotest').output.open { enter = true } end,
        desc = 'Open output window',
      },
      {
        '<leader>ts',
        function() require('neotest').summary.toggle() end,
        desc = 'Open a dedicate output window',
      },
      {
        '<leader>tO',
        function() require('neotest').output_panel.toggle() end,
        desc = 'Open a dedicate output window',
      },
    },
  },
}
