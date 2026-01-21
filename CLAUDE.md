# Claude Code Instructions

Read the README.md for project overview and structure.

## Working with this repository

This repository uses GNU Stow to symlink config files to the home directory. After making changes:

1. **Stow files** when adding/modifying configs:
   ```bash
   cd ~/.local/share/dev-env && stow --target="$HOME" .
   ```

2. **Check for broken symlinks** after changes:
   ```bash
   fd --type l . ~ 2>/dev/null | while read link; do [ ! -e "$link" ] && echo "$link"; done
   ```

3. **Reload Hyprland** when editing files in `.config/hypr/`:
   ```bash
   hyprctl reload
   ```
   Note: Hyprland auto-reloads on save, but manual reload ensures changes are applied.

## File locations

- Config files: `.config/`
- Scripts: `scripts/`
- Application packages: `applications/packages/`
- Post-install scripts: `applications/post-install/`
