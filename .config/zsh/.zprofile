#!/bin/zsh

#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	exec startx
#fi

bash /usr/bin/tdm

[[ -f ~/.zshrc ]] && . ~/.zshrc
