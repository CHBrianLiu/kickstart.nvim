-- BLiu: custom - colorscheme plugin spec moved out of init.lua to minimize diffs
return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'material'
      vim.g.gruvbox_material_enable_italic = true
      vim.o.background = 'light'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
