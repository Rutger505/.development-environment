#!/bin/bash


SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

SERVICE_PACKAGES=(
  "snapd" "cronie" "sddm" "kanata" "iwd" "bluetooth"
)
AUTOSTART_PACKAGES=()

if ! command -v paru >/dev/null 2>&1; then
  echo "Paru not found, installing..."

  install_paru
fi

mapfile -t PACKAGE_LIST < <( \
  find "./package-lists/" -name "*.lst" -print0 | \
  xargs -0 cat | \
  grep -vE '^\s*#' | \
  grep -vE '^\s*$' \
)
paru -Sy --needed "${PACKAGE_LIST[@]}"

run_scripts_in_dir "$SCRIPT_DIRECTORY/package-scripts"

run_scripts_in_dir "$SCRIPT_DIRECTORY/post-install"

echo "Enabling and starting services:"
echo ${SERVICE_PACKAGES[@]}
sudo systemctl enable --now ${SERVICE_PACKAGES[@]}

enable_autostart_apps "${AUTOSTART_PACKAGES[@]}"

echo "Finished installing applications! 🚀✨"
