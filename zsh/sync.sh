#!/bin/bash

# Configuration
ZSHRC_PATH="$HOME/.zshrc"
# Your git repository path
REPO_PATH="$HOME/.development-environment"
# Your target branch
BRANCH="main"
# Sync interval in seconds
CHECK_INTERVAL=60

# Config folder
CONFIG_FOLDER="$REPO_PATH/zsh/config"

# Create log file
LOG_FILE="$REPO_PATH/zsh/sync.log"
touch "$LOG_FILE"

# Function to check if repository is clean
is_repo_clean() {
    cd "$REPO_PATH" || exit 1
    git diff --quiet HEAD
    return $?
}

# Function to sync changes
sync_changes() {
   local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
   echo "[$timestamp] Changes detected, syncing..."

   cd "$REPO_PATH" || {
       echo "[$timestamp] Failed to change directory"
       return 1
   }

   # Copy all config files
   if ! cp -r "$ZSHRC_PATH" "$CONFIG_FOLDER/"; then
       echo "[$timestamp] Failed to copy config files"
       return 1
   fi

   # Stage changes
   if ! git add "$CONFIG_FOLDER/"; then
       echo "[$timestamp] Failed to stage changes"
       return 1
   fi

   # Commit changes
   if ! git commit -m "Auto sync zsh config: $timestamp"; then
       echo "[$timestamp] No changes to commit"
       return 1
   fi

   # Pull latest changes first to avoid conflicts
   if ! git pull origin "$BRANCH"; then
       echo "[$timestamp] Failed to pull latest changes"
       return 1
   fi

   # Push changes
   if ! git push origin "$BRANCH"; then
       echo "[$timestamp] Failed to push changes"
       return 1
   fi

   echo "[$timestamp] Successfully pushed changes"
   return 0
}

# Main loop
echo "Starting .zshrc monitoring service..."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Monitoring started"

# Monitor for changes
while true; do
    if [ -f "$ZSHRC_PATH" ] && ! is_repo_clean; then
        sync_changes
    fi
    sleep "$CHECK_INTERVAL"
done