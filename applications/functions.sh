#!/bin/bash

prompt_for_confirmation() {
  local package="$1"
  local automatic_startup_enable="$2"
  local automatic_startup_kind="$3" # "service" or "desktop"

  echo -n "Install $package? (y/N) "
  read -r response

  if [[ ! "$response" =~ ^[Yy]$ ]]; then
    return 0
  fi

  PACKAGES+=("$package")

  if [[ "$automatic_startup_enable" != "true" ]]; then
    return 0
  fi

  echo -n " └─ Activate $automatic_startup_kind entry? (y/N) "
  read -r response_startup

  if [[ ! "$response_startup" =~ ^[Yy]$ ]]; then
    return 0
  fi

  if [[ "$automatic_startup_kind" = "service" ]]; then
    SERVICE_PACKAGES+=("$package")
  elif [[ "$automatic_startup_kind" = "desktop" ]]; then
    AUTOSTART_PACKAGES+=("$package")
  else
    echo "Unknown automatic_startup_kind: $automatic_startup_kind"
  fi
}

install_paru() {
  sudo pacman -S --needed base-devel

  git clone https://aur.archlinux.org/paru.git ~/tmp/paru
  cd ~/tmp/paru || exit 1
  makepkg -si

  cd - || exit 1
  rm -rf ~/tmp/paru
}


run_post_install_scripts() {
  local script_dir=$1
  shift
  local packages=("$@")

  for package in "${packages[@]}"; do
    local post_install_script="$script_dir/post-install/${package}.sh"

    if [ -f "$post_install_script" ]; then
      echo "Running post-install script for $package..."
      "$post_install_script"
    fi
  done
}

enable_services() {
  local services=("$@")

  for service in "${services[@]}"; do
    echo "Enabling and starting $service service..."
    sudo systemctl enable --now "$service"
  done
}

enable_autostart_apps() {
  local apps=("$@")

  local autostart_dir="$HOME/.config/autostart"
  mkdir -p "$autostart_dir"

  for app in "${apps[@]}"; do
    local desktop_file_path="/usr/share/applications/${app}.desktop"

    if [ -f "$desktop_file_path" ]; then
      echo "Enabling autostart for $app..."
      ln -sf "$desktop_file_path" "$autostart_dir/"
    else
      echo "Warning: Desktop file for $app not found at $desktop_file_path"
    fi
  done
}
