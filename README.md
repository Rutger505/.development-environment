# Development environment

Repo to setup development environment on a new machine. It installs all the necessary tools and configurations to get
started with development.

## Installation

1. Install and login to bitwarden
```bash
pacman -Sy bitwarden
bitwarden
```

2. Generate ssh key:

```bash
ssh-keygen -t ed25519
```

3. Copy the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

4. [Set ssh key in Github](https://github.com/settings/ssh/new)

5. Clone the repository (default location is `~/.local/share/dev-env`).

```bash
git clone git@github.com:Rutger505/.development-environment.git ~/.local/share/dev-env
```

> **Custom location:** You can clone to any location. Set `DEV_ENV` in your environment before running scripts:
> ```bash
> export DEV_ENV="$HOME/my-custom-location"
> ```

6. Run applications installer script.

```bash
~/.local/share/dev-env/applications/install.sh
```

7. Use GNU Stow to symlink the config files to the home directory.

```bash
cd ~/.local/share/dev-env
stow --target="$HOME" .
```

8. Do a full system update
```bash
~/.local/share/dev-env/scripts/update.sh
```

Do a **full system restart** for changing default shell and showing desktop application.


## Post install manual steps

### Jetbrains editors

1. Open jetbrains toolbox
2. Login to jetbrains toolbox
3. Install editor(s)
4. Open an editor
5. In the bottom left click the gear > Edit Custom VM Options
6. Add: `-Dawt.toolkit.name=WLToolkit` To enable wayland
6. Go to settings > Backup and Sync > Enable Backup and Sync -> true
7. Go to settings > plugins > plugin settings > update automatically


### Zen browser

1. Open
2. Login to sync extensions, spaces etc.
3. Login to bitwarden


### VsCode

1. Open
2. Login and sync all settings


### Steam

1. Open & signin
2. Install wanted games


## TODO

- Fix post install scripts reliying on binaries or path not set yet
- Replace esp-idf script with aur package
- Create a way to persist not locking on idle:
  - File that when exists makes a startup script run `omarchy-stop-idle` something
- Keybinds for sizing window without mouse button, SUPER + Z 
- Fix monitor plugin with workspaces:
```
Source: https://wiki.hypr.land/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in
How do I move my favorite workspaces to a new monitor when I plug it in?

If you want workspaces to automatically go to a monitor upon connection, use the following:

In hyprland.conf:

exec-once = handle_monitor_connect.sh

where handle_monitor_connect.sh is: (example)
handle_monitor_connect.sh

#!/bin/sh

handle() {
  case $1 in monitoradded*)
    hyprctl dispatch moveworkspacetomonitor "1 1"
    hyprctl dispatch moveworkspacetomonitor "2 1"
    hyprctl dispatch moveworkspacetomonitor "4 1"
    hyprctl dispatch moveworkspacetomonitor "5 1"
  esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done

This makes workspaces 1, 2, 4, and 5 go to monitor 1 when connecting it.

Please note this requires socat to be installed.
```