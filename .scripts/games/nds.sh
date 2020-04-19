#!/bin/dash
#Game Lists ------------
games="Back\0icon\x1fzback
Pokemon Black\0icon\x1fzndscart
Pokemon Black 2\0icon\x1fzndscart"

#Scripts ---------------
chosen=$(echo -e "$games" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case $chosen in
	Back) sh ~/.scripts/play.sh ;;
	"Pokemon Black") notify-send "$chosen" "Not available yet." ;;
	"Pokemon Black 2") notify-send "$chosen" "Not available yet." ;;
esac

