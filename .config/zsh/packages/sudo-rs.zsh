# sudo-rs ships its binaries with an -rs suffix so it can coexist with sudo.
# Alias them interactively; scripts and /etc/sudoers keep using the real sudo.
if command -v sudo-rs >/dev/null 2>&1; then
  alias sudo='sudo-rs'
  alias sudoedit='sudoedit-rs'
  alias visudo='visudo-rs'
fi
