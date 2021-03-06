#!/bin/dash
#Option Display ------------
cancel="Cancel"
trids="3DS"
pc="PC"
mcbe="Minecraft: Bedrock Edition"
mcje="Minecraft: Java Edition"
#Game Types -------------
choices="$cancel\0icon\x1fzcancel
$trids\0icon\x1fz3ds
$pc\0icon\x1fzfullss
$mcbe\0icon\x1fzminecraftbe
$mcje\0icon\x1fzminecraft
NDS\0icon\x1fznds
NES\0icon\x1fznes
PS2\0icon\x1fzps2
RetroArch\0icon\x1fzretroarch
Steam"
gamedir="$HOME/.scripts/games"

#Message ----------------
message="What game do you want to launch?"

#Choice -----------------
chosen=$(echo -e "$choices" | rofi -p Games -dmenu -i -theme ~/.config/rofi/theme/sidebar.rasi)

#Choice Execution -------
case "$chosen" in
	RetroArch) notify-send "Launching..." "$chosen" && retroarch ;;
	$pc) games -t PC ;;
	PS2) games -t PS2 ;;
	NDS) sh $HOME/.scripts/games/nds.sh ;;
	$trids) games -t 3DS ;;
	Steam) notify-send "Launching..." "$chosen" && steam ;;
	$mcbe) sh $gamedir/mcpe.sh ;;
	"NES") games -t NES ;;
	$mcje) notify-send "Launching..." "$chosen" && gamemoderun java -jar "$HOME/my Games/PC/TLauncher.jar";;
esac


