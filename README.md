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
* * * * * cd ~/.development-environment && git pull && stow . >> ~/.development-environment/sync-cronjob.log 2>&1ta
```


## Applications

| Application    | Description                                                         | Status |
|----------------|---------------------------------------------------------------------|--------|
| zsh            | zsh with oh my zsh, automatically sync changes with this repository | ✅      |
| Zen browser    |                                                                     | ✅      |
| Docker desktop |                                                                     | ✅      |
| Phpstorm       |                                                                     | ✅      |
| configure git  | Configure email and name                                            | ✅      |
| Ghostty        |                                                                     | ✅      |
| k9s            |                                                                     | ✅      |


## Roadmap

Automatically install basic development tools such as:

- node, npm
- curl
- jq
- less
- nvim
- git
- kubectl
- composer
- make
- mkcert (with libnss3-tools)

Install the following applications:
- slack
- spotify
- postman
- vscode
- helm
- opentofu
- terraform
- tableplus


## Development

Clone the repository a second time. This is necessary to not mess with the zsh sync process.

