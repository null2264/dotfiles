# dotfiles

## About
This repository contains config files that i used, some are coded/modified/scripted by me, some other are from other people's config from github/reddit/youtube.

## Dependences & Featured Software
- ZSH
- Console-TDM
- X11
- Nerd Fonts (Iosevka, UbuntuMono, and Fira)
- Feather (Font)
- st (st-zi build)
- Tiling WM (Qtile, BSPWM, or DWM)

## Tips

Small guide for my hotkeys
- MODKey (Super/Win Key): Window Manager
- Alt: Terminal
- Ctrl: Most program inside terminal

Add this to /etc/zsh/zshenv

```Shell
#!/bin/zsh

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```
