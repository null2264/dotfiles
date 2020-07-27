#!/bin/dash
choices="Cancel\0icon\x1fzcancel
ncmpcpp
cmus\0icon\x1fzcmus
Spotify\0icon\x1fzspotify
VLC\0icon\x1fzvlc"

message="What music player do you want to launch?"

chosen=$(echo -e "$choices" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)


case "$chosen" in
	cmus) notify-send "Launching..." "cmus" && st -n cmus -e cmus ;;
	Spotify)  notify-send "Launching..." "Spotify" && env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify ;;
	VLC) notify-send "Launching..." "VLC" && vlc ;;
	ncmpcpp) notify-send "Launching..." "$chosen" && st -e ncmpcpp ;;
esac
