#!/bin/sh

launch-dwmblocks &
picom &
nitrogen --restore &
$HOME/.scripts/launch-conky_dwm.sh &

#if [ x$(pidof dwmblocks) = "x" ] 
#then
#	dwmblocks &
#	pkill -RTMIN+1 dwmblocks
#else
#	echo 'dwmblocks is running, skipped.'
#fi
