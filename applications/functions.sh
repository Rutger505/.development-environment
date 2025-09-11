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

