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
