# Run the system's X startup scripts, e.g. passing DISPLAY to systemd user
# services so things like the file chooser portal can open windows
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

exec i3
