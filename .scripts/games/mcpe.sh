#!/bin/dash
#Version Lists ---------
mcpeversion="Back\0icon\x1fzback
Latest
1.14.30.51
1.14.25.1
1.14.1.4"

#Scripts ---------------
chosenmcpe=$(echo -e "$mcpeversion" | rofi -dmenu -i -theme ~/.config/rofi/theme/sidebar)

case "$chosenmcpe" in
		Back) sh ~/.scripts/play.sh ;;
		Latest) notify-send "Launching..." "MCPE Latest Version" && mcpelauncher-client -dg ~/.local/share/mcpelauncher/versions/1.14.30.51 ;;
		1.14.30.51) notify-send "Launching..." "MCPE Version: $chosenmcpe" && mcpelauncher-client -dg ~/.local/share/mcpelauncher/versions/$chosenmcpe ;;
		1.14.25.1) notify-send "Launching..." "MCPE Version: $chosenmcpe" && mcpelauncher-client -dg ~/.local/share/mcpelauncher/versions/$chosenmcpe ;;
	        1.14.1.5) notify-send "Launching..." "MCPE Version: $chosenmcpe" && mcpelauncher-client -dg ~/.local/share/mcpelauncher/versions/1.14.1.5 ;;
		1.14.1.4) notify-send "Launching..." "MCPE Version: $chosenmcpe" && mcpelauncher-client -dg ~/.local/share/mcpelauncher/versions/1.14.1.4 ;;

esac

