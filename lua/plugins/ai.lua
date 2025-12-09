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
    },
  },
}
