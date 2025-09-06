#!/bin/bash

sudo yay -S tmux

git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

~/.local/share/tmux/plugins/tpm/bin/install_plugins all

mkdir -p ~/.config/systemd/user
cat >"${HOME}/.config/systemd/user/tmux.service" <<'EOF'
[Unit]
Description=tmux default session (detached)
Documentation=man:tmux(1)

[Service]
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/tmux new-session -d -s 0

ExecStop=/home/rutger/.local/share/tmux/plugins/tmux-resurrect/scripts/save.sh
ExecStop=/usr/bin/tmux kill-server
KillMode=control-group

RestartSec=2

[Install]
WantedBy=default.target
EOF
