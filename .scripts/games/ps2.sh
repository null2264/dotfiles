#!/bin/dash
#Game Lists ------------
pstwo="Back\0icon\x1fzback
Okami\0icon\x1fzdisk
Persona 3 FES\0icon\x1fzdisk
Persona 4\0icon\x1fzdisk"

#Scripts ---------------
chosenps2=$(echo -e "$pstwo" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case $chosenps2 in
	Back)sh ~/.scripts/play.sh ;;
	"Okami") notify-send "Launching..." "$chosenps2" && PCSX2 --nogui --fullscreen "$HOME/my Games/PS2/Okami.iso" ;;
	"Persona 3 FES") notify-send "Launching..." "$chosenps2" && PCSX2 --nogui --fullscreen "$HOME/my Games/PS2/Persona 3 FES.iso" ;;
	"Persona 4") notify-send "$chosenps2" "Not available yet." ;;
esac

