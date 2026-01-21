return {
  -- Copilot provider
  { 'zbirenbaum/copilot.lua', opts = {} },

  -- OpenCode AI assistant integration
  {
    'sudo-tee/opencode.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      'saghen/blink.cmp',
      'folke/snacks.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      preferred_picker = 'telescope',
      default_global_keymaps = false, -- Disable defaults to use custom <leader>a

      -- We use opts.keymap instead of lazy.nvim's 'keys' because opencode.nvim
      -- manages context-aware keymaps (e.g., specific keys for the input window
      -- vs. global editor keys) that are difficult to replicate with standard
      -- lazy loading triggers.
      keymap = {
        editor = {
          ['<leader>aa'] = { 'toggle', desc = 'Opencode: Toggle' },
          ['<leader>ai'] = { 'open_input', desc = 'Opencode: Open Input' },
          ['<leader>aI'] = { 'open_input_new_session', desc = 'Opencode: Open Input (New Session)' },
          ['<leader>ao'] = { 'open_output', desc = 'Opencode: Open Output' },
          ['<leader>at'] = { 'toggle_focus', desc = 'Opencode: Toggle Focus' },
          ['<leader>aT'] = { 'timeline', desc = 'Opencode: Timeline' },
          ['<leader>aq'] = { 'close', desc = 'Opencode: Close' },
          ['<leader>as'] = { 'select_session', desc = 'Opencode: Select Session' },
          ['<leader>aR'] = { 'rename_session', desc = 'Opencode: Rename Session' },
          ['<leader>ap'] = { 'configure_provider', desc = 'Opencode: Configure Provider' },
          ['<leader>az'] = { 'toggle_zoom', desc = 'Opencode: Toggle Zoom' },
          ['<leader>av'] = { 'paste_image', desc = 'Opencode: Paste Image' },
          ['<leader>ad'] = { 'diff_open', desc = 'Opencode: Diff Open' },
          ['<leader>a]'] = { 'diff_next', desc = 'Opencode: Diff Next' },
          ['<leader>a['] = { 'diff_prev', desc = 'Opencode: Diff Prev' },
          ['<leader>ac'] = { 'diff_close', desc = 'Opencode: Diff Close' },
          ['<leader>ax'] = { 'swap_position', desc = 'Opencode: Swap Position' },
          ['<leader>a/'] = { 'quick_chat', mode = { 'n', 'x' }, desc = 'Opencode: Quick Chat' },
        },
        input_window = {
          -- Only submit on <CR> when it's in normal mode.
          ['<cr>'] = { 'submit_input_prompt', mode = { 'n' } },
          -- Switch modes like in CLI
          ['<tab>'] = { 'switch_mode', mode = 'n' },
          -- New session
          ['<leader>n'] = { 'open_input_new_session', mode = 'n' },
        },
      },
      -- I want to control the context explicitly.
      context = {
        enabled = false,
      },
    },
  },
}
