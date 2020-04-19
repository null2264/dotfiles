#!/bin/dash
#Game Lists ------------
games="Back\0icon\x1fzback\nTint (Tetris Clone)\nNothing."

#Scripts ---------------
chosen=$(echo -e "$games" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case $chosen in
	Back) sh ~/.scripts/play.sh ;;
	"Tint (Tetris Clone)") notify-send "Launching..." "$chosen" && urxvt -e tint ;;
	"Nothing.") notify-send "$chosen" "Not available yet." ;;
esac

