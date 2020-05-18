#!/bin/sh

capacity=$(df -h --output=source,avail /home | grep -A1 '/' | sed "s/^.* //;s/[[:alpha:]]//")
warn=""

[ $capacity -lt 21 ] && warn='!'

printf "%s%s" "$warn " "$(echo $capacity | sed "s/$/G free/")"

