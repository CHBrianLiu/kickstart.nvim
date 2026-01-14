return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        styles = {
          comments = 'italic',
          keywords = 'bold',
        },
      },
      specs = {
        nordfox = {
          syntax = {
            -- The original color is a little bit hard to find.
            comment = 'white.dim',
          },
        },
      },
    },
    config = function(_, opts)
      require('nightfox').setup(opts)

      local colorscheme = 'nordfox'
      vim.cmd.colorscheme(colorscheme)

      -- use alternative color for the window separaters
      local palette = require('nightfox.palette').load(colorscheme)
      vim.cmd('highlight! WinSeparator guifg=' .. palette.blue.base .. ' guibg=NONE')
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'nordfox',
        component_separators = '|',
        section_separators = '',
      },
    },
    enabled = vim.g.have_nerd_font,
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[t]oggle git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
      end,
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      local dropbar_api = require 'dropbar.api'
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
  },
  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown', 'Avante', 'codecompanion', 'octo' },
    },
    ft = { 'markdown', 'Avante', 'codecompanion', 'octo' },
  },
  -- Marks visualization
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      virtcolumn = '80,120',
      -- char = '│',
    },
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      preview = {
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match '^fugitive://' then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end,
      },
    },
  },
  -- nvim-origami seems to be easier to set up than nvim-ufo
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {
      foldKeymaps = {
        -- I am more used to zo/zc/etc.
        setup = false,
      },
    }, -- needed even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
}
