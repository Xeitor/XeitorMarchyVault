# Starship Prompt Configuration

Starship prompt that automatically themes with Omarchy.

## Files

| File | Purpose |
|------|---------|
| `~/.config/starship.toml` | Active config (auto-generated on theme change) |
| `~/.config/omarchy/hooks/theme-set` | Hook that regenerates starship on theme change |

## How It Works

```
omarchy-theme-set "Theme Name"
         │
         ▼
omarchy runs theme-set hook
         │
         ▼
Hook reads ~/.config/omarchy/current/theme/colors.toml
         │
         ▼
Hook writes new ~/.config/starship.toml with theme colors
         │
         ▼
New terminal shows themed prompt
```

## Prompt Structure

```
┌─────────────────────────────────────────────────────────────────────────┐
│ ░▒▓  ⮝  │  ~/path  │   main  │   v20.0.0   │                      │
│    ▲         ▲           ▲           ▲              ▲                    │
│    │         │           │           │              │                    │
│ color7    accent      color0      color8      background               │
│ (light)   (primary)   (dark)     (darker)    (terminal bg)             │
└─────────────────────────────────────────────────────────────────────────┘
```

## Color Mapping

Theme colors are read from `~/.config/omarchy/current/theme/colors.toml` and mapped to starship segments:

| Theme Variable | Starship Usage |
|----------------|----------------|
| `color7` | Arch icon segment background (light accent) |
| `accent` | Directory segment background (primary color) |
| `color0` | Git section background (dark) |
| `color8` | Language version section background (darker) |
| `background` | Text color on light segments |
| `foreground` | Text color on dark segments |

## Example: Theme Comparison

| Variable | Catppuccin | Rose Pine | Tokyo Night |
|----------|------------|-----------|-------------|
| `accent` | `#89b4fa` | `#56949f` | `#7aa2f7` |
| `background` | `#1e1e2e` | `#faf4ed` | `#1a1b26` |
| `foreground` | `#cdd6f4` | `#575279` | `#a9b1d6` |
| `color0` | `#45475a` | `#f2e9e1` | `#32344a` |
| `color7` | `#bac2de` | `#575279` | `#787c99` |
| `color8` | `#585b70` | `#9893a5` | `#444b6a` |

## Prompt Segments

The prompt displays (left to right):

1. **Arch icon** - System identifier with gradient intro `░▒▓`
2. **Directory** - Current path (truncated to 3 levels)
3. **Git branch** - Current branch with  icon
4. **Git status** - Ahead/behind and changes
5. **Language versions** - Node.js, Rust, Go, PHP when in relevant projects

## Customization

To modify the prompt structure, edit the hook at `~/.config/omarchy/hooks/theme-set`.

To add more language support, add sections like:

```toml
[python]
symbol = ""
style = "bg:$COLOR8"
format = '[[ $symbol ($version) ](fg:$ACCENT bg:$COLOR8)]($style)'
```

## Manual Theme Application

If starship doesn't update after a theme change:

```bash
# Re-run the hook manually
~/.config/omarchy/hooks/theme-set "$(cat ~/.config/omarchy/current/theme.name)"
```
