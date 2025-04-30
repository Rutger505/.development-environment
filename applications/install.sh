#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIRECTORY=$(dirname "$SCRIPT")
cd "$SCRIPT_DIRECTORY" || exit 1

is_wsl() {
	[[ -n "$WSL_DISTRO_NAME" ]]
}

source_script() {
  local script="$1"

  while true; do
    read -rp "Run $script? [y/N]: " yn

    case "$yn" in
      [Yy]*)
        echo "Running $script"
        source "$script"
        break
        ;;
      *)
        echo "Skipping $script"
        break
        ;;
    esac
  done
}

process_applications() {
	application_type="$1" # "cli" or "desktop"

	for script in "$application_type"/*.sh; do
    source_script "$script"
  done
}

source_script "0-update-apt.sh"
source_script "0-upgrade-apt.sh"

process_applications "cli"

if ! is_wsl; then
  process_applications "desktop"
else
  echo "Detected WSL... Skipping custom desktop applications"
fi
