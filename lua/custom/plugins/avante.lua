-- BLiu: custom - Avante AI assistant integration using GitHub Copilot provider
-- Plugin: https://github.com/yetone/avante.nvim
-- Minimal, provider-focused setup. No API keys are stored in the config; Copilot
-- authentication handled by the copilot.lua plugin (runs :Copilot auth on first use).
-- If you prefer another provider later (openai, claude, deepseek, etc.), adjust the
-- `provider` field and set required environment variables outside git.
return {
  'yetone/avante.nvim',
  event = 'VeryLazy', -- defer loading until after startup; change to keys/commands if desired
  dependencies = {
    'MunifTanjim/nui.nvim', -- UI components
    'nvim-tree/nvim-web-devicons', -- icons (optional but recommended)
    -- Markdown rendering for rich responses
    { 'MeanderingProgrammer/render-markdown.nvim', opts = {} },
    -- GitHub Copilot backend (used as provider); disable inline suggestions so it
    -- doesn't conflict with blink.cmp completion UI
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      build = ':Copilot auth', -- trigger auth helper after install
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
  },
  opts = {
    provider = {
      copilot = {
        -- Optional: choose a specific Copilot model. Leave nil for default.
        -- model = 'gpt-4o-mini',
      },
    },
    -- Add further avante settings here as you explore features.
  },
}
