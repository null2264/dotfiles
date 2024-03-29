#!/bin/zsh

#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	exec startx
#fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	[[ -n "$XDG_VTNR" && $XDG_VTNR -le 2 ]] && bash /usr/bin/tbsm

	[[ -f ~/.zshrc ]] && . ~/.zshrc
	[ ! -s ~/.config/mpd/pid ] && mpd

	export PATH="$HOME/.poetry/bin:$PATH"
fi
