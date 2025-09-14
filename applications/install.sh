#!/bin/bash

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

SERVICE_PACKAGES=(
  "snapd" "cronie" "sddm" "kanata"
)
AUTOSTART_PACKAGES=()

if ! command -v paru >/dev/null 2>&1; then
  echo "Paru not found, installing..."

  install_paru
fi

find "$SCRIPT_DIRECTORY/package-lists/" -name "*.lst" -print0 | \
  xargs -0 cat | \
  grep -vE '^\s*#' | \
  grep -vE '^\s*$' | \
  paru -Sy --needed -




run_post_install_scripts "$SCRIPT_DIRECTORY" "${PACKAGES[@]}"
enable_services "${SERVICE_PACKAGES[@]}"
enable_autostart_apps "${AUTOSTART_PACKAGES[@]}"

echo "Finished installing applications! 🚀✨"
