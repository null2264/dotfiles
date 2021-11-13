#!/bin/sh

# $XDG_CONFIG_HOME/polybar/launch-dwm.sh &
picom &
nitrogen --restore &
$HOME/.scripts/launch-conky_dwm.sh &
sxhkd -c $HOME/.config/sxhkd/dwm &
[ x$(pidof dwmblocks) = "x" ] && $(dwmblocks &; pkill -RTMIN+1 dwmblocks) || echo "dwmblocks is running, skipped."
fcitx5 -d &
