#!/usr/bin/env bash

set -euo pipefail

entries="Shutdown\nReboot\nSuspend\nHibernate\nLock\nLogout\nCancel"

choice="$(printf "%b" "$entries" | wofi --dmenu --prompt "Power" --cache-file /dev/null)"

case "$choice" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Suspend) systemctl suspend ;;
  Hibernate) systemctl hibernate ;;
  Lock) command -v hyprlock >/dev/null && hyprlock || loginctl lock-session ;;
  Logout) hyprctl dispatch exit 0 || loginctl terminate-user "$USER" ;;
  ""|Cancel) exit 0 ;;
esac