# Create a git worktree on a new branch under ../<repo>-worktrees/<branch>,
# copy common (gitignored) deps into it, and cd there.
worktree-create() {
  emulate -L zsh
  setopt local_options err_return

  local branch="${1:?Usage: worktree-create <branch>}"
  local repo worktree_path dep
  repo="$(basename "$PWD")"
  worktree_path="../${repo}-worktrees/${branch}"

  git worktree add -b "$branch" "$worktree_path"

  for dep in vendor node_modules .tsbuildinfo .eslintcache; do
    if [ -e "$dep" ]; then
      echo "Copying $dep"
      cp -r "$dep" "$worktree_path/$dep"
    fi
  done

  if [ -f .claude/settings.local.json ]; then
    echo "Copying .claude/settings.local.json"
    mkdir -p "$worktree_path/.claude"
    cp .claude/settings.local.json "$worktree_path/.claude/settings.local.json"
  fi

  echo "cd to $worktree_path"
  cd "$worktree_path"
}
