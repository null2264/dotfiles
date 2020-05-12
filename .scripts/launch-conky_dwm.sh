#!/bin/dash
killall conky 

while pgrep -u $UID -x conky >/dev/null; do sleep 1; done

conky --config=$HOME/.config/conky/conkyrc_dwm -b
