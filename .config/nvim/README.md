# Neovim Config

Personal Neovim configuration built on [Lazy.nvim](https://github.com/folke/lazy.nvim).

**Leader key:** `Space`

## Keybindings

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlights |

### Windows

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move focus between windows |
| `<C-Left/Right>` | Resize window width |
| `<C-Up/Down>` | Resize window height |

### Telescope (fuzzy finder)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Switch buffers |
| `<leader>fh` | Search help tags |
| `<leader>ft` | Search TODO comments |
| `<leader>f.` | Resume last search |

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Focus Neo-tree |

### LSP (active when a language server is attached)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>gd` | Go to declaration |
| `<leader>ci` | Go to implementation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>cd` | Show diagnostic float |
| `[d` / `]d` | Prev / next diagnostic |

### Code

| Key | Action |
|-----|--------|
| `<leader>cf` | Format buffer or selection |
| `<leader>cs` | Symbol browser |
| `<leader>cl` | LSP definitions panel |

### Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle project diagnostics |
| `<leader>xX` | Toggle buffer diagnostics |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |

### Plugin Manager

| Key | Action |
|-----|--------|
| `<leader>l` | Open Lazy |
| `<leader>m` | Open Mason |

## Language Servers

Language servers are managed by [Mason](https://github.com/williamboman/mason.nvim). `lua_ls` is pre-installed. To add more, either:

- Open `:Mason` and install them manually, or
- Add them to `ensure_installed` in `lua/plugins/lsp.lua`

Treesitter parsers are installed automatically (`auto_install = true`) when you open a file.

## TODO

- [ ] Add DAP (debugger) support — `nvim-dap` + `nvim-dap-ui`
