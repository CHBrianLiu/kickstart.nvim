-- ============================================================================
-- Scratch Pad Commands
-- ============================================================================
-- These commands provide a persistent scratch pad workflow:
--   :Scratch [filetype]  – create a new timestamped file and open it in a tab
--   :ScratchList         – browse all previous scratch files with Telescope
-- ============================================================================

--- Directory where all scratch files are stored.
local SCRATCH_DIR = vim.fn.expand '~/.local/state/nvim/scratch'

-- `:Scratch [filetype]`
--
-- Creates a new scratch file in SCRATCH_DIR with a timestamp-based name, then
-- opens it in a new tab.  The file is written to disk immediately so it
-- survives a crash even if the user never explicitly saves.
--
-- Examples:
--   :Scratch          → ~/.local/state/nvim/scratch/2026-03-25_14-30-05.md
--   :Scratch json     → ~/.local/state/nvim/scratch/2026-03-25_14-30-05.json
--   :Scratch python   → ~/.local/state/nvim/scratch/2026-03-25_14-30-05.python
vim.api.nvim_create_user_command('Scratch', function(opts)
  -- Determine the file extension.
  -- Default to "md" when no argument is supplied.
  local ext = (opts.args ~= nil and opts.args ~= '') and opts.args or 'md'

  -- Build a human-readable timestamp string (YYYY-MM-DD_HH-MM-SS).
  -- os.date returns a formatted string when given a format starting with '*t'
  -- returns a table; using a plain format string gives us the text directly.
  local timestamp = os.date '%Y-%m-%d_%H-%M-%S'

  -- Assemble the full file path.
  local filepath = SCRATCH_DIR .. '/' .. timestamp .. '.' .. ext

  -- Ensure the scratch directory exists.
  -- vim.fn.mkdir with the "p" flag creates all intermediate directories and
  -- does NOT error if the directory already exists.
  vim.fn.mkdir(SCRATCH_DIR, 'p')

  -- Open the file in a new tab.  Using 'tabedit' causes Neovim to create a
  -- new tab page whose active buffer is the given path.
  vim.cmd('tabedit ' .. vim.fn.fnameescape(filepath))

  -- Write the (empty) buffer to disk immediately so the file physically
  -- exists. This is important so that :ScratchList can find it even if the
  -- user closes Neovim without saving.
  vim.cmd 'write'

  vim.notify('Scratch: ' .. filepath)
end, {
  -- Allow an optional single-word argument (the file extension).
  nargs = '?',
  desc = 'Create a new timestamped scratch file (optional filetype arg)',
})

-- `:ScratchList`
--
-- Opens Telescope's file browser scoped to SCRATCH_DIR so the user can
-- fuzzy-search, preview, and open any previous scratch file.  The selected
-- file is opened in a new tab (consistent with :Scratch behaviour).
vim.api.nvim_create_user_command('ScratchList', function()
  -- Guard: tell the user clearly if Telescope is not available instead of
  -- showing a cryptic Lua stack trace.
  local ok, telescope_builtin = pcall(require, 'telescope.builtin')
  if not ok then
    vim.notify('ScratchList: telescope.nvim is not installed', vim.log.levels.ERROR)
    return
  end

  -- Ensure the directory exists before passing it to Telescope; otherwise
  -- Telescope will error when it tries to scan a non-existent path.
  vim.fn.mkdir(SCRATCH_DIR, 'p')

  -- Use the built-in `find_files` picker with a restricted search path.
  -- `attach_mappings` lets us override the default open action so that
  -- selecting a file opens it in a new tab rather than the current window.
  telescope_builtin.find_files {
    -- Limit the picker to the scratch directory.
    cwd = SCRATCH_DIR,

    -- Show a friendly title in the Telescope prompt.
    prompt_title = 'Scratch Pads',

    -- Override the default <CR> action to open the selection in a new tab.
    attach_mappings = function(_, map)
      local actions = require 'telescope.actions'
      local state = require 'telescope.actions.state'

      -- Replace the default select_default action (open in current window)
      -- with one that opens in a new tab.
      map('i', '<CR>', function(prompt_bufnr)
        -- Get the currently highlighted entry from the picker.
        local entry = state.get_selected_entry()
        -- Close the Telescope popup first so the tab opens cleanly.
        actions.close(prompt_bufnr)
        if entry then
          -- entry.path is the absolute path when cwd is set.
          vim.cmd('tabedit ' .. vim.fn.fnameescape(entry.path))
        end
      end)

      -- Also remap normal-mode <CR> for users who leave insert mode in
      -- the Telescope prompt.
      map('n', '<CR>', function(prompt_bufnr)
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          vim.cmd('tabedit ' .. vim.fn.fnameescape(entry.path))
        end
      end)

      -- Returning true tells Telescope to keep all other default mappings.
      return true
    end,
  }
end, { desc = 'Browse previous scratch pads with Telescope' })

