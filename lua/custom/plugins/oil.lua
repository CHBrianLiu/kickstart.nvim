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
    opts = {}, -- use defaults; customize later if needed
  },
}
