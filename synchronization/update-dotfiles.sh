# Redirect all output (stdout and stderr) to a log file
exec >> ~/.development-environment/synchronization/update-dotfiles.log 2>&1

# Your script content below
echo "Script started at $(date)"

cd ~/.development-environment || exit 1

git pull

stow .

if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q '^\.tmux\.conf$'; then
  echo ".tmux.conf was modified! Running tpm update"
  ~/.local/share/tmux/plugins/tpm/bin/update_plugins all
fi
