-- init.lua
--
-- Entry point for the Neovim configuration

-- Load core configuration
-- Note: The leader key is set in config.keymaps, which must be loaded
-- before config.lazy to ensure plugins use the correct leader.
require 'config.options'
require 'config.keymaps'
require 'config.commands'
require 'config.autocmds'

-- Bootstrap lazy.nvim and load plugins
require 'config.lazy'

-- Load snippets
require 'config.snippets'
require 'config.dap'

-- Load user-specific configuration if it exists
-- This allows you to have a local configuration that is not committed to git
pcall(require, 'user')
