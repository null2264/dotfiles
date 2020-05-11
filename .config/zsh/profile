#!/bin/zsh
# DEFAULT
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export BROWSER='firefox'
export TERMINAL='st'

# vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

# SUDO
export SUDO_ASKPASS=/bin/rofi-askpass

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

#cleaning up
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# Path to your oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_PLUGINS="$ZSH_CUSTOM/plugins"

