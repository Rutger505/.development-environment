#!/bin/bash

# Configuration
ZSHRC_PATH="$HOME/.zshrc"
# Sync interval in seconds
CHECK_INTERVAL=55

# Your git repository path
REPO_PATH="$HOME/.development-environment"
# Your target branch
BRANCH="main"
# Config folder
CONFIG_FOLDER="$REPO_PATH/zsh/config"

# Import log function to log messages with timestamps
source ../utils/log.sh


# Function to check if repository is clean
is_repo_clean() {
   log "Checking repository status..."

   # Check if we can access the repository
   if ! cd "$REPO_PATH"; then
       log "Failed to change directory to $REPO_PATH"
       return 1
   fi

   # Fetch latest changes from remote
   if ! git fetch origin "$BRANCH"; then
       log "Failed to fetch from remote"
       return 1
   fi

   # Check for remote changes
   if ! git diff --quiet HEAD "origin/$BRANCH"; then
       log "Remote has changes"
       return 1
   fi

   # Check for local changes
   if ! git diff --quiet HEAD; then
       log "Local has uncommitted changes"
       return 1
   fi

   # Check if files even exist
   if [ ! -f "$ZSHRC_PATH" ] || [ ! -f "$CONFIG_FOLDER/.zshrc" ]; then
       log "One of the config files is missing"
       return 1
   fi

   # Compare local .zshrc with the one in repo
   if ! diff "$ZSHRC_PATH" "$CONFIG_FOLDER/.zshrc" > /dev/null 2>&1; then
       log "Local config file has changes"
       return 1
   fi

   # All checks passed, repository is clean
   log "Repository is clean"
   return 0
}

# Function to sync changes
sync_changes() {
   log "Changes detected, syncing..."

   cd "$REPO_PATH" || {
       log "Failed to change directory"
       return 1
   }

   # Pull latest changes first to avoid conflicts
   if ! git pull origin "$BRANCH"; then
       log "Failed to pull latest changes"
       return 1
   fi

   # Copy all config files
   if ! cp -r "$ZSHRC_PATH" "$CONFIG_FOLDER/"; then
       log "Failed to copy config files"
       return 1
   fi

   # Stage changes
   if ! git add "$CONFIG_FOLDER/"; then
       log "Failed to stage changes"
       return 1
   fi

   # Commit changes
   local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
   if ! git commit -m "Auto sync zsh config: $timestamp"; then
       log "No changes to commit"
       return 1
   fi


   # Push changes
   if ! git push origin "$BRANCH"; then
       log "Failed to push changes"
       return 1
   fi

   log "Successfully pushed changes"
   return 0
}

# Main loop
log "Starting .zshrc monitoring service..."
log "Monitoring started"

# Monitor for changes
while true; do
    if [ -f "$ZSHRC_PATH" ] && ! is_repo_clean; then
        sync_changes
    fi
    sleep "$CHECK_INTERVAL"
done