#!/bin/bash

OPTIONAL_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dev-env/optional-packages.conf"

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
  # Exclude the optional directory - those are handled separately
  find "$dir" -maxdepth 1 -name "*.lst" -print0 | \
    xargs -0 cat | \
    grep -vE '^\s*#' | \
    grep -vE '^\s*$' > "$tmp_file"
  mapfile -t "$array_name" < "$tmp_file"
  rm -f "$tmp_file"
}

select_optional_packages() {
  local optional_dir="$1"

  if [[ ! -d "$optional_dir" ]]; then
    echo "Optional packages directory not found: $optional_dir" >&2
    return 1
  fi

  mkdir -p "$(dirname "$OPTIONAL_CONFIG_FILE")"

  # Get list of available optional packages (basename without .lst)
  local available=()
  for lst in "$optional_dir"/*.lst; do
    if [[ -f "$lst" ]]; then
      available+=("$(basename "$lst" .lst)")
    fi
  done

  if [[ ${#available[@]} -eq 0 ]]; then
    echo "No optional packages available"
    return 0
  fi

  # Use fzf to select packages
  local selected
  selected=$(printf '%s\n' "${available[@]}" | fzf --multi --prompt="Select optional packages: " \
    --header="Press SPACE to select, ENTER to confirm" \
    --bind "j:down,k:up,ctrl-a:select-all,ctrl-d:deselect-all,space:toggle" \
    --preview "cat '$optional_dir/{}.lst'" \
    --preview-window=right:50%) || true

  # Save selection to config file
  if [[ -n "$selected" ]]; then
    echo "$selected" > "$OPTIONAL_CONFIG_FILE"
  else
    # Empty selection - create empty config
    > "$OPTIONAL_CONFIG_FILE"
  fi
}

load_optional_packages() {
  local array_name="$1"
  local optional_dir="$2"

  if [[ ! -f "$OPTIONAL_CONFIG_FILE" ]]; then
    return 0
  fi

  local tmp_file="/tmp/optional-packages-$$.lst"
  > "$tmp_file"

  while IFS= read -r pkg_name; do
    [[ -z "$pkg_name" ]] && continue
    local lst_file="$optional_dir/$pkg_name.lst"
    if [[ -f "$lst_file" ]]; then
      grep -vE '^\s*#' "$lst_file" | grep -vE '^\s*$' >> "$tmp_file"
    fi
  done < "$OPTIONAL_CONFIG_FILE"

  # Append to existing array
  local -n arr="$array_name"
  while IFS= read -r pkg; do
    arr+=("$pkg")
  done < "$tmp_file"

  rm -f "$tmp_file"
}

run_optional_scripts() {
  local scripts_dir="$1"

  if [[ ! -f "$OPTIONAL_CONFIG_FILE" ]]; then
    return 0
  fi

  while IFS= read -r pkg_name; do
    [[ -z "$pkg_name" ]] && continue
    local script="$scripts_dir/$pkg_name.sh"
    if [[ -f "$script" ]]; then
      echo "Running optional script: $pkg_name"
      "$script"
    fi
  done < "$OPTIONAL_CONFIG_FILE"
}