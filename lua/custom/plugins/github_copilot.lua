return {
  {
    'github/copilot.vim',
    config = function()
      -- Trigger the suggestion manually
      vim.g.copilot_enabled = false
      vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-suggest)', { desc = 'Trigger Copilot suggestion' })
    end,
  },
  -- Copilot chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    -- Some warning showing up saying the branch 'canary' (i guess the default one) is deprecated
    branch = 'main',
    opts = {},
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
      {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        opts = {},
      },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        window = { layout = 'float' },
        mappings = {
          reset = {
            normal = '<leader>cr',
          },
        },
        chat_autocomplete = true,
      }
      local chat = require 'CopilotChat'
      vim.keymap.set('n', '<leader>cc', chat.toggle, { desc = 'Toggle [C]opilot [C]hat window.' })
      vim.keymap.set('v', '<leader>cc', chat.toggle, { desc = 'Toggle [C]opilot [C]hat window.' })
      -- choose the chat model
      vim.keymap.set('n', '<leader>cm', chat.select_model, { desc = 'Choose [C]opilot [M]odel.' })
    end,
  },
}
