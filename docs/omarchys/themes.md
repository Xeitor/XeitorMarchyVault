# Omarchy Themes

## Overview

Omarchy uses a template-based theming system. Theme templates (`.tpl` files) are processed and output to their final configuration locations.

## Key Directories

- `~/.config/omarchy/themed/` - Template files (`.tpl`) that get processed with theme variables
- `~/.config/omarchy/current/theme/` - Current theme colors and settings
- `~/.local/share/omarchy/bin/` - Omarchy scripts including theme commands

## Template Files

Template files use Jinja-style variables like `{{ accent_strip }}`, `{{ background_strip }}`, `{{ foreground_strip }}`, etc.

Example from `hyprland.conf.tpl`:
```
$activeBorderColor = rgb({{ accent_strip }})
```

## Applying Theme Changes

After modifying any `.tpl` template file, you must run the template processor to apply changes:

```bash
~/.local/share/omarchy/bin/omarchy-theme-set-templates
```

Then reload the relevant application config (e.g., for Hyprland):

```bash
hyprctl reload
```

## Common Theme Commands

| Command | Description |
|---------|-------------|
| `omarchy-theme-set-templates` | Process all `.tpl` files and apply theme |
| `omarchy-theme-current` | Show current theme name |
| `omarchy-theme-list` | List available themes |
| `omarchy-theme-set <name>` | Set a new theme |

## Available Color Variables

Colors are defined in `~/.config/omarchy/current/theme/colors.toml`:

- `accent` / `accent_strip` - Primary accent color
- `background` / `background_strip` - Background color
- `foreground` / `foreground_strip` - Foreground/text color
- `color0` through `color15` - Terminal color palette
- `color0_strip` through `color15_strip` - Colors without `#` prefix

## Hyprland Window Groups

Hyprland allows grouping windows together (e.g., tabbed containers). To make grouped windows visually distinct from regular windows, we use different colors from the theme palette:

| Window Type | Color Used | Rationale |
|-------------|------------|-----------|
| Normal active window | `accent` | The primary accent draws attention to the focused window |
| Grouped window borders | `color5` | A contrasting color (typically magenta/purple) signals that windows are grouped |
| Locked group borders | `color6` | A different color (typically cyan) indicates the group is locked |

This differentiation helps users immediately recognize when they're working with grouped windows versus standalone ones, preventing confusion about window behavior (grouped windows move, resize, and close together).
