# Neovim Configuration Structure Design

This document outlines the proposed structure for a flexible and maintainable Neovim configuration, inspired by `kickstart.nvim` but adapted for modularity and personal workflow customization.

## Goals
- **Maintainability**: Separation of concerns to make debugging and updating easier.
- **Flexibility**: Easy to add/remove plugins or change settings without affecting the core.
- **Performance**: Lazy loading of plugins and deferring heavy operations.

## Directory Structure

```text
~/.config/nvim/
├── init.lua                # Entry point: Bootstraps lazy.nvim, loads core modules
├── lazy-lock.json          # Auto-generated plugin lockfile
├── lua/
│   ├── config/             # Core configuration (non-plugin specific)
│   │   ├── lazy.lua        # Lazy.nvim setup and configuration
│   │   ├── options.lua     # Vim options (vim.opt.*)
│   │   ├── keymaps.lua     # General keymaps (vim.keymap.set)
│   │   └── autocmds.lua    # General autocommands
│   │
│   ├── plugins/            # Plugin specifications (handled by lazy.nvim)
│   │   ├── core.lua        # Essential plugins (Telescope, Treesitter, etc.)
│   │   ├── lsp.lua         # LSP, Mason, CMP, Formatting
│   │   ├── ui.lua          # Colorschemes, Statusline, UI enhancements
│   │   └── extras.lua      # Optional/Workflow specific plugins (Git, etc.)
│   │
│   └── user/               # User-specific overrides (ignored by git if desired)
│       └── init.lua        # Optional user config entry point
│
└── after/
    └── plugin/             # Scripts to run after plugins are loaded (if needed)
```

## Module Breakdown

### 1. Entry Point (`init.lua`)
- **Responsibility**:
  - Set the `<Space>` leader key immediately.
  - Load `config.options`.
  - Load `config.lazy` (which bootstraps the plugin manager).
  - Load `config.keymaps`.
  - Load `config.autocmds`.

### 2. Core Configuration (`lua/config/`)
- **`options.lua`**: Sets global options like line numbers, clipboard, indentation, etc.
- **`keymaps.lua`**: Defines keymaps that are not specific to a single plugin (e.g., window navigation, buffer management).
- **`autocmds.lua`**: Sets up `TextYankPost` highlight and other general automation.
- **`lazy.lua`**:
  - Checks for `lazy.nvim` installation and clones it if missing.
  - Configures `lazy.nvim` to load specs from `lua/plugins/`.

### 3. Plugin Specifications (`lua/plugins/`)
Each file here returns a table (or list of tables) following the `lazy.nvim` spec format.

- **`lsp.lua`**:
  - `neovim/nvim-lspconfig`: Main LSP client config.
  - `williamboman/mason.nvim`: Tool installer (LSP servers, linters).
  - `hrsh7th/nvim-cmp`: Autocompletion engine.
  - `stevearc/conform.nvim` (Optional): For formatting, or stick to LSP formatting.

- **`core.lua`**:
  - `nvim-telescope/telescope.nvim`: Fuzzy finder.
  - `nvim-treesitter/nvim-treesitter`: Syntax highlighting and parsing.
  - `folke/which-key.nvim`: Keybinding helper.

- **`ui.lua`**:
  - Colorscheme (e.g., `tokyonight.nvim`, `catppuccin`).
  - `nvim-lualine/lualine.nvim`: Status line.
  - `lewis6991/gitsigns.nvim`: Git integration in the gutter.

### 4. User Overrides (`lua/user/`)
- A dedicated place for machine-specific or temporary configurations that shouldn't necessarily be part of the main distribution.
- `init.lua` can optionally `pcall(require, 'user')` to load this safely.

## Implementation Plan

1.  **Phase 1: Skeleton**: Create the directory structure and a minimal `init.lua` that loads options and bootstraps `lazy.nvim`.
2.  **Phase 2: Core Plugins**: Add `telescope`, `treesitter`, and a colorscheme.
3.  **Phase 3: LSP & Completion**: Set up `mason`, `lspconfig`, and `cmp`.
4.  **Phase 4: Refinement**: Add keymaps, autocommands, and UI tweaks.