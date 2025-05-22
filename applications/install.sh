#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_DIRECTORY=$(dirname "$SCRIPT")
cd "$SCRIPT_DIRECTORY" || exit 1

is_wsl() {
	[[ -n "$WSL_DISTRO_NAME" ]]
}

source_script() {
	local script="$1"

	read -rp "Run $script? [y/N]: " yn
	case "$yn" in
	[Yy]*)
		echo "Running $script"
		source "$script"
		;;
	esac
}

process_scripts_from_directory() {
	application_type="$1" # "cli" or "desktop"

	for script in "$application_type"/*.sh; do
		source_script "$script"
	done
}

process_scripts_from_directory "setup"

process_scripts_from_directory "cli"

if ! is_wsl; then
	process_scripts_from_directory "desktop/setup"
	process_scripts_from_directory "desktop"
else
	echo "Detected WSL... Skipping custom desktop applications"
fi

echo "Finished installing applications! 🚀✨"
