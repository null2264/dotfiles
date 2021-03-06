#!/bin/zsh

# Path
PATH="$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')${PATH:+:${PATH}}"

# DEFAULT
export QT_QPA_PLATFORMTHEME='qt5ct'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export BROWSER='brave'
export TERMINAL='kitty'
export READER='zathura'
export HTTPS='localhost:9050'
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/Downloads/youtube-9ab71578c563.json"
# vim/nvim as manpager
export MANPAGER="nvimpager"
# export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

# SUDO
#export SUDO_ASKPASS=/bin/rofi-askpass
if [[ ! -z $DISPLAY ]]; then
  export SUDO_ASKPASS="/bin/dmenu-askpass"
fi

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

#cleaning up
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export SCRIPTS="$HOME/.scripts"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pyrc"

# Path to your oh-my-zsh installation.
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_PLUGINS="$ZSH_CUSTOM/plugins"

# icon for lf
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"
