# Normal windows - use accent color
$activeBorderColor = rgb({{ accent_strip }})
$groupWindowActiveColor = rgba({{ accent_strip }}4d)

general {
    col.active_border = $activeBorderColor
}

# Grouped windows - use color5 (typically magenta/purple) to differentiate from normal windows
group {
    col.border_active = $activeBorderColor
    col.border_inactive = rgba({{ accent_strip }}66)
    col.border_locked_active = rgba({{ color6_strip }}ee)
    col.border_locked_inactive = rgba({{ color6_strip }}66)

    groupbar {
        col.active = $groupWindowActiveColor
        # col.inactive = rgba({{ accent_strip }}44)
        col.locked_active = rgba({{ color6_strip }}cc)
        col.locked_inactive = rgba({{ color6_strip }}44)
        text_color = rgb({{ foreground_strip }})
        text_color_inactive = rgba({{ foreground_strip }}88)
    }
}
