#!/bin/dash
#Option Display ------------
screen=""
area=""
window=""
#Game Types -------------
choices="$screen
$area
$window"
gamedir="$HOME/.scripts/games"

#Message ----------------
message="What game do you want to launch?"

#Choice -----------------
chosen=$(echo -e "$choices" | rofi -p '' -dmenu -i -theme ~/.config/rofi/theme/Android/three.rasi)

#Choice Execution -------
case "$chosen" in
	RetroArch) notify-send "Launching..." "$chosen" && retroarch ;;
	$pc) sh $gamedir/pc.sh ;;
	PS2) sh $HOME/.scripts/games/ps2.sh ;;
	NDS) sh $HOME/.scripts/games/nds.sh ;;
	$trids) sh $HOME/.scripts/games/3ds.sh ;;
	Steam) notify-send "Launching..." "$chosen" && steam ;;
	$mcbe) sh $gamedir/mcpe.sh ;;
	"NES") sh $HOME/.scripts/games/nes.sh ;;
	$mcje) notify-send "$chosen" "Not available yet." ;;
esac


