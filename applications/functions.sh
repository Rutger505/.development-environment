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


run_scripts_in_dir() {
  local script_dir=$1

  for script in $script_dir/*.sh; do
    if [ -f "$script" ]; then
      echo "Running script: $(basename "$script")"
      "$script"
    fi
  done
}

load_package_list_from_dir() {
  local array_name="$1"
  local dir="$2"

  if [[ ! -d "$dir" ]]; then
    echo "Directory not found: $dir" >&2
    return 1
  fi

  local tmp_file="/tmp/all-packages-$$.lst"
  find "$dir" -name "*.lst" -print0 | \
    xargs -0 cat | \
    grep -vE '^\s*#' | \
    grep -vE '^\s*$' > "$tmp_file"
  mapfile -t "$array_name" < "$tmp_file"
  rm -f "$tmp_file"
}