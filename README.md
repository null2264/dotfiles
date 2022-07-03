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

<img align="right" width="55%" src='https://raw.githubusercontent.com/null2264/null2264/master/assets/07-26-20.17%3A19%3A32.1366x768.Zi.png'></img>
My Setup:

- **WM**: bspwm / DWM*ʳ*
- **OS**: Arch Linux / macOS 12.x (Monterey)*ᵖ*
- **Shell**: zsh
- **Terminal**: st*ʳ* / kitty / iTerm2
- **Editor**: Neovim / vim
- **File Manager**: Thunar / lf
- **Launcher**: rofi / dmenu / Sol
- **Browser**: Librewolf / Brave

*info*: *ʳ* = *in separate repo*; *ᵖ* = *partially work*

## Setup
Currently there's no automatic installer for my dotfiles.

~~I'm working on Luke Smith's LARBS fork to be able to install my dotfiles~~ (Too lazy lol)

## Recommended Project/Software
- LARBS
- Console-TDM
- Nerd Fonts
  - Iosevka
  - Fira
  - Sarasa Font
- Feather / Lucide (Font)
- st (st-zi build)
- Tiling WM
  - Qtile
  - BSPWM
  - DWM
  - yabai
- [dortania](https://github.com/dortania) (A great hackintosh guide)

## Tips

### Small guide for my dwm hotkeys
- MODKey (Super/Win Key): Window Manager
- Alt/Option: Terminal
- Ctrl/: Most program inside terminal

### ZSH setup
Add this to `/etc/zsh/zshenv` (**macOS**: `/etc/zshenv`)

```Shell
#!/bin/zsh

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```

### For winders peeps
Set $PROFILE environment variable to your powershell config file path (ex: $PROFILE='$HOME/.config/powershell/profile.ps1')
