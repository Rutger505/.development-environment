#!/bin/bash


SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIRECTORY="$(dirname "$SCRIPT_PATH")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

SERVICE_USER_PACKAGES=(
  "update-dotfiles.timer"
)


load_package_list_from_dir PACKAGE_LIST "./package-lists/"
whereis ${PACKAGE_LIST[@]}
#yay -Sy --needed ${PACKAGE_LIST[@]}

exit 0 

run_scripts_in_dir "$SCRIPT_DIRECTORY/package-scripts"


run_scripts_in_dir "$SCRIPT_DIRECTORY/post-install"

echo "Enabling and starting services:"
echo ${SERVICE_PACKAGES[@]}
sudo systemctl enable --now ${SERVICE_PACKAGES[@]}
echo "Enabling and starting user services:"
echo ${SERVICE_USER_PACKAGES[@]}
systemctl --user enable --now ${SERVICE_USER_PACKAGES[@]}


echo "Finished installing applications! 🚀✨"
