<p align="center">
  <a href="https://github.com/null2264/dotfiles"><img width="25%" src="https://github.com/null2264.png"></img></a>
</p>
<h1 align="center">null2264's dotfiles</h1>
<h3 align="center">
Repository that contains my personal config files.
</h3>

### Hi, welcome to my dotfiles repo!
This is my personal collection of configuration files.

I'm still in progress on cleaning up some mess.

<img align="right" width="55%" src='https://raw.githubusercontent.com/null2264/null2264/master/assets/07-26-20.17%3A19%3A32.1366x768.Zi.png'></img>
My Setup:

- **WM**: bspwm / DWM*
- **OS**: Arch Linux
- **Shell**: zsh
- **Terminal**: st\** / urxvt*
- **Editor**: Neovim / vim*
- **File Manager**: Thunar / lf\* / ranger*
- **Launcher**: rofi* / dmenu*
- **Browser**: Firefox

*info*: *\** = *config included*; *\*\* = source included*

## Setup
Currently there's no automatic installer for my dotfiles.

I'm working on Luke Smith's LARBS fork to be able to install my dotfiles

## Depedencies / Programs
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
*Set $PROFILE environment variable to your powershell config file path (ex: $PROFILE='$HOME/.config/powershell/profile.ps1')*

***README.md** is still under construction*
