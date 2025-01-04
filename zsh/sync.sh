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
    echo "[$timestamp] Changes detected, syncing..." >> "$LOG_FILE"

    cd "$REPO_PATH" || exit 1

    cp "$ZSHRC_PATH" "$CONFIG_FOLDER/.zshrc"

    git add .zshrc

    git commit -m "Auto sync zsh config: $timestamp"

    # Pull latest changes first to avoid conflicts
    if git pull origin "$BRANCH"; then
        # Push changes
        if git push origin "$BRANCH"; then
            echo "[$timestamp] Successfully pushed changes" >> "$LOG_FILE"
        else
            echo "[$timestamp] Failed to push changes" >> "$LOG_FILE"
        fi
    else
        echo "[$timestamp] Failed to pull latest changes" >> "$LOG_FILE"
    fi
}

# Main loop
echo "Starting .zshrc monitoring service..."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Monitoring started" >> "$LOG_FILE"

# Initial sync
if [ -f "$ZSHRC_PATH" ]; then
    sync_changes
fi

# Monitor for changes
while true; do
    if [ -f "$ZSHRC_PATH" ] && ! is_repo_clean; then
        sync_changes
    fi
    sleep "$CHECK_INTERVAL"
done