-- ============================================================================
-- Unescape Command
-- ============================================================================
-- `:Unescape`
--
-- Converts escape sequences that appear as *literal* two-character strings in
-- log output (e.g. a backslash followed by the letter n) into their real
-- single-character equivalents.  Useful when pasting JSON log lines into a
-- buffer and wanting to read them as formatted text.
--
-- Transformations applied in order:
--   1. Literal \n  → actual newline  (expands lines)
--   2. Literal \"  → "
--   3. Literal \\  → \
--
-- Modes:
--   Normal mode  – processes every line in the buffer
--   Visual mode  – processes only the visually selected lines
-- ============================================================================
vim.api.nvim_create_user_command('Unescape', function(opts)
  -- Determine which lines to operate on.
  -- When called from visual mode Neovim populates opts.line1 / opts.line2
  -- with the first and last line of the selection (1-indexed).
  -- In normal mode these default to the entire buffer (1 … last line).
  local first = opts.line1
  local last = opts.line2

  -- Retrieve the target lines from the buffer as a Lua table of strings.
  -- nvim_buf_get_lines uses 0-indexed, end-exclusive ranges, so we subtract
  -- 1 from first and keep last as-is.
  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)

  -- Process each line, applying the three substitutions in a defined order.
  -- Order matters:
  --   • \\n must be handled before \\ so we don't accidentally turn "\\n"
  --     into a newline instead of the literal string "\n".
  --   • \\\" must be handled before \\ for the same reason.
  --   • \\ is therefore processed last.
  local result = {}
  for _, line in ipairs(lines) do
    -- Step 1: Replace literal \n (two chars: backslash + n) with a real newline.
    -- In Lua patterns, '%' is the escape character; a plain string replacement
    -- is used here via gsub with no pattern metacharacters.
    -- We use the intermediate table approach because gsub on a line containing
    -- \n will expand a single line into multiple lines.  We split on the
    -- replacement newline afterwards.
    local expanded = line:gsub('\\n', '\n')

    -- Step 2: Replace literal \" with a plain double-quote character.
    expanded = expanded:gsub('\\"', '"')

    -- Step 3: Replace literal \\ with a single backslash.
    -- This must come last; otherwise earlier substitutions would wrongly
    -- consume the first backslash of a \\ pair.
    expanded = expanded:gsub('\\\\', '\\')

    -- A single original line may now contain embedded newlines (from step 1).
    -- Split on those newlines and push each sub-line into result individually
    -- so nvim_buf_set_lines receives a flat list of strings (no embedded \n).
    for sub_line in (expanded .. '\n'):gmatch '([^\n]*)\n' do
      table.insert(result, sub_line)
    end
  end

  -- Write the processed lines back to the buffer, replacing the original
  -- range.  nvim_buf_set_lines is 0-indexed, end-exclusive.
  vim.api.nvim_buf_set_lines(0, first - 1, last, false, result)
end, {
  -- `range` = true means the command accepts a line range and Neovim will
  -- automatically populate opts.line1/opts.line2.  When invoked from visual
  -- mode with :'<,'>Unescape the range is the selection; in normal mode
  -- without an explicit range the command defaults to the current line.
  -- We override that default below.
  range = '%', -- '%' makes the default range the whole buffer in normal mode
  desc = 'Unescape literal \\n, \\", \\\\ sequences (buffer or visual selection)',
})

-- ============================================================================
-- Miscellaneous Commands
-- ============================================================================

-- Toggle relative line numbers
vim.api.nvim_create_user_command('Rln', function() vim.wo.relativenumber = not vim.wo.relativenumber end, { desc = 'Toggle relative line numbers' })

-- Jira Command Usage:
-- Normal Mode: Place cursor on a ticket ID (e.g., "ENG-123") and run `:Jira`
vim.api.nvim_create_user_command('Jira', function(opts)
  -- Open Jira ticket
  local jira_base_url = 'https://netskope.atlassian.net/browse/'

  local ticket_id = nil

  -- Normal mode: find pattern at cursor
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexed column

  -- Pattern: [a-zA-Z]+-%d+ (e.g., ENG-123 or eng-123)
  local pattern = '%a+-%d+'
  local start_idx = 1

  while true do
    local s, e = string.find(line, pattern, start_idx)
    if not s then
      break
    end

    -- Check if cursor is within the match
    if (col + 1) >= s and (col + 1) <= e then
      ticket_id = string.sub(line, s, e)
      break
    end

    start_idx = e + 1
  end

  if ticket_id and ticket_id ~= '' then
    local url = jira_base_url .. ticket_id
    print('Opening ' .. url)
    vim.ui.open(url)
  else
    print 'No Jira ticket ID found'
  end
end, { desc = 'Open Jira ticket from the cursor word' })

-- CI Watch integration
-- This requires the script to be in PATH.
-- Find the script in my note.
vim.api.nvim_create_user_command('CIWatch', function()
  vim.fn.jobstart({ 'ci_watch.sh' }, { detach = true })
  vim.notify 'Started watching CI pipelines...'
end, { desc = 'Watch GitHub CI status for current commit' })
