# Copilot Instructions: Neovim config based on kickstart.nvim

Purpose
- This repository uses kickstart.nvim as a minimal, documented baseline. It is not a full distribution. Keep the configuration small, readable, and extensible.

Guiding principles
- Prefer the smallest possible change over large refactors.
- Keep everything documented in-place; explain non-obvious choices.
- Favor built-in Neovim features first; add plugins only when needed.
- Make features opt-in or easily toggleable.
- Prefer sane defaults that work across platforms (macOS, Linux, Windows) and terminals.
- Use lazy.nvim for plugin management; track plugin versions via lazy-lock.json.
- Avoid committing secrets; do not hardcode credentials or tokens.

Configuration layout (kickstart-style)
- Single-file init.lua is acceptable and preferred for teaching; modular splits are fine but keep cohesion.
- Core sections (roughly in order):
  1. Bootstrapping lazy.nvim and setting leader keys.
  2. Basic settings (opt, globals) and UI tweaks.
  3. Keymaps for common actions, with consistent prefixes.
  4. Plugin specs via lazy.nvim.
  5. LSP: mason.nvim for tooling, nvim-lspconfig for servers, completion via nvim-cmp.
  6. Treesitter for syntax/structure, telescope for fuzzy finding.
  7. Additional utilities (gitsigns, which-key, etc.) only when justified.

Plugins and tooling expectations
- Plugin manager: lazy.nvim.
- LSP: mason.nvim + nvim-lspconfig. Default servers should be lightweight; language-specific servers only when the language is present.
- Completion: nvim-cmp with sensible sources (buffer, path, LSP, snippets if enabled).
- Treesitter: install maintained parsers; avoid excessive languages by default.
- Telescope: ripgrep and fd/find should be available; map common pickers.
- Git: gitsigns for inline hunks; do not require a heavy git UI by default.
- Formatting/Linting: prefer LSP-based formatting; add external formatters only when necessary.

Keymapping philosophy
- Use <leader> prefixes for discoverability; integrate with which-key when present.
- Keep mappings mnemonic (e.g., <leader>f for find, <leader>g for git, <leader>l for LSP).
- Do not shadow default motions unless strongly justified.
- Provide visual-mode and insert-mode variants only when they add value.

Performance and UX
- Defer heavy plugins; load on events or filetypes via lazy.nvim.
- Keep startup time low and avoid unnecessary autocommands.
- Make UI enhancements subtle; avoid noisy prompts or excessive virtual text.
- When adding a new keymap that does not rely on any plugin, put it in after/plugin/keymaps.lua to keep init.lua aligned with upstream kickstart.nvim as much as 
   possible.

Extensibility
- Encourage local overrides: user-specific settings should live outside VCS or behind conditionals.
- Make it easy to add a new plugin by placing a minimal spec and local config in init.lua (or a module), with comments.
- Prefer configuration over patching plugin source.

Cross-platform notes
- Rely on standard tools: git, ripgrep, fd/find, unzip, a C compiler (gcc/clang) when native compiles are needed.
- Detect optional dependencies gracefully; do not error if Nerd Font or clipboard tools are missing.
- Keep keymaps and shell integrations terminal-agnostic.

Testing and validation
- After plugin changes, run :Lazy and check for errors.
- Confirm LSP servers install via :Mason and :LspInfo.
- Verify Treesitter parsers via :TSUpdate and :TSInstallInfo.

Safety
- Never commit secrets or local machine paths.
- Avoid executing shell commands that could be destructive.


Keeping your fork up-to-date and avoiding merge conflicts
- Treat upstream (nvim-lua/kickstart.nvim) as read-only; put customizations in clearly separated blocks and modules.
- Prefer additive changes over edits to upstream lines. Insert new plugin specs, keymaps, or settings below existing sections instead of modifying them.
- When you must change upstream code, annotate with a comment tag like `-- BLiu: custom` and keep diffs minimal.
- Avoid reformatting upstream files; keep the original style to reduce noisy diffs.
- Track plugin versions in lazy-lock.json; avoid mass upgrades that diverge from upstream unless necessary.
- Consider a local overlay pattern:
  - keep init.lua close to upstream and load `lua/user/*.lua` for personal overrides.
  - guard user config with `pcall(require, 'user.something')` so missing modules don't break startup.
- Use git to sync safely:
  - add upstream: `git remote add upstream https://github.com/nvim-lua/kickstart.nvim`
  - fetch and rebase regularly: `git fetch upstream && git rebase upstream/master` (or upstream/main)
  - resolve conflicts by preferring upstream style; reapply your minimal changes after rebase.
- For larger deviations, maintain a branch per feature (e.g., `feat/tokyonight`) and rebase that branch on upstream/main; merge into your main after validation.
- Keep commit messages scoped and descriptive so conflicts are easier to resolve.

Authoring style for Copilot suggestions
- Prefer Lua that mirrors kickstart.nvim patterns.
- Write clear comments for each configuration block.
- Suggest minimal diffs; when proposing changes, show where to insert within init.lua and the exact lazy.nvim plugin spec snippet.
- When unsure, point to official plugin docs rather than inventing configs.

References
- Kickstart.nvim repo: https://github.com/nvim-lua/kickstart.nvim
- lazy.nvim docs: https://lazy.folke.io/
- nvim-lspconfig: https://github.com/neovim/nvim-lspconfig
- mason.nvim: https://github.com/williamboman/mason.nvim
- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
- nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
- telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
