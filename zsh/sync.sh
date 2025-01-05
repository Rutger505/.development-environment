#!/bin/bash

# Configuration
ZSH_CONFIG_FILE="$HOME/.zshrc"
CHECK_INTERVAL_SECONDS=55
REPO_PATH="$HOME/.development-environment"
REPO_BRANCH="main"
REPO_CONFIG_FOLDER="$REPO_PATH/zsh/config"
REPO_CONFIG_FILE="$REPO_CONFIG_FOLDER/.zshrc"

# Function to log messages with timestamps
source "$REPO_PATH/utils/log.sh"

import_from_remote() {
    log "Checking for remote changes..."

    if ! cd "$REPO_PATH"; then
        log "Failed to change directory"
        return 1
    fi

    # Fetch latest changes
    if ! git fetch origin "$REPO_BRANCH"; then
        log "Failed to fetch from remote"
        return 1
    fi

    # Check if remote has changes
    if git diff --quiet HEAD "origin/$REPO_BRANCH"; then
        log "No remote changes to sync"
        return 0
    fi

    # Pull changes
    if ! git pull origin "$REPO_BRANCH"; then
        log "Failed to pull remote changes"
        return 1
    fi

    # Copy config from repo to local system
    if ! cp "$REPO_CONFIG_FILE" "$ZSH_CONFIG_FILE"; then
        log "Failed to copy remote config to local system"
        return 1
    fi

    log "Successfully synced remote changes to local system"
    return 0
}

export_to_remote() {
    log "Checking for local changes..."

    if ! cd "$REPO_PATH"; then
        log "Failed to change directory"
        return 1
    fi

    # Check if local file exists
    if [ ! -f "$ZSH_CONFIG_FILE" ]; then
        log "Local config file is missing"
        return 1
    fi

    # Compare local with repo
    if diff "$ZSH_CONFIG_FILE" "$REPO_CONFIG_FILE" > /dev/null 2>&1; then
        log "No local changes to sync"
        return 0
    fi

    # Copy local changes to repo
    if ! cp "$ZSH_CONFIG_FILE" "$REPO_CONFIG_FILE"; then
        log "Failed to copy local config to repo"
        return 1
    fi

    # Stage changes
    if ! git add "$REPO_CONFIG_FILE"; then
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
    if ! git push origin "$REPO_BRANCH"; then
        log "Failed to push changes"
        return 1
    fi

    log "Successfully pushed local changes to remote"
    return 0
}

# Main loop
log "Starting .zshrc monitoring service..."

while true; do
    import_from_remote

    # If import did not fail, export changes
    if [ $? -eq 0 ]; then
        export_to_remote
    fi

    sleep "$CHECK_INTERVAL_SECONDS"
done