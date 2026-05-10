return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          buffers = {
            mappings = {
              n = {
                ['dd'] = require('telescope.actions').delete_buffer,
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'yank_history')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function() builtin.find_files { hidden = true, no_ignore = true } end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ff', function() builtin.find_files { hidden = false, no_ignore = false } end, { desc = '[S]earch [f]iles' })
      -- Visual mode: Use the selected text as the default search text for Telescope.
      -- Implementation details:
      -- There is no direct "get_selected_text" API in Neovim that handles all visual modes (v, V, <C-v>) easily.
      -- The most robust method is to:
      -- 1. Save the content of a specific register (v).
      -- 2. Yank the current selection into that register.
      -- 3. Read the register's content.
      -- 4. Restore the register's original content.
      vim.keymap.set('v', '<leader>ff', function()
        local saved_reg = vim.fn.getreg 'v'
        vim.cmd 'noau normal! "vy"'
        local text = vim.fn.getreg 'v'
        vim.fn.setreg('v', saved_reg)
        builtin.find_files { default_text = text }
      end, { desc = '[S]earch [f]iles with selection' })
      vim.keymap.set('n', '<leader>fF', function() builtin.find_files { hidden = true, no_ignore = true } end, { desc = '[S]earch all [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>sd', function() builtin.diagnostics { bufnr = 0 } end, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = '[S]earch workspace [D]iagnostics' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [b]uffers' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.resume, { desc = 'Resume Telescope search' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [c]ommands' })
      vim.keymap.set('n', '<leader>sC', builtin.command_history, { desc = '[S]earch [C]ommand history' })
      vim.keymap.set('n', '<leader>fR', builtin.jumplist, { desc = '[S]earch [r]ecent locations' })
      vim.keymap.set('n', "<leader>'", builtin.marks, { desc = '[S]earch marks, like the way you jump.' })
      vim.keymap.set('n', '<leader>sy', require('telescope').extensions.yank_history.yank_history, { desc = '[S]earch [y]ank history.' })
      -- git related
      vim.keymap.set('n', '<leader>gB', builtin.git_branches, { desc = 'Search [g]it [b]ranch' })
      -- git tags
      vim.keymap.set('n', '<leader>gt', function()
        -- Use custom picker to support sorting by creation date
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values

        pickers
          .new({}, {
            prompt_title = 'Git Tags',
            finder = finders.new_oneshot_job({ 'git', 'tag', '--sort=-creatordate' }, {}),
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.cmd('!git checkout ' .. selection[1])
                end
              end)

              local function delete_local_tag(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local tag = selection[1]
                  vim.cmd('!git tag -d ' .. tag)
                  print('Deleted local tag: ' .. tag)
                  local current_picker = action_state.get_current_picker(prompt_bufnr)
                  current_picker:refresh(finders.new_oneshot_job({ 'git', 'tag', '--sort=-creatordate' }, {}), { reset_prompt = true })
                end
              end

              local function delete_remote_tag(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local tag = selection[1]
                  vim.cmd('!git push origin --delete ' .. tag)
                  print('Deleted remote tag: ' .. tag)
                  local current_picker = action_state.get_current_picker(prompt_bufnr)
                  current_picker:refresh(finders.new_oneshot_job({ 'git', 'tag', '--sort=-creatordate' }, {}), { reset_prompt = true })
                end
              end

              local function yank_tag(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local tag = selection[1]
                  vim.fn.setreg('+', tag)
                  print('Yanked tag to clipboard: ' .. tag)
                end
              end

              map('n', 'dd', delete_local_tag, { desc = 'Delete local tag' })
              map('n', 'DD', delete_remote_tag, { desc = 'Delete remote tag' })
              map('n', 'yy', yank_tag, { desc = 'Yank tag to clipboard' })

              return true
            end,
          })
          :find()
      end, { desc = 'Search [g]it [t]ags' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    config = function(_, opts)
      local ts_path = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter'
      -- Prefer Neovim's bundled parsers when available. This avoids stale parser
      -- binaries under the plugin directory shadowing the built-in parsers.
      vim.opt.runtimepath:remove(ts_path)
      vim.opt.runtimepath:append(ts_path)

      require('nvim-treesitter').setup(opts)
    end,
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>?',
        function() require('which-key').show { global = false } end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
