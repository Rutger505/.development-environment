#!/bin/bash

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

# Set DEV_ENV for scripts that need it
export DEV_ENV="${DEV_ENV:-$(dirname "$SCRIPT_DIRECTORY")}"

source "$SCRIPT_DIRECTORY/functions.sh"

echo "Detected distro: $DISTRO"

OPTIONAL_PACKAGE_LISTS_DIR="$SCRIPT_DIRECTORY/package-lists/optional"
OPTIONAL_SCRIPTS_DIR="$SCRIPT_DIRECTORY/package-scripts/optional"

# Run distro-specific pre-install scripts
run_scripts_in_dir "$SCRIPT_DIRECTORY/pre-install"

# Bootstrap essential packages (including fzf for optional package selection)
pkg_bootstrap

# Handle optional package selection
if [[ -f "$OPTIONAL_CONFIG_FILE" ]]; then
  echo "Current optional packages:"
  cat "$OPTIONAL_CONFIG_FILE"
  echo ""
  read -p "Keep current selection? [Y/n] " choice
  if [[ "$choice" =~ ^[Nn]$ ]]; then
    select_optional_packages "$OPTIONAL_PACKAGE_LISTS_DIR" "$OPTIONAL_SCRIPTS_DIR"
  fi
else
  select_optional_packages "$OPTIONAL_PACKAGE_LISTS_DIR" "$OPTIONAL_SCRIPTS_DIR"
fi

# Load base packages and optional packages
load_package_list_from_dir PACKAGE_LIST "./package-lists/"
load_optional_packages PACKAGE_LIST "$OPTIONAL_PACKAGE_LISTS_DIR"

# Install all packages
pkg_install ${PACKAGE_LIST[@]}

run_scripts_in_dir "$SCRIPT_DIRECTORY/package-scripts"
run_optional_scripts "$OPTIONAL_SCRIPTS_DIR"

run_scripts_in_dir "$SCRIPT_DIRECTORY/post-install"

echo "Finished installing applications!"
