# Run the system's X startup scripts, e.g. passing DISPLAY to systemd user
# services so things like the file chooser portal can open windows
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Monitors often default to 60Hz. Run the connected one at its native
# resolution (marked + by xrandr) and the highest refresh rate it offers there.
set -- $(xrandr --query | awk '
    / connected/ && !out { out = $1; next }
    out && /^[^ ]/ { exit }
    out && /\+/ && !mode {
        mode = $1
        for (i = 2; i <= NF; i++) { r = $i; gsub(/[*+]/, "", r); if (r + 0 > max) max = r }
    }
    END { print out, mode, max }')
[ $# -eq 3 ] && xrandr --output "$1" --mode "$2" --rate "$3"
set --

exec i3
