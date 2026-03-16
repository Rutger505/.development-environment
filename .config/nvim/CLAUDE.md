# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It is managed as part of a larger dotfiles repo (`dev-env`) using GNU Stow, which symlinks this directory to `~/.config/nvim`.

After making changes, run `dev-env-stow` from the parent `dev-env` repo root to apply symlinks.

## Structure

- `init.lua` — single main config file; all core settings, keymaps, and plugin specs live here
- `lua/kickstart/plugins/` — optional kickstart example plugins (only `neo-tree.lua` is currently enabled)
- `lua/custom/plugins/` — user-defined plugins; add new plugin files here or add to `init.lua`

## Plugin Management

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), bootstrapped automatically on first launch.

- `:Lazy` — view plugin status / install / update
- `:Mason` — manage LSP servers, formatters, linters
- `:checkhealth` — diagnose configuration issues
- `:TSUpdate` — update treesitter parsers

## Key Conventions

- Leader key: `<Space>`
- LSP servers and formatters are declared in the `servers` table inside the `nvim-lspconfig` config block in `init.lua` — Mason auto-installs them
- Format on save is enabled via `conform.nvim` (disabled for C/C++)
- `<leader>f` — manual format buffer
- `<leader>e` — toggle Neo-tree file explorer
- `<leader>s*` — Telescope search commands
- `gr*` — LSP actions (rename, references, definition, etc.)

## Active Plugins

| Plugin | Purpose |
|--------|---------|
| `guess-indent.nvim` | Auto-detects indentation style per buffer |
| `gitsigns.nvim` | Git change indicators in the sign column |
| `which-key.nvim` | Shows available keybindings as you type |
| `telescope.nvim` | Fuzzy finder for files, LSP, grep, etc. |
| `mason.nvim` | LSP/formatter/linter installer UI |
| `mason-lspconfig.nvim` | Bridges Mason and nvim-lspconfig |
| `mason-tool-installer.nvim` | Auto-installs tools declared in config |
| `fidget.nvim` | LSP progress notifications |
| `nvim-lspconfig` | LSP client configuration |
| `conform.nvim` | Autoformatting (format on save) |
| `blink.cmp` | Autocompletion engine |
| `LuaSnip` | Snippet engine (used by blink.cmp) |
| `tokyonight.nvim` | Colorscheme (tokyonight-night variant) |
| `todo-comments.nvim` | Highlights TODO/FIXME/NOTE in comments |
| `mini.nvim` | Collection: `mini.ai` (text objects), `mini.surround`, `mini.statusline` |
| `nvim-treesitter` | Syntax highlighting and indentation |
| `neo-tree.nvim` | File explorer sidebar |

## Adding Plugins

To add a new plugin, either:
1. Add a plugin spec directly in `init.lua` inside the `require('lazy').setup({...})` call, or
2. Create a new file in `lua/custom/plugins/` returning a lazy plugin spec, then uncomment `{ import = 'custom.plugins' }` in `init.lua`

## LSP / Formatter Setup

Add language servers to the `servers` table in `init.lua` (inside the `nvim-lspconfig` config block). Mason will auto-install them. For formatters, add entries to `formatters_by_ft` in the `conform.nvim` opts.
