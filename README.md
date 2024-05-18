<!-- ZI-DOTFILES -->
<p align="center">
  <a href="https://github.com/null2264/dotfiles"><img width="25%" src="https://github.com/null2264.png"></img></a>
</p>
<h1 align="center">null2264's dotfiles</h1>
<h3 align="center">
Repository that contains my personal config files.
</h3>

### Hi, welcome to my dotfiles repo!
This is my personal collection of configuration files.

I'm still working on cleaning up some mess.

<img align="right" width="55%" src='https://raw.githubusercontent.com/null2264/null2264/master/assets/newSetup.png'></img>
My Setup:

- **WM**: Hyprland
- **OS**: Arch Linux / macOS 13.x (Ventura)[^mac]
- **Shell**: zsh
- **Terminal**: kitty / iTerm2
- **Editor**: Neovim / VSCode / IDEA
- **File Manager**: Thunar / Nautilus / lf
- **Launcher**: tofi / Alfred
- **Browser**: Pulse

[^mac]: macOS support is partially working

## Setup

> [!WARNING]
> This section is still WIP!

First time setup only: run `./pre-bootstrap` then follow the instruction. (Or run `./pre-bootstrap - > ~/.config/zsh/include/dotfiles`)

## Recommended Project/Software
- TBSM
- Fonts
  - Iosevka + Sarasa Gothic
  - Fira
  - Feather / Lucide / Phosphor (for Icons)
- kitty
- Tiling WM
  - Qtile (Linux - X11)
  - BSPWM (Linux - X11)
  - DWM (Linux - X11)
  - Hyprland (Linux - Wayland)
  - yabai (macOS)
- [dortania](https://github.com/dortania) (A great hackintosh guide)

## Tips

### Small guide for my tiling WM hotkeys
- MODKey (Super/Win Key): Window Manager
- Alt/Option: Terminal
- Ctrl/: Most program inside terminal

### ZSH setup
Add this to `/etc/zsh/zshenv` (**macOS**: `/etc/zshenv`)

```Shell
#!/bin/zsh

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```
