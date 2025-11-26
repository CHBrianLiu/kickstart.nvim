-- BLiu: custom
-- Local keymaps loaded via 'after/plugin' without modifying init.lua
-- Use H/L to jump to first/last non-blank character of the current line
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Go to line start' })
vim.keymap.set({ 'n', 'v' }, 'L', 'g_', { desc = 'Go to line end (non-blank)' })
-- BLiu: custom - personal keymaps loaded after core
-- Map 'jk' in insert mode to escape
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })

