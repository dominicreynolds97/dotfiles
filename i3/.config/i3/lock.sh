#!/usr/bin/env bash
# Usage: lock.sh <wallpaper> [i3lock args...]
# Locks the screen with a blurred copy of the wallpaper and a clock.
# Needs i3lock-color and imagemagick. The blurred image is cached and only
# rebuilt when the wallpaper changes.

wallpaper="$1"
shift

cache="${XDG_CACHE_HOME:-$HOME/.cache}/lockscreen/$(basename "${wallpaper%.*}").png"

if [[ ! -f "$cache" || "$wallpaper" -nt "$cache" ]]; then
    mkdir -p "$(dirname "$cache")"
    # Blurring at quarter size is far quicker and looks the same scaled back up.
    # The tint darkens it towards the bar colour so the clock stands out.
    magick "$wallpaper" -resize 25% -blur 0x8 -resize 400% \
        -fill '#01122b' -colorize 35% "$cache"
fi

# Same palette as polybar/rofi, as rrggbbaa
fg=c0caf5ff
dim=c0caf5b3
accent=7aa2f7ff
bad=be2422ff
warn=cc8100ff
none=00000000
font="JetBrainsMono Nerd Font"

i3lock "$@" \
    --image="$cache" --fill \
    --clock --force-clock --indicator \
    --time-str="%H:%M" --date-str="%A %-d %B" \
    --time-font="$font" --date-font="$font" \
    --verif-font="$font" --wrong-font="$font" --layout-font="$font" \
    --time-size=128 --date-size=24 \
    --time-color=$fg --date-color=$dim \
    --time-pos="x+w/2:y+h/2-40" --date-pos="tx:ty+56" \
    --ind-pos="x+w/2:y+h/2+140" --radius=22 --ring-width=4 \
    --inside-color=$none --insidever-color=$none --insidewrong-color=$none \
    --ring-color=c0caf526 --ringver-color=$accent --ringwrong-color=$bad \
    --line-uses-inside --separator-color=$none \
    --keyhl-color=$accent --bshl-color=$warn \
    --verif-text="" --wrong-text="" --noinput-text="" --lock-text="" --lockfailed-text="" \
    --ignore-empty-password \
    --pass-media-keys --pass-volume-keys --pass-screen-keys
