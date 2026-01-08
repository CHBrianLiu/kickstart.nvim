return {
  { 'tpope/vim-surround' },
  { 'nvim-mini/mini.pairs', version = false, opts = {} },
  {
    'nvim-mini/mini.sessions',
    version = false,
    opts = {
      -- Whether to read default session if Neovim opened without file arguments
      autoread = true,

      -- Whether to write currently read session before leaving it
      autowrite = true,
    },
  },
  -- Jump to anywhere
  {
    'https://codeberg.org/andyg/leap.nvim.git',
    keys = {
      { 's', '<Plug>(leap)', mode = { 'n', 'x', 'o' } },
      { 'S', '<Plug>(leap-from-window)', mode = { 'n' } },
    },
    config = function()
      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress (see
      -- `:h leap.opts.preview`).
      -- For example, skip preview if the first character of the match is
      -- whitespace or is in the middle of an alphabetic word:
      require('leap').opts.preview = function(ch0, ch1, ch2) return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a')) end
    end,
  },
  {
    'gbprod/yanky.nvim',
    opts = {
      preserve_cursor_position = {
        enabled = true,
      },
    },
    keys = {
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
    },
  },
}
