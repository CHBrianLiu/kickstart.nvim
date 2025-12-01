return { -- Collection of various small independent plugins/modules
  { 'nvim-mini/mini.jump2d', version = '*' },
  { 'nvim-mini/mini.icons', version = '*' },
  {
    'nvim-mini/mini.sessions',
    version = '*',
    opts = {
      autoread = true,
    },
  },
} -- Enhanced to include mini.sessions for session management
