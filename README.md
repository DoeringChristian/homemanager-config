# Home Manager Configuration for Ubuntu

This repository contains a Home Manager configuration for managing user
environment on Ubuntu systems using Nix.

## Prerequisites

1. Install Nix on Ubuntu:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Enable flakes (add to `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`):

```
experimental-features = nix-command flakes
```

## Installation

1. Clone this repository:

```bash
git clone <repository-url> ~/homemanager
cd ~/homemanager
```

2. Update the configuration:
   - Edit `home.nix` and set your Git username and email
   - Adjust the username if different from `doeringc`
   - Add or remove packages as needed

3. Build and activate the configuration:

```bash
nix run home-manager/master -- switch --impure --flake .#doeringc
```

## Usage

After installation, you can:

- Update packages: `nix flake update`
- Apply changes: `home-manager switch --flake .#doeringc`
- Roll back: `home-manager generations` and `home-manager rollback`

## Structure

- `flake.nix`: Defines inputs and outputs for the configuration
- `home.nix`: Main configuration file with packages and settings
- `.gitignore`: Git ignore rules for Nix artifacts

## Customization

The configuration includes:

- Development tools (git, vim, neovim, tmux)
- Programming languages (Python, Node.js, GCC)
- Modern CLI tools (ripgrep, fzf, bat, eza, starship)
- Shell configuration with useful aliases
- Git configuration with sensible defaults

Add more packages by editing the `home.packages` list in `home.nix`.
