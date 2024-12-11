return {
  'mbbill/undotree',
  config = function()
    -- I've never used the builtin U keymap (undo the whole line)
    vim.keymap.set('n', 'U', '<cmd>UndotreeToggle<CR>')
  end,
}
