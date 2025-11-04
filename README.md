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

5. Clone the repository in the home directory.

```bash
git clone git@github.com:Rutger505/.development-environment.git ~/.development-environment
```

6. Run applications installer script.

```bash
~/.development-environment/applications/install.sh
```

7. Use GNU Stow to symlink the dotfiles in the home directory.

```bash
cd ~/.development-environment
stow .
```

8. Do a full system update
```bash
~/.development-environment/scripts/update.sh
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

- Enable legacy openssl for conda
- Fix post install scripts reliying on binaries or path not set yet
- Make discord autostart webapp from omarchy.
- Replace esp-idf script with aur package
- Autostart apps in workspace: https://github.com/hyprwm/Hyprland/discussions/10207
