# Development environment

Repo to setup development environment on a new machine. It installs all the necessary tools and configurations to get
started with development.

## Installation

1. Generate ssh key:

```bash
ssh-keygen -t ed25519
```

2. Copy the public key:

```bash
copyfile ~/.ssh/id_ed25519.pub
```

3. [Set ssh key in Github](https://github.com/settings/ssh/new)

4. Clone the repository in the home directory.

```bash
git clone git@github.com:Rutger505/.development-environment.git ~/.development-environment
```

5. Run applications installer script.

```bash
~/.development-environment/applications/install.sh
```

6. Use GNU Stow to symlink the dotfiles in the home directory.

```bash
cd ~/.development-environment
stow .
```

Do a **full system restart** for changing default shell and showing desktop application.
