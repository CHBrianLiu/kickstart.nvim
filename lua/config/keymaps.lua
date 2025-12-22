-- lua/config/keymaps.lua
--
-- This file is automatically loaded by init.lua

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Shorten function name
local keymap = vim.keymap.set

-- Clear search highlights on <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap('n', '[d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Go to next [D]iagnostic message' })
keymap('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit of reading.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
keymap('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
keymap('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines
keymap('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
keymap('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
keymap('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
keymap('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
keymap('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
keymap('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Better indenting
keymap('i', 'jk', '<Esc>', { desc = 'Easy escape from insert mode' })

keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Line Navigation (H/L)
-- H jumps to the first non-blank character of the line
-- L jumps to the end of the line
keymap({ 'n', 'v', 'o' }, 'H', '^', { desc = 'Move to start of line' })
keymap({ 'n', 'v', 'o' }, 'L', '$', { desc = 'Move to end of line' })

-- Move by display/logical (screen) lines when no count is given.
-- If a count is provided, preserve the original behavior of j/k.
-- This makes cursor movement follow wrapped lines visually.
keymap({ 'n', 'v', 'o' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move down by display line' })
keymap({ 'n', 'v', 'o' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move up by display line' })

-- Copy file path mappings
keymap('n', '<leader>fp', function()
  -- Copy relative path of current buffer to system clipboard
  vim.fn.setreg('+', vim.fn.expand '%')
  vim.notify 'Copied relative path to clipboard'
end, { desc = 'Copy relative path of current buffer' })

keymap('n', '<leader>fP', function()
  -- Copy absolute path of current buffer to system clipboard
  vim.fn.setreg('+', vim.fn.expand '%:p')
  vim.notify 'Copied absolute path to clipboard'
end, { desc = 'Copy absolute path of current buffer' })

-- Close current split
-- This mimic the command `:qa`
keymap('n', '<leader>qa', '<cmd>close<cr>', { desc = 'Close current split' })
