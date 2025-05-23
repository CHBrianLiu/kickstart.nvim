return {
  -- It causes UI freeze
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   dependencies = {
  --     'mfussenegger/nvim-dap',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {},
  -- },
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
      -- Telescope integration
      {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = {
          'nvim-telescope/telescope.nvim',
        },
        config = function()
          require('telescope').load_extension 'dap'
        end,
      },
    },
    keys = function(_, keys)
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dappy = require 'dap-python'
      return {
        -- Basic debugging keymaps, feel free to change to your liking!
        { '<leader>dD', dapui.toggle, desc = 'Toggle Debug UI' },
        { '<leader>ds', dap.continue, desc = 'Debug: Start/Continue' },
        { '<leader>dn', dap.step_into, desc = 'Debug: Step Into' },
        { '<leader>do', dap.step_over, desc = 'Debug: Step Over' },
        { '<leader>dN', dap.step_out, desc = 'Debug: Step Out' },
        { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dS', dap.close, desc = 'Debug: Close ([S]top) session' },
        { '<leader>dr', dap.restart, desc = 'Debug: [R]estart session' },
        { '<leader>dh', dap.run_to_cursor, desc = 'Debug: run to cursor ([H]ere)' },
        {
          '<leader>dB',
          function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
          end,
          desc = 'Debug: Set Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<leader>dl', dapui.toggle, desc = 'Debug: See last session result ([L]og).' },
        -- Python
        { '<leader>dpm', dappy.test_method, desc = 'Debug: Run python test method' },
        { '<leader>dpc', dappy.test_class, desc = 'Debug: Run python test class' },
        unpack(keys),
      }
    end,
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'python',
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Change breakpoint icons
      vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      local breakpoint_icons = vim.g.have_nerd_font
          and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }
      require('dap-python').setup 'python3'

      -- Press K to show hover
      -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#map-k-to-hover-while-session-is-active
      -- local api = vim.api
      -- local keymap_restore = {}
      -- dap.listeners.after['event_initialized']['me'] = function()
      --   for _, buf in pairs(api.nvim_list_bufs()) do
      --     local keymaps = api.nvim_buf_get_keymap(buf, 'n')
      --     for _, keymap in pairs(keymaps) do
      --       if keymap.lhs == 'K' then
      --         table.insert(keymap_restore, keymap)
      --         api.nvim_buf_del_keymap(buf, 'n', 'K')
      --       end
      --     end
      --   end
      --   api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
      -- end
      -- dap.listeners.after['event_terminated']['me'] = function()
      --   for _, keymap in pairs(keymap_restore) do
      --     api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
      --   end
      --   keymap_restore = {}
      -- end
    end,
  },
}
