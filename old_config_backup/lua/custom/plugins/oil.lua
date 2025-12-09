-- BLiu: custom
-- stevearc/oil.nvim
-- A simple, floating buffer-based file explorer that edits your filesystem like a normal buffer.
-- Key ideas:
--   - Opens directories as editable buffers; write to save changes (create/rename/delete).
--   - Lightweight alternative to tree UIs; integrates with Telescope and Neovim.
--   - Can replace netrw for directory editing.
-- Docs: https://github.com/stevearc/oil.nvim
return {
  {
    'stevearc/oil.nvim',
    -- BLiu: custom - keep config lightweight; we only add a keymap for now.
    opts = {}, -- defaults are fine; can extend later
    keys = {
      {
        '<leader>f;',
        function()
          -- Open Oil rooted at the current buffer's directory (or CWD if unnamed)
          local ok, oil = pcall(require, 'oil')
          if not ok then
            vim.notify('[oil] plugin not loaded', vim.log.levels.WARN)
            return
          end
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = (bufname ~= '' and vim.fn.fnamemodify(bufname, ':p:h')) or vim.loop.cwd()
          -- Use Oil API for better UX; fallback to command if API missing
          if oil.open then
            oil.open(path)
          else
            vim.cmd('Oil ' .. vim.fn.fnameescape(path))
          end
        end,
        desc = 'Oil: open directory of current file',
      },
    },
  },
}
