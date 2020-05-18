#!/bin/sh

capacity=$(df -h --output=source,avail /home | grep -A1 '/' | sed "s/^.* //;s/[[:alpha:]]//")
warn=""
if [ $capacity -lt 71 ]; then warn='!'; fi

printf "%s%s" "$warn " "$(echo $capacity | sed "s/$/G free/")"

