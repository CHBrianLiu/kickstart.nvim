return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'
    telescope.load_extension 'file_browser'
    vim.keymap.set('n', '<space>ft', ':Telescope file_browser<CR>', { desc = '[F]ile [T]tee' })
    vim.keymap.set('n', '<space>f;', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
  end,
}
