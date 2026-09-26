#!/bin/bash
# Greeter launched by greetd (see config.toml).
#
# Installed by copying rather than stowing: the greeter user can't follow a
# symlink into ~/dotfiles because $HOME is 700.

# The text console only draws 16 palette colours, so remap them to the navy
# palette used by polybar, rofi and i3 (\e]P<index><rrggbb>), then point
# tuigreet's theme at those palette slots:
#   0 navy bg   4 accent   7 text   8 dim   (the rest are kitty-ish brights)
palette=(
	01122b be2422 9ece6a cc8100
	7aa2f7 bb9af7 7dcfff c0caf5
	565f89 f7768e 9ece6a e0af68
	c4ddff bb9af7 7dcfff c4ddff
)
for i in "${!palette[@]}"; do
	printf '\033]P%x%s' "$i" "${palette[$i]}"
done
printf '\033[2J'

theme=(
	container=black
	border=blue
	title=blue
	greet=gray
	text=gray
	prompt=blue
	input=gray
	time=darkgray
	action=darkgray
	button=blue
)

exec tuigreet \
	--cmd startx \
	--time --time-format '%A %d %B  ·  %H:%M' \
	--greeting 'Ciao!' \
	--remember --asterisks \
	--width 50 --window-padding 1 --container-padding 2 \
	--theme "$(IFS=';'; echo "${theme[*]}")"
