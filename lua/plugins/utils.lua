return {
  { 'nvim-mini/mini.surround', version = false, opts = {} },
  { 'nvim-mini/mini.pairs', version = false, opts = {} },
  { 'nvim-mini/mini.jump2d', version = false, opts = {} },
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
}
