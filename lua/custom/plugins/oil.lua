-- ~/.config/nvim/lua/custom/plugins/oil.lua
-- File explorer that edits the filesystem like a normal buffer
return {
  'stevearc/oil.nvim',
  opts = { view_options = { show_hidden = true } }, -- Keep default configuration for now
  -- Optional dependencies
  dependencies = { { 'nvim-tree/nvim-web-devicons', lazy = true } },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)

    -- Keymaps for Oil
    -- See :help oil-usage for more mappings
    -- Open parent directory of current file
    vim.keymap.set('n', '<leader>f;', function()
      oil.open_float(vim.fn.expand '%:p:h')
    end, { desc = 'Open parent directory of current file' })
    -- Open current working directory
    vim.keymap.set('n', '<leader>ft', function()
      oil.open_float(vim.fn.getcwd())
    end, { desc = 'Open current working directory (explicit)' })
  end,
}
