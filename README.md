## dotfiles

### About
This repository contains config files that i used, some are coded/modified/scripted by me, some other are from other people's config from github/reddit/youtube.

### Dependences & Featured Software
- ZSH
- Console-TDM
- X11
- st (st-zi build)
- Tiling WM (Qtile, BSPWM, or DWM)

### Tips
Add this to /etc/zsh/zshenv

```Shell
#!/bin/zsh

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```
