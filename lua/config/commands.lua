-- Toggle relative line numbers
vim.api.nvim_create_user_command('Rln', function() vim.wo.relativenumber = not vim.wo.relativenumber end, { desc = 'Toggle relative line numbers' })
