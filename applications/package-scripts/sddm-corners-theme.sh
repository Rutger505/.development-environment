#!/bin/bash

if [ ! -d /usr/share/sddm/themes/sddm-astronaut-theme ]; then
  sudo git clone -b master --depth 1 \
    https://github.com/keyitdev/sddm-astronaut-theme.git \
    /usr/share/sddm/themes/sddm-astronaut-theme
fi

sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/



# Set Theme in /etc/sddm.conf without nuking file:
# - If [Theme] section exists and Current= present, replace it.
# - If [Theme] exists but Current= missing, append under [Theme].
# - If no [Theme], append whole section at end.
if [ -f /etc/sddm.conf ]; then
  if grep -qE '^\[Theme\]' /etc/sddm.conf; then
    if grep -qE '^\s*Current=' /etc/sddm.conf; then
      sudo sed -i '0,/^\s*Current=.*/s//Current=sddm-astronaut-theme/' /etc/sddm.conf
    else
      # Append Current= after first [Theme] line
      sudo awk '
        BEGIN{done=0}
        /^\[Theme\]/{print; if(!done){print "Current=sddm-astronaut-theme"; done=1; next}}
        {print}
      ' /etc/sddm.conf | sudo tee /etc/sddm.conf.tmp >/dev/null
      sudo mv /etc/sddm.conf.tmp /etc/sddm.conf
    fi
  else
    printf "\n[Theme]\nCurrent=sddm-astronaut-theme\n" | sudo tee -a /etc/sddm.conf >/dev/null
  fi
else
  printf "\n[Theme]\nCurrent=sddm-astronaut-theme\n" | sudo tee /etc/sddm.conf >/dev/null
fi

# Ensure sddm.conf.d exists
sudo mkdir -p /etc/sddm.conf.d

# Configure virtual keyboard in /etc/sddm.conf.d/virtualkbd.conf:
# - If file exists and InputMethod present, replace it.
# - If file exists and no InputMethod, append key.
# - If file missing, create with minimal content.
VKBD=/etc/sddm.conf.d/virtualkbd.conf
if [ -f "$VKBD" ]; then
  if grep -qE '^\s*InputMethod=' "$VKBD"; then
    sudo sed -i '0,/^\s*InputMethod=.*/s//InputMethod=qtvirtualkeyboard/' "$VKBD"
  else
    # Ensure [General] present; if not, add it before appending key
    if ! grep -qE '^\[General\]' "$VKBD"; then
      printf "[General]\n" | sudo tee -a "$VKBD" >/dev/null
    fi
    printf "InputMethod=qtvirtualkeyboard\n" | sudo tee -a "$VKBD" >/dev/null
  fi
else
  printf "[General]\nInputMethod=qtvirtualkeyboard\n" | sudo tee "$VKBD" >/dev/null
fi