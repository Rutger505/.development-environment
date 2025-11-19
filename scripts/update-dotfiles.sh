#!/usr/bin/env zsh

create_error_file() {
  touch "$DEVELOPMENT_ENVIRONMENT_ERROR_FILE"
}
delete_error_file() {
  if [ -f "$DEVELOPMENT_ENVIRONMENT_ERROR_FILE" ]; then
    rm "$DEVELOPMENT_ENVIRONMENT_ERROR_FILE"
  fi
}


echo "Script started at $(date)"

echo "Changing directory to ~/.development-environment"
cd ~/.development-environment || (create_error_file && exit 1)
echo "Changed directory to $(pwd)"

# Check for open changes (uncommitted changes)
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Repository has uncommitted changes, aborting"
  create_error_file
  exit 1
fi

git fetch

# Compare current commit (HEAD = @) with the upstream branch of the current branch (@{u}).
# Exit status 1 if there are differences, 0 if not and 128 on error.
if git diff --quiet @ @{upstream} && [ ! -f "$DEVELOPMENT_ENVIRONMENT_ERROR_FILE" ]; then
  echo "Nothing changed"

  exit 0
fi

# If HEAD can't be fast-forwarded to upstream, abort
if ! git merge-base --is-ancestor @ @{upstream}; then
  echo "Local branch is ahead/diverged, aborting"

  create_error_file

  exit 1
fi

git pull --ff-only || create_error_file
stow --adopt . || create_error_file

# Path to tmux config relative to repo root
TMUX_CONFIG=".config/tmux/tmux.conf"
# Path to tpm (tmux plugin manager)
TPM_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/plugins/tpm"

if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q "^$TMUX_CONFIG$"; then
  echo "$TMUX_CONFIG was modified! Running tpm update"
  "$TPM_PATH/bin/update_plugins" all
fi

delete_error_file

