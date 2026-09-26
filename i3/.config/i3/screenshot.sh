#!/usr/bin/env bash
# Usage: screenshot.sh [region|full]
# Saves to ~/Pictures/Screenshots and copies the image to the clipboard.

dir="$HOME/Pictures/Screenshots"
file="$dir/$(date +%F_%H-%M-%S).png"
mkdir -p "$dir"

case "${1:-region}" in
    region) maim --select --hidecursor "$file" ;;
    full)   maim --hidecursor "$file" ;;
esac || exit 0  # selection cancelled

xclip -selection clipboard -t image/png < "$file"
notify-send --icon="$file" "Screenshot saved" "${file/#$HOME/\~}"
