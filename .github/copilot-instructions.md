# Copilot Instructions

## Purpose
This repository is a modular Neovim configuration built from scratch. It prioritizes flexibility, maintainability, and separation of concerns. It is designed to be easily extensible and debuggable.

## Guiding Principles
- **Modularity**: Keep configuration logic separated by domain (core settings vs. plugins).
- **Declarative over Imperative**: Prefer data tables (`opts`) over function calls (`config`) where possible.
- **Maintainability**: Avoid deeply nested configurations. Flatten dependency structures.
- **Performance**: Leverage `lazy.nvim` for lazy loading.
- **Safety**: Never commit secrets.

## Configuration Structure

### Directory Layout
- **`init.lua`**: The entry point. It bootstraps `lazy.nvim` and loads modules from `lua/config/`.
- **`lua/config/`**: Core configuration that does not depend on plugins.
  - `options.lua`: Vim options (`vim.opt`).
  - `keymaps.lua`: General keymaps (`vim.keymap.set`).
  - `autocmds.lua`: General autocommands.
  - `lazy.lua`: `lazy.nvim` bootstrap and setup.
- **`lua/plugins/`**: Plugin specifications handled by `lazy.nvim`.
  - `core.lua`: Essential tools (Telescope, Treesitter, Which-Key).
  - `ui.lua`: Visuals (Colorscheme, Lualine, Gitsigns).
  - `lsp.lua`: LSP, Mason, CMP, Formatting.
- **`lua/user/`**: Directory for user-specific overrides.

## Plugin Management Rules (Strict)

### 1. Dependency Definition
- Use the `dependencies` key in `lazy.nvim` specs to ensure correct load order.
- **Rule**: If a dependency requires its own configuration (i.e., it needs `opts` or `config`), **define it as a top-level plugin** in the appropriate file.
- **Do NOT** configure a dependency inside the `dependencies` list of another plugin.

**Bad:**
```lua
{
  'PluginA',
  dependencies = {
    { 'DependencyB', opts = { ... } } -- Avoid this nesting
  }
}
```

**Good:**
```lua
{ 'DependencyB', opts = { ... } }, -- Defined as top-level
{
  'PluginA',
  dependencies = { 'DependencyB' } -- Referenced by name
}
```

### 2. Configuration Style (`opts` vs `config`)
- **`opts`**: Use this whenever possible. It allows `lazy.nvim` to handle the setup call declaratively.
- **`config`**: Use this only when:
  - The plugin does not follow the standard `setup(opts)` pattern.
  - You need to run imperative code (e.g., setting up specific keymaps or autocommands) after the plugin loads.
- **Rule**: Never nest a `config` function inside a `dependencies` list.

## Domain Specifics

### LSP & Completion
- **Manager**: `williamboman/mason.nvim` for installing tools.
- **Config**: `neovim/nvim-lspconfig` for server setup.
- **Completion**: `hrsh7th/nvim-cmp`.
- **Formatting**: `stevearc/conform.nvim` (preferred over LSP formatting for flexibility).

### Keymappings
- **Leader**: Space (`<Space>`).
- **General**: Place in `lua/config/keymaps.lua`.
- **Plugin-specific**: Define within the plugin spec using the `keys` table (lazy-loaded) or inside the `config` function.
- **Mnemonics**: Keep mappings intuitive (e.g., `<leader>f` for find/format, `<leader>g` for git).

## Authoring Style for Suggestions
- When suggesting code, adhere to the directory structure above.
- If adding a new plugin, suggest which file in `lua/plugins/` it belongs to.
- Always prefer `opts` tables over `config` functions for simplicity.
- Ensure all Lua code is idiomatic and follows the project's indentation (2 spaces).
