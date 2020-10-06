#!/bin/dash
choices="1366x768
1360x765
1280x720"

chosen=$(echo -e "$choices" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case "$chosen" in
	1366x768) xrandr --output VGA-1 --mode $chosen && notify-send "Resolution has been changed to" "$chosen";;
	1360x765) xrandr --output VGA-1 --mode 1360x765_60.00 && notify-send "Resolution has been changed to" "1360x765";;
	1280x720) xrandr --output VGA-1 --mode $chosen && notify-send "Resolution has been changed to" "$chosen";;
esac
