#!/bin/dash

cancel=""
quickSS=""
timer=""
select=""

choices="$cancel
$quickSS
$timer
$select"

message="What type of screenshot?"

chosen=$(echo -en "$choices" | rofi -dmenu -i -theme ~/.config/rofi/theme/Android/four.rasi)

case "$chosen" in
	$quickSS) scrot '%m-%d-%y.%H:%M:%S.$wx$h.Zi.png' -e 'mv $f ~/Pictures/scrot/' && notify-send -u low "Screenshot saved." ;;
	$timer) scrot '%m-%d-%y.%H:%M:%S.$wx$h.Zi.png' -d 5 -e 'mv $f ~/Pictures/scrot/' && notify-send -u low "Screenshot saved." ;;
	$select) scrot -s '%m-%d-%y.%H:%M:%S.$wx$h.Zi.png' -e 'mv $f ~/Pictures/scrot/' && notify-send -u low "Screenshot saved." ;;
esac 
