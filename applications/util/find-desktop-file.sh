# Search system-wide applications
ls /usr/share/applications/*.desktop | grep -i "$1"

# Search Snap applications (adjust path if needed)
ls /var/lib/snapd/desktop/applications/*.desktop | grep -i "$1"

# Search Flatpak applications (adjust path if needed)
ls /var/lib/flatpak/exports/share/applications/*.desktop | grep -i "$1"

# Search user-specific applications
ls ~/.local/share/applications/*.desktop | grep -i "$1"