# Claude Code Instructions

Read the README.md for project overview and structure.

## Working with this repository

This repository uses GNU Stow to symlink config files to the home directory. After making changes:

1. **Stow files**: `dev-env-stow`
2. **Stow with adopt**: `dev-env-stow-adopt` - Use when stow conflicts with existing files. Adopts the existing file into the repo.
3. **Check for broken symlinks**: `dev-env-check-broken-stowlinks`
4. **Reload Hyprland** (when editing `.config/hypr/`): `dev-env-reload-hyprland`

## File locations

- Config files: `.config/`
- Scripts: `scripts/`
- Application packages: `applications/packages/`
- Post-install scripts: `applications/post-install/`
