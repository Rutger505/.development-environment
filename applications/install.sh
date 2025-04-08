#!/bin/bash

is_wsl() {
	[[ -n "$WSL_DISTRO_NAME" ]]
}

prepare_package_manager() {
	package_manager="$1"

	case "$package_manager" in
	apt)
		sudo apt update
		sudo apt upgrade -y
		;;
	flatpak)
		# TODO install flatpack
		;;
	snap)
		# TODO install snap
		sudo snap refresh
		;;
	*)
		echo "Error: Unknown package manager: $package_manager"
		return 1
		;;
	esac
}

install_package() {
	package_manager="$1"
	application_name="$2"

	case "$package_manager" in
	apt)
		sudo apt install -y "$application_name"
		;;
	flatpak)
		flatpak install --assumeyes flathub "$application_name"
		;;
	snap)
		sudo snap install "$application_name"
		;;
	*)
		echo "Error: Unknown package manager: $package_manager"
		return 1
		;;
	esac
}

create_space() {
	echo
	echo
	echo
}

process_applications() {
	package_manager="$1"
	application_type="$2" # "cli" or "desktop"

	file_path="$package_manager/$application_type.txt"

	if [ ! -f "$file_path" ]; then
		application_type_capitalized=$(echo "$application_type" | sed 's/^\(.\)/\U\1/')
		echo "$application_type_capitalized applications for $package_manager  not found... Skipping"
		return
	fi

	while IFS= read -r application_name; do
		install_package "$package_manager" "$application_name"
	done <"$file_path"

	create_space
}

package_managers=(apt flatpak snap)

for package_manager in "${package_managers[@]}"; do
	if [ ! -d "$package_manager" ]; then
		echo "$package_manager directory not found. Skipping applications for $package_manager"
		continue # Skip to the next package manager
	fi

	process_applications "$package_manager" "cli"

	if ! is_wsl; then
		process_applications "$package_manager" "desktop"
	else
		echo "Detected WSL... Skipping desktop applications for $package_manager"
	fi
done
