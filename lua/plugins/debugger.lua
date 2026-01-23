return {
  { -- Core DAP plugin with keybindings
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
      { '<leader>dn', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<leader>dO', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
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
    opts = {
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = 'disconnect',
          pause = 'pause',
          play = 'play',
          run_last = 'run_last',
          step_into = 'step_into',
          step_out = 'step_out',
          step_over = 'step_over',
          terminate = 'terminate',
        },
      },
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = '▶',
        current_frame = '▶',
        expanded = '▼',
      },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.50 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.45 },
            { id = 'console', size = 0.55 },
          },
          size = 10,
          position = 'bottom',
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 2,
        max_value_lines = 100,
      },
    },
  },
  { -- Virtual text for variables
    'theHamsta/nvim-dap-virtual-text',
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      filter_references_pattern = '<module>',
      virt_text_pos = 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = { require 'neotest-python' },
      }
    end,
    ft = { 'python' },
  },
}
