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

  # Copy .env files (gitignored) at any depth, preserving directory structure.
  local env_file
  fd -H -I -t f '^\.env$' --exclude node_modules --exclude vendor --exclude .git |
    while IFS= read -r env_file; do
      echo "Copying $env_file"
      mkdir -p "$worktree_path/${env_file:h}"
      cp "$env_file" "$worktree_path/$env_file"
    done

  echo "cd to $worktree_path"
  cd "$worktree_path"
}
