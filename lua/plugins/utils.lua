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
      { 'S', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' } },
    },
  },
}
