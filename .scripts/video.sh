#!/bin/dash
choices="Cancel\0icon\x1fzcancel
Electron Player\0icon\x1fzE
KODI\0icon\x1fzkodi
Twitch\0icon\x1fztwitch
VLC\0icon\x1fzvlc
YouTube\0icon\x1fzyt"

message="What video player do you want to launch?"

chosen=$(echo -e "$choices" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case "$chosen" in
	KODI) notify-send "Launching..." "KODI" && kodi ;;
	"Electron Player") notify-send "Launching..." "Electron Player" && electronplayer ;;
	VLC) notify-send "Launching..." "VLC" && vlc ;;
	YouTube) notify-send "Launching..." "$chosen" && urxvt -e youtube-viewer ;;
	Twitch) notify-send "Launching..." "$chosen" && urxvt -e twitch-curses ;;
esac


