#!/bin/bash
set -euo pipefail

CONF_DIR="/etc/sddm.conf.d"
CONF_FILE="$CONF_DIR/autologin.conf"

read -r -p "Enable SDDM autologin to Hyprland? [y/N]: " ans
case "${ans:-N}" in
  [yY][eE][sS]|[yY]) ;;
  *)
    sudo rm -f "$CONF_FILE"
    exit 0 
    ;;
esac

sudo mkdir -p "$CONF_DIR"

if [ ! -f "$CONF_FILE" ]; then
  printf "[Autologin]\nUser=%s\nSession=hyprland.desktop\n" "$USER" | sudo tee "$CONF_FILE" >/dev/null
  exit 0
fi

if ! grep -qE '^\[Autologin\]' "$CONF_FILE"; then
  printf "\n[Autologin]\n" | sudo tee -a "$CONF_FILE" >/dev/null
fi

# Ensure User is set (defaults to current user if missing)
if grep -qE '^\s*User=' "$CONF_FILE"; then
  sudo sed -i "0,/^\s*User=.*/s//User=$USER/" "$CONF_FILE"
else
  # Add under [Autologin] (first occurrence)
  sudo awk -v u="$USER" '
    BEGIN{done=0}
    /^\[Autologin\]/{print; if(!done){print "User=" u; done=1; next}}
    {print}
  ' "$CONF_FILE" | sudo tee "${CONF_FILE}.tmp" >/dev/null && sudo mv "${CONF_FILE}.tmp" "$CONF_FILE"
fi

# Ensure Session is set to hyprland.desktop
if grep -qE '^\s*Session=' "$CONF_FILE"; then
  sudo sed -i '0,/^\s*Session=.*/s//Session=hyprland.desktop/' "$CONF_FILE"
else
  sudo awk '
    BEGIN{done=0}
    /^\[Autologin\]/{print; if(!done){print "Session=hyprland.desktop"; done=1; next}}
    {print}
  ' "$CONF_FILE" | sudo tee "${CONF_FILE}.tmp" >/dev/null && sudo mv "${CONF_FILE}.tmp" "$CONF_FILE"
fi