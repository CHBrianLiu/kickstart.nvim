return {
  -- Copilot provider (top-level for config)
  { 'zbirenbaum/copilot.lua', opts = {} },

  -- Avante.nvim main plugin
  -- {
  --   'yetone/avante.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'echasnovski/mini.icons',
  --     'zbirenbaum/copilot.lua',
  --     'folke/snacks.nvim',
  --     'ravitemer/mcphub.nvim',
  --   },
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     instructions_file = '.github/copilot-instructions.md',
  --     file_selector = {
  --       provider = 'telescope',
  --     },
  --     selector = {
  --       provider = 'telescope',
  --     },
  --     -- Use Copilot as the provider
  --     provider = 'opencode',
  --     providers = {
  --       copilot = {
  --         model = 'claude-haiku-4.5',
  --       },
  --     },
  --     edit = {
  --       start_insert = false,
  --     },
  --     -- system_prompt as function ensures LLM always has latest MCP server state
  --     -- This is evaluated for every message, even in existing chats
  --     system_prompt = function()
  --       local hub = require('mcphub').get_hub_instance()
  --       return hub and hub:get_active_servers_prompt() or ''
  --     end,
  --     -- Using function prevents requiring mcphub before it's loaded
  --     custom_tools = function()
  --       return {
  --         require('mcphub.extensions.avante').mcp_tool(),
  --       }
  --     end,
  --     -- Prefer neovim's tools
  --     -- https://ravitemer.github.io/mcphub.nvim/extensions/avante.html#tool-conflicts
  --     disabled_tools = {
  --       'list_files', -- Built-in file operations
  --       'search_files',
  --       'read_file',
  --       'create_file',
  --       'rename_file',
  --       'delete_file',
  --       'create_dir',
  --       'rename_dir',
  --       'delete_dir',
  --       'bash', -- Built-in terminal access
  --     },
  --   },
  -- },
  -- {
  --   'ravitemer/mcphub.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  --   opts = {
  --     extensions = {
  --       avante = {
  --         make_slash_commands = true, -- make /slash commands from MCP server prompts
  --       },
  --     },
  --   },
  -- },

  --   This is an alternative to Avante to interactive copilot
  --   'folke/sidekick.nvim',
  --   opts = {
  --     -- add any options here
  --     cli = {
  --       mux = {
  --         backend = 'tmux',
  --         enabled = true,
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       '<tab>',
  --       function()
  --         -- if there is a next edit, jump to it, otherwise apply it if any
  --         if not require('sidekick').nes_jump_or_apply() then
  --           return '<Tab>' -- fallback to normal tab
  --         end
  --       end,
  --       expr = true,
  --       desc = 'Goto/Apply Next Edit Suggestion',
  --     },
  --     {
  --       '<c-.>',
  --       function() require('sidekick.cli').toggle() end,
  --       desc = 'Sidekick Toggle',
  --       mode = { 'n', 't', 'i', 'x' },
  --     },
  --     {
  --       '<leader>aa',
  --       function() require('sidekick.cli').toggle() end,
  --       desc = 'Sidekick Toggle CLI',
  --     },
  --     {
  --       '<leader>as',
  --       function() require('sidekick.cli').select() end,
  --       -- Or to select only installed tools:
  --       -- require("sidekick.cli").select({ filter = { installed = true } })
  --       desc = 'Select CLI',
  --     },
  --     {
  --       '<leader>ad',
  --       function() require('sidekick.cli').close() end,
  --       desc = 'Detach a CLI Session',
  --     },
  --     {
  --       '<leader>at',
  --       function() require('sidekick.cli').send { msg = '{this}' } end,
  --       mode = { 'x', 'n' },
  --       desc = 'Send This',
  --     },
  --     {
  --       '<leader>af',
  --       function() require('sidekick.cli').send { msg = '{file}' } end,
  --       desc = 'Send File',
  --     },
  --     {
  --       '<leader>av',
  --       function() require('sidekick.cli').send { msg = '{selection}' } end,
  --       mode = { 'x' },
  --       desc = 'Send Visual Selection',
  --     },
  --     {
  --       '<leader>ap',
  --       function() require('sidekick.cli').prompt() end,
  --       mode = { 'n', 'x' },
  --       desc = 'Sidekick Select Prompt',
  --     },
  --   },
  -- },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   version = '^18.0.0',
  --   opts = {},
  --   keys = {
  --     {
  --       '<leader>a<space>',
  --       '<cmd>CodeCompanionActions<cr>',
  --       mode = { 'n', 'v' },
  --       silent = true,
  --     },
  --     {
  --       '<leader>aa',
  --       '<cmd>CodeCompanionChat Toggle<cr>',
  --       mode = { 'n', 'v' },
  --       noremap = true,
  --       silent = true,
  --     },
  --     {
  --       'ga',
  --       '<cmd>CodeCompanionChat Add<cr>',
  --       mode = { 'v' },
  --       noremap = true,
  --       silent = true,
  --     },
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  -- },
  {
    'azorng/goose.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },
    opts = {
      prefered_picker = 'telescope',
      default_global_keymaps = false,
      keymap = {
        global = {
          toggle_focus = '<leader>at', -- Toggle focus between goose and last window
          close = '<leader>gq', -- Close UI windows
          toggle_fullscreen = '<leader>gf', -- Toggle between normal and fullscreen mode
          select_session = '<leader>gs', -- Select and load a goose session
          goose_mode_chat = '<leader>gmc', -- Set goose mode to `chat`. (Tool calling disabled. No editor context besides selections)
          goose_mode_auto = '<leader>gma', -- Set goose mode to `auto`. (Default mode with full agent capabilities)
          configure_provider = '<leader>gp', -- Quick provider and model switch from predefined list
          open_config = '<leader>g.', -- Open goose config file
          inspect_session = '<leader>g?', -- Inspect current session as JSON
          diff_open = '<leader>gd', -- Opens a diff tab of a modified file since the last goose prompt
          diff_next = '<leader>g]', -- Navigate to next file diff
          diff_prev = '<leader>g[', -- Navigate to previous file diff
          diff_close = '<leader>gc', -- Close diff view tab and return to normal editing
          diff_revert_all = '<leader>gra', -- Revert all file changes since the last goose prompt
          diff_revert_this = '<leader>grt', -- Revert current file changes since the last goose prompt
        },
        window = {
          submit_insert = '<C-r>',
        },
      },
      ui = {
        window_type = 'split',
      },
      system_instructions = 'Refer to .github/copilot-instructions.md.',
    },
    keys = {
      { '<leader>aa', '<cmd>Goose<cr>' },
      { '<leader>an', '<cmd>GooseOpenInputNewSession<cr>' },
      { '<leader>a?', '<cmd>GooseConfigureProvider<cr>' },
      { '<leader>ap', '<cmd>GooseOpenConfig<cr>' },
      { '<leader>as', '<cmd>GooseSelectSession<cr>' },
      { '<leader>amc', '<cmd>GooseModeChat<cr>' },
      { '<leader>ama', '<cmd>GooseModeAuto<cr>' },
    },
  },
}
