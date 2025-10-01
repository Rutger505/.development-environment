#!/bin/bash


SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

SERVICE_USER_PACKAGES=(
  "update-dotfiles.timer"
)


if ! command -v paru > /dev/null 2>&1; then
  echo "Paru not found, installing..."

  install_paru
fi;

run_scripts_in_dir "$SCRIPT_DIRECTORY/pre-install"


load_package_list_from_dir PACKAGE_LIST "./package-lists/"
paru -Sy --needed ${PACKAGE_LIST[@]}

run_scripts_in_dir "$SCRIPT_DIRECTORY/package-scripts"


run_scripts_in_dir "$SCRIPT_DIRECTORY/post-install"

echo "Enabling and starting user services:"
echo ${SERVICE_USER_PACKAGES[@]}
systemctl --user enable --now ${SERVICE_USER_PACKAGES[@]}


echo "Finished installing applications! 🚀✨"
