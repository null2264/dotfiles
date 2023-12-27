#!/bin/sh

# $XDG_CONFIG_HOME/polybar/launch-dwm.sh &
picom &
nitrogen --restore &
$HOME/.scripts/launch-conky_dwm.sh &
sxhkd -c $HOME/.config/sxhkd/dwm &
easyeffects --gapplication-service &
if [ x$(pidof dwmblocks) = "x" ] 
then
	dwmblocks &
	pkill -RTMIN+1 dwmblocks
else
	echo 'dwmblocks is running, skipped.'
fi
fcitx5 -d &
