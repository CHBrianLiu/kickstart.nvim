return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.jump2d').setup()
    require('mini.icons').setup()
  end,
}
