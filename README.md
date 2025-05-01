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
cat ~/.ssh/id_ed25519.pub
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
7. Automate updating .dotfiles with a cron job.

```bash
crontab -e
```
Add the following line to the crontab file:
```bash
* * * * * ~/.development-environment/synchronization/update-dotfiles.sh
```

