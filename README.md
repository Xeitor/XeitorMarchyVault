# XeitorMarchyVault

Personal dotfiles for Hyprland and Starship, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup on a new machine

```bash
# Install stow
sudo pacman -S stow

# Clone the repo
git clone https://github.com/Xeitor/XeitorMarchyVault ~/XeitorMarchyVault

# Stow all packages
cd ~/XeitorMarchyVault
stow hypr starship omarchy bin
```

## Uninstall

```bash
cd ~/XeitorMarchyVault
stow -D hypr starship omarchy bin
```

## Reload configs (omarchy)

After editing config files, reload them:

```bash
# Reload everything at once
reload-all

# Or individually:

# Hyprland
omarchy-refresh-hyprland

# Hypridle
omarchy-refresh-hypridle

# Hyprlock
omarchy-refresh-hyprlock

# Hyprsunset
omarchy-refresh-hyprsunset

# Apply theme changes
omarchy-theme-set <theme-name>

# List available themes
omarchy-theme-list

# Run custom hooks (from ~/.config/omarchy/hooks/)
omarchy-hook <hook-name>
```

## Packages

| Package | Contents | Target |
|---------|----------|--------|
| `hypr` | Hyprland configuration | `~/.config/hypr/` |
| `starship` | Starship prompt config | `~/.config/starship.toml` |
| `omarchy` | Theme templates | `~/.config/omarchy/themed/` |
| `bin` | Utility scripts | `~/.local/bin/` |

## Documentation

See `docs/` for additional notes:
- `docs/stow.md` - How GNU Stow works
- `docs/omarchys/themes.md` - Omarchy theming system
