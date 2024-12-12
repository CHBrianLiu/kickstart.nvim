return {
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = {},
    keys = {
      { '<leader>gll', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
      { '<leader>glL', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
      { '<leader>glb', '<cmd>GitLink current_branch<cr>', mode = { 'n', 'v' }, desc = 'Yank git branch link' },
      { '<leader>glB', '<cmd>GitLink current_branch!<cr>', mode = { 'n', 'v' }, desc = 'Open git branch link' },
    },
  },
}
