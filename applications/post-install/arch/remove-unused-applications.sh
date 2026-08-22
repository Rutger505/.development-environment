#!/usr/bin/env zsh

# Remove Omarchy preinstalled bloat we don't want on a dev machine.
# Safe to re-run: every removal is guarded by an installed/exists check.

DEV_ENV="${DEV_ENV:-$HOME/.local/share/dev-env}"

# --- Packages to remove ----------------------------------------------------
# The list itself lives in applications/omarchy-bloat.lst, annotated with the
# reason for each package (and for the ones deliberately kept).
"$DEV_ENV/scripts/dev-env-remove-omarchy-bloat" --noconfirm

# --- Default web-app launchers to remove -----------------------------------
# Omarchy seeds these as .desktop files (SUPER+SHIFT+... webapps).
REMOVE_WEBAPPS=(
  Basecamp
  Discord
  HEY
  WhatsApp
  X
  YouTube
  Zoom
  "Google Contacts"
  "Google Maps"
  "Google Messages"
  "Google Photos"
)

APPS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
if cd "$APPS_DIR"; then
  for app in "${REMOVE_WEBAPPS[@]}"; do
    if [ -f "${app}.desktop" ]; then
      echo "Removing webapp launcher: ${app}.desktop"
      rm "${app}.desktop"
    fi
  done
else
  echo "Can't change directory to $APPS_DIR" && exit 1
fi

# ChatGPT desktop app (optional Omarchy install) — remove if present.
if command -v omarchy-remove-ai-chatgpt &> /dev/null && yay -Q openai-codex-desktop &> /dev/null; then
  echo "Removing ChatGPT desktop app"
  omarchy-remove-ai-chatgpt
fi
