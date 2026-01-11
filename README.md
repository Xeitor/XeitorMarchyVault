# XeitorMarchyVault

Personal dotfiles for Hyprland and Starship.

## Setup on a new machine

```bash
# Clone the repo
git clone https://github.com/Xeitor/XeitorMarchyVault ~/XeitorMarchyVault

# Create symlinks
ln -s ~/XeitorMarchyVault/hypr ~/.config/hypr
ln -s ~/XeitorMarchyVault/starship.toml ~/.config/starship.toml
```

## Reload configs (omarchy)

After editing config files, reload them:

```bash
# Reload everything at once
~/XeitorMarchyVault/scripts/reload-all

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

## Contents

- `hypr/` - Hyprland configuration
- `starship.toml` - Starship prompt configuration
- `scripts/` - Utility scripts (reload-all, etc.)
- `docs/` - Documentation notes
