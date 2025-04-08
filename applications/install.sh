#!/bin/bash

is_wsl() {
	[[ -n "$WSL_DISTRO_NAME" ]]
}

create_space() {
	echo
	echo
	echo
}

process_packages() {
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
	
	if [ -f "$package_manager/init.sh" ]; then
		echo "Running initialization script for $package_manager"
		source "$package_manager/init.sh"
	else
		echo "$package_manager/init.sh not found. Skipping initialization script for $package_manager"
	fi

	process_packages "$package_manager" "cli"

	if ! is_wsl; then
		process_packages "$package_manager" "desktop"
	else
		echo "Detected WSL... Skipping desktop applications for $package_manager"
	fi
done

process_custom_applications() {
	application_type="$1" # "cli" or "desktop"

	custom_applications_dir="custom/$application_type"
	if [ ! -d "$custom_applications_dir" ]; then
		echo "$custom_applications_dir directory not found. Skipping custom $application_type applications"
	fi
	
	
	for script in "$custom_applications_dir"/*.sh; do
		echo "Running $script"
		source "$script"
	done
	
}

# custom folder. containing a desktop and cli folder containing names of applications preceded by .sh
if [ -d "custom" ]; then
	
	process_custom_applications "cli"
	
	if ! is_wsl; then
		process_custom_applications "desktop"
	else
		echo "Detected WSL... Skipping custom desktop applications"
	fi
else
	echo "Custom directory not found. Skipping custom applications"
fi
