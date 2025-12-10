return {
  -- Copilot provider (top-level for config)
  { 'zbirenbaum/copilot.lua', opts = {} },

  -- Avante.nvim main plugin
  {
    'yetone/avante.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.icons',
      'zbirenbaum/copilot.lua',
      'folke/snacks.nvim',
      'ravitemer/mcphub.nvim',
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = '.github/copilot-instructions.md',
      file_selector = {
        provider = 'telescope',
      },
      selector = {
        provider = 'telescope',
      },
      -- Use Copilot as the provider
      provider = 'copilot',
      providers = {
        copilot = {
          model = 'gpt-5-mini',
        },
      },
      edit = {
        start_insert = false,
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ''
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      -- Prefer neovim's tools
      -- https://ravitemer.github.io/mcphub.nvim/extensions/avante.html#tool-conflicts
      disabled_tools = {
        'list_files', -- Built-in file operations
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash', -- Built-in terminal access
      },
    },
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
    opts = {
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
    },
  },
}
