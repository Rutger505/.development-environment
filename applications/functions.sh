#!/bin/bash

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

  for script in $script_dir/*; do
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