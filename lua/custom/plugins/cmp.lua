-- 'blink.cmp' is also declared in init.lua in the root folder, this
-- file adds keymaps to it.
return {
  'saghen/blink.cmp',
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- not able to figure out ',.' for the keybinding
      ['<C-,>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
  },
}
