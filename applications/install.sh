#!/bin/bash


SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

SERVICE_USER_PACKAGES=(
  "update-dotfiles.timer"
)

OPTIONAL_DIR="$SCRIPT_DIRECTORY/package-lists/optional"


run_scripts_in_dir "$SCRIPT_DIRECTORY/pre-install"

# Bootstrap fzf first for optional package selection
if ! command -v fzf &> /dev/null; then
  sudo pacman -S --noconfirm fzf
fi

# Handle optional package selection
if [[ -f "$OPTIONAL_CONFIG_FILE" ]]; then
  echo "Current optional packages:"
  cat "$OPTIONAL_CONFIG_FILE"
  echo ""
  read -p "Keep current selection? [Y/n] " choice
  if [[ "$choice" =~ ^[Nn]$ ]]; then
    select_optional_packages "$OPTIONAL_DIR"
  fi
else
  select_optional_packages "$OPTIONAL_DIR"
fi

# Load base packages and optional packages
load_package_list_from_dir PACKAGE_LIST "./package-lists/"
load_optional_packages PACKAGE_LIST "$OPTIONAL_DIR"

# Install all packages in a single call
yay -Sy --needed ${PACKAGE_LIST[@]}

run_scripts_in_dir "$SCRIPT_DIRECTORY/package-scripts"
run_optional_scripts "$SCRIPT_DIRECTORY/package-scripts/optional"

run_scripts_in_dir "$SCRIPT_DIRECTORY/post-install"

echo "Enabling and starting user services:"
echo ${SERVICE_USER_PACKAGES[@]}
systemctl --user enable --now ${SERVICE_USER_PACKAGES[@]}

# Enable tailscaled if tailscale is selected
if grep -q "^tailscale$" "$OPTIONAL_CONFIG_FILE" 2>/dev/null; then
  echo "Enabling and starting tailscaled service"
  sudo systemctl enable --now tailscaled
fi

echo "Finished installing applications! 🚀✨"
