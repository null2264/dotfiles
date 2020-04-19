#!/bin/dash
#Game Lists ------------
tridsgame="Back\0icon\x1fzback
Animal Crossing - New Leaf
Corpse Party\0icon\x1fzcorpseparty
Harvest Moon 3D - A New Beginning\0icon\x1fzHarvMoon_Newb
New Super Mario Bros. 2\0icon\x1fznsmb2
Pokemon Omega Ruby\0icon\x1fzpokemon-omegaruby
Pokemon Ultra Moon\0icon\x1fzpokemon-ultramoon
Pokemon X\0icon\x1fzpokemon-x
Radiant Historia\0icon\x1fzradiant
Super Mario 3D Land\0icon\x1fzsm3d
"

#Scripts ---------------
chosen3ds=$(echo -e "$tridsgame" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case $chosen3ds in
	"Back") sh ~/.scripts/play.sh ;;
	"Super Mario 3D Land") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/$chosen3ds.3ds" ;;
	"New Super Mario Bros. 2") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/$chosen3ds.3ds" ;;
	"Corpse Party") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/Corpse Party.3ds" ;;
	"Pokemon X") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/Pokemon X.3ds" ;;
	"Pokemon Ultra Moon") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/Pokemon Ultra Moon.cxi" ;;
	"Pokemon Omega Ruby") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/Pokemon Omega Ruby.3ds" ;;
	"Radiant Historia") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/Radiant Historia.3ds" ;;
	"Harvest Moon 3D - A New Beginning") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/$chosen3ds.3ds" ;;
	"Animal Crossing - New Leaf") notify-send "Launching..." "$chosen3ds" && citra-qt "my Games/3DS/$chosen3ds.3ds" ;;

esac

