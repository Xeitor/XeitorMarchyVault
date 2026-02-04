# XeitorMarchyVault

Personal dotfiles and system information 

# System overview
Omarchy based system
SO: Arch Linux
Package manager: pacman and nixos
window manager: Hyprland
terminal: ghosty
default editor: zed, nvim

# Dotfiles
- ghostty
- hypr
- omarchy
- starship
[GNU Stow](https://www.gnu.org/software/stow/).

## Setup on a new machine

```bash
# Install stow
sudo pacman -S stow

# Clone the repo
git clone https://github.com/Xeitor/XeitorMarchyVault ~/XeitorMarchyVault

# Stow all packages
cd ~/XeitorMarchyVault
stow hypr starship omarchy, etc
```

## Uninstall

```bash
cd ~/XeitorMarchyVault
stow -D hypr starship omarchy bin
```

## Packages

| Package | Contents | Target |
|---------|----------|--------|
| `hypr` | Hyprland configuration | `~/.config/hypr/` |
| `starship` | Starship prompt config | `~/.config/starship.toml` |
| `omarchy` | Theme templates | `~/.config/omarchy/themed/` |



## Disable ipv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
