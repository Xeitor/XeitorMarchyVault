#!/bin/bash
# Automatic monitor switching script for Hyprland
# Disables laptop screen when HDMI is connected, enables it when disconnected

handle_monitor() {
    # Check if HDMI-A-2 is connected
    if hyprctl monitors all | grep -q "HDMI-A-2"; then
        # HDMI connected: disable laptop, use HDMI as main
        hyprctl keyword monitor "eDP-1, disable"
        hyprctl keyword monitor "HDMI-A-2, 1920x1080@60, 0x0, 1"
    else
        # HDMI disconnected: enable laptop screen
        hyprctl keyword monitor "eDP-1, 1920x1080@60, 0x0, 1.5"
    fi
}

# Run once on startup
handle_monitor

# Listen for monitor events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    case $line in
        monitoradded*|monitorremoved*)
            handle_monitor
            ;;
    esac
done
