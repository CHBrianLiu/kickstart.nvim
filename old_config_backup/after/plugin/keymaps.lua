-- BLiu: custom
-- Local keymaps loaded via 'after/plugin' without modifying init.lua
-- Use H/L to jump to first/last non-blank character of the current line
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '^', { desc = 'Go to line start' })
vim.keymap.set({ 'n', 'v', 'o' }, 'L', 'g_', { desc = 'Go to line end (non-blank)' })
-- BLiu: custom - personal keymaps loaded after core
-- Map 'jk' in insert mode to escape
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })

-- Logical (screen line) movement for wrapped lines:
-- Remap j/k to move by visual lines when no count is given, keep counts to move by real lines
-- This makes navigating long wrapped lines more natural.
vim.keymap.set({ 'n', 'x' }, 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Move cursor down by screen line' })
vim.keymap.set({ 'n', 'x' }, 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Move cursor up by screen line' })

-- Copy current file path to the system clipboard
vim.keymap.set('n', '<leader>fp', function()
  local path = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
  vim.fn.setreg('+', path)
  vim.notify('Copied relative path: ' .. path)
end, { desc = 'Copy relative file path' })

vim.keymap.set('n', '<leader>fP', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path' })
