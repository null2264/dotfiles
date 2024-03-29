#!/bin/zsh
# -- XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"

if [[ "$OSTYPE" == "darwin"* ]]; then
	export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
	export CHROME_EXECUTABLE=/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser
else
	export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"

	# Android stuff
	export ANDROID_SDK_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/android/Android/Sdk"
	export ANDROID_PREFS_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/android/Android/Sdk"
	export ANDROID_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android/Android/Sdk"
	export ANDROID_AVD_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android/.android/avd"
fi

# -- Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# -- Python
if [[ "$OSTYPE" == "darwin"* ]]; then
	export PYTHONNOUSERSITE=1
fi

# -- Path
export BUN_INSTALL="$HOME/.bun"
if [[ "$OSTYPE" == "darwin"* ]]; then
	export PYTHONPATH="$HOME/Library/Python/3.10/lib:$PYTHONPATH"
	LOCAL_PATH=$(du "$HOME/.local/bin/" -d 1 | cut -f2 > /tmp/ENV_PATH && paste -sd ':' /tmp/ENV_PATH)
	LOCAL_PATH="$HOME/Library/Python/3.10/bin:$LOCAL_PATH"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	LOCAL_PATH=$(du "$HOME/.local/bin/" -d 1 | cut -f2 | paste -sd ':')
fi
PATH="$BUN_INSTALL/bin:$HOME/.pub-cache/bin:$HOME/.local/share/go/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_AVD_HOME:$HOME/.local/share/npm/bin:$HOME/.local/share/cargo/bin:$LOCAL_PATH${PATH:+:${PATH}}"
# export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library

# -- IBus stuff (IME)
if [[ "$XDG_SESSION_TYPE" != "wayland" ]]; then
	export GTK_IM_MODULE="ibus"
	export QT_IM_MODULE="ibus"
	export GLFW_IM_MODULE="ibus"
	export XMODIFIERS=@im="ibus"
fi

# -- rootless docker
if [[ "$OSTYPE" == "darwin"* ]]; then
	export DOCKER_HOST=unix:///var/run/docker.sock
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
fi

# -- Proxy
# export HTTP_PROXY="127.0.0.1:8080"
# export HTTPS_PROXY="$HTTP_PROXY"
# export FTP_PROXY="$HTTP_PROXY"
# export http_proxy="$HTTP_PROXY"
# export https_proxy="$HTTP_PROXY"
# export ftp_proxy="$HTTP_PROXY"

# -- DEFAULT
export QT_QPA_PLATFORMTHEME="qt5ct"
if [[ -n $SSH_CONNECTION ]]; then
  export VISUAL="vim"
  export EDITOR="vim"
else
  export VISUAL="nvim"
  export EDITOR="nvim"
fi
export BROWSER="pulse-browser"
export TERMINAL="kitty"
export READER="zathura"
export HTTPS="localhost:9050"
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/Downloads/youtube-9ab71578c563.json"
# vim/nvim as manpager

# if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# export MANPAGER="nvimpager"
	# export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
# fi

# -- Wine problem workaround
# - NOTE to self: this will prevent some (probably wine issue) games from launching
#   known workaround: install DXVK
# export MESA_GL_VERSION_OVERRIDE=4.4
# alternative workaround
export MESA_GL_VERSION_OVERRIDE=4.6
export MESA_GLSL_VERSION_OVERRIDE=460

# -- SUDO - Deactivated by default (using DOAS now)
# export SUDO_ASKPASS=/bin/rofi-askpass
# if [[ ! -z $DISPLAY ]]; then
#   export SUDO_ASKPASS="/bin/dmenu-askpass"
# fi

# cleaning up
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export SCRIPTS="$HOME/.scripts"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pyrc"

# vimrc (this will init/source ~/.config/vim/vimrc instead of ~/.vimrc)
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Path to oh-my-zsh installation
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_PLUGINS="$ZSH_CUSTOM/plugins"

# -- LF
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
