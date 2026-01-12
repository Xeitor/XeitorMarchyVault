# Normal windows - use accent color
$activeBorderColor = rgb({{ accent_strip }})
$groupWindowActiveColor = rgba({{ accent_strip }}66)

general {
    col.active_border = $activeBorderColor
}

# Grouped windows - use color5 (typically magenta/purple) to differentiate from normal windows
group {
    col.border_active = $activeBorderColor

    groupbar {
        col.active = $groupWindowActiveColor
    }
}
