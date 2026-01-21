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
