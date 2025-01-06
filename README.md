# Development environment

Repo to setup development environment on a new machine. It installs all the necessary tools and configurations to get
started with development.

## Installation

1. Clone the repository in the home directory.

```bash
git clone git@github.com:Rutger505/.development-environment.git ~/.development-environment
```

2. Run the setup script.

```bash
sudo ~/.development-environment/setup.sh
```

## Roadmap


Automatically install basic development tools such as:

- node, npm
- curl
- jq
- less
- nvim
- git
- kubectl

| Application       | Description                                                         | Status |
|-------------------|---------------------------------------------------------------------|--------|
| zsh               | zsh with oh my zsh, automatically sync changes with this repository | ✅      |
| zen browser       |                                                                     | ✅      |
| docker desktop    |                                                                     | ✅      |
| phpstorm          |                                                                     | ✅      |
| configure git     | Configure email and name                                            | ✅      |
| Ghostty           |                                                                     | ✅      |
| k9s               |                                                                     | ✅      |

## Development

Clone the repository a second time. This is necessary to not mess with the zsh sync process.

