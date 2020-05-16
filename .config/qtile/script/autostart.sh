#!/bin/sh

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#feh --bg-scale ~/my Files/wallpaper.jpg &
nitrogen --restore &
picom &
conky &
#pidgin &
#dropbox start &
