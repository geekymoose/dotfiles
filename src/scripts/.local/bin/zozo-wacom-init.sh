#!/bin/bash
#
# Initialize Wacom tablet input devices for Sway.
# https://man.archlinux.org/man/sway-input

# Intuos on Tofu
swaymsg input "1386:788:Wacom_Intuos_Pro_S_Finger" events disabled
swaymsg input "1386:788:Wacom_Intuos_Pro_S_Pen" map_to_output "DVI-D-1"

# Cintiq on Tofu
swaymsg input "1386:772:Wacom_Cintiq_13HD_Pen" map_to_output "HDMI-A-2"
