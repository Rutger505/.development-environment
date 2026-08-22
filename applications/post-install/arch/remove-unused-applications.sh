#!/usr/bin/env zsh

# Remove Omarchy preinstalled bloat we don't want on a dev machine.
# Safe to re-run: every removal is guarded by an installed/exists check.

DEV_ENV="${DEV_ENV:-$HOME/.local/share/dev-env}"
BLOAT_LIST="$DEV_ENV/applications/omarchy-bloat.lst"

# --- Packages to remove ----------------------------------------------------
# The list lives in applications/omarchy-bloat.lst, annotated with the reason
# for each package. Not kept under applications/packages/, because the
# installer loads every *.lst there and would reinstall them.
if [ -f "$BLOAT_LIST" ]; then
  # Strip comments (whole-line and trailing) and blank lines.
  REMOVE_PACKAGES=("${(@f)$(awk '{ sub(/#.*/, ""); if ($1 != "") print $1 }' "$BLOAT_LIST")}")

  INSTALLED_PACKAGES=()
  for pkg in "${REMOVE_PACKAGES[@]}"; do
    if pacman -Qq "$pkg" &> /dev/null; then
      INSTALLED_PACKAGES+=("$pkg")
    fi
  done

  if [ ${#INSTALLED_PACKAGES[@]} -gt 0 ]; then
    echo "Removing ${#INSTALLED_PACKAGES[@]} Omarchy packages: ${INSTALLED_PACKAGES[*]}"
    # -Rns also takes unneeded dependencies and config files with it.
    sudo pacman -Rns --noconfirm "${INSTALLED_PACKAGES[@]}"
  fi

  # Tell Omarchy the preinstalls are gone on purpose, so its migrations (and
  # the "Install > Preinstalls" menu entry) respect the choice. Undo with
  # omarchy-install-preinstalls.
  if [ -d "$HOME/.local/share/omarchy" ]; then
    mkdir -p "$HOME/.local/state/omarchy"
    touch "$HOME/.local/state/omarchy/preinstalls-removed"
  fi
else
  echo "Package list not found, skipping package removal: $BLOAT_LIST"
fi

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
