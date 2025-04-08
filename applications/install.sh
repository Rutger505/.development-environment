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

package_managers=(apt flatpak snap)

for package_manager in "${package_managers[@]}"; do
	if [ -d "$package_manager" ]; then
		if [ -f "$package_manager/cli.txt" ]; then
			while IFS= read -r application_name; do
				install_package "$package_manager" "$application_name"
			done <"$package_manager/cli.txt"
			create_space
		else
			echo "CLI applications for $package_manager not found... Skipping"
		fi

		if ! is_wsl && [ -f "$package_manager/desktop.txt" ]; then
			if ! [ -f "$package_manager/desktop.txt" ]; then
				while IFS= read -r application_name; do
					install_package "$package_manager" "$application_name"
				done <"$package_manager/desktop.txt"
				create_space
			else
				echo "Desktop applications for $package_manager not found... Skipping"
			fi
		else
			echo "Detected wsl... Skipping desktop applications for $package_manager"
		fi

	else
		echo "$package_manager directory not found. Skipping applications for $package_manager"
	fi
done
