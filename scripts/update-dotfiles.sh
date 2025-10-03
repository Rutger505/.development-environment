#!/bin/bash


ERROR_FILE=~/development-environment-sync-error
create_error_file() {
  touch "$ERROR_FILE"
}
delete_error_file() {
  if [ -f "$ERROR_FILE" ]; then
    rm "$ERROR_FILE"
  fi
}

echo "Script started at $(date)"

cd ~/.development-environment || exit 1

git fetch

# Compare current commit (HEAD = @) with the upstream branch of the current branch (@{u}).
# Exit status 1 if there are differences, 0 if not and 128 on error.
if git diff --quiet @ @{upstream} && [ ! -f "$ERROR_FILE" ]; then
  echo "Nothing changed"

  exit 0
fi

# If HEAD can't be fast-forwarded to upstream, abort
if ! git merge-base --is-ancestor @ @{upstream}; then
  echo "Local branch is ahead/diverged, aborting"

  create_error_file

  exit 1
fi

stow -D .
git pull --ff-only
stow --adopt . || create_error_file

hyprctl reload


if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q '^\.tmux\.conf$'; then
  echo ".tmux.conf was modified! Running tpm update"
  ~/.local/share/tmux/plugins/tpm/bin/update_plugins all
fi

delete_error_file

