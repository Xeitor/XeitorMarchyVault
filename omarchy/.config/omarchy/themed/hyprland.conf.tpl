# Normal windows - use accent color
$activeBorderColor = rgb({{ accent_strip }})

general {
    col.active_border = $activeBorderColor
}

# Grouped windows - use color5 (typically magenta/purple) to differentiate from normal windows
group {
    col.border_active = rgba({{ accent_strip }}ee)
    col.border_inactive = rgba({{ accent_strip }}66)
    col.border_locked_active = rgba({{ color6_strip }}ee)
    col.border_locked_inactive = rgba({{ color6_strip }}66)

    groupbar {
        col.active = rgba({{ accent_strip }}cc)
        col.inactive = rgba({{ accent_strip }}44)
        col.locked_active = rgba({{ color6_strip }}cc)
        col.locked_inactive = rgba({{ color6_strip }}44)
        text_color = rgb({{ foreground_strip }})
        text_color_inactive = rgba({{ foreground_strip }}88)
    }
}
