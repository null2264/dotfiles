#!/bin/dash
#Game Lists ------------
games="Back\0icon\x1fzback
Pac-Man\0icon\x1fznescart
Super Mario Bros.\0icon\x1fznescart
Tetris\0icon\x1fznescart"

#Scripts ---------------
chosenNes=$(echo -e "$games" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case $chosenNes in
	Back) sh ~/.scripts/play.sh ;;
	"Pac-Man") notify-send "$chosenNes" "Not available yet." ;;
	"Super Mario Bros.") notify-send "$chosenNes" "Not available yet." ;;
	"Tetris") notify-send "Launching..." "$chosenNes" && nestopia -f "$HOME/my Games/NES/Tetris (USA).nes"
esac

