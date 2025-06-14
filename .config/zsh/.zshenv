#!/bin/zsh
# -- XDG
export ZI_IS_DARWIN=0
case "$OSTYPE" in
    "darwin"*)
        ZI_IS_DARWIN=1
        ;;
    "linux-gnu")
        ZI_IS_DARWIN=0
        ;;
    *)
        >&2 echo "System '$OSTYPE' is not supported, assuming it's a Linux system..."
	;;
esac
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export ZI_BINARY_HOME="$HOME/.local/bin"
export ZI_SCRIPTS_HOME="$ZI_BINARY_HOME/scripts"
export ZI_ANDROID_SDK_VER="35.0.0"

[ -f "$XDG_CONFIG_HOME/zsh/include/dotfiles" ] && {
	source "$XDG_CONFIG_HOME/zsh/include/dotfiles"
	export ZI_NIX_FLAKE="$ZI_DOTFILES/nix"
}

if [ $ZI_IS_DARWIN = 1 ]; then
	export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
	export CHROME_EXECUTABLE=/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser
	export REPO_OS_OVERRIDE="macosx"

	# Android stuff
	export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
	export ANDROID_PREFS_ROOT="$HOME/Library/Android/sdk"
	export ANDROID_HOME="$HOME/Library/Android/sdk"
else
	# Use 'archlinux-java' to set java version
	[ -f "/etc/arch-release" ] && \
	export JAVA_HOME="/usr/lib/jvm/default" || \
	export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"

	# >> Android stuff
	#
	# TIPS:
	# You need to choose between android-sdk-cmdline-tools-latest (AUR) or
	# Android Studio (or IDEA with Android plugin if you're a KMP
	# developer), as they're mutually exclusive and will break each other.
	#
	# If you need CLI access while using Android Studio method, install
	# cmdline-tools (and optionally, build-tools). By installing
	# cmdline-tools, you should now be able to manager Android SDK outside
	# of Android Studio. (You can even install build-tools without Android
	# Studio using 'sdkmanager')
	#
	# Another way to do it (for future proof, maybe you don't need Android
	# Studio now, but may need it in the future) is by installing
	# 'android-sdk-cmdline-tools-latest' from AUR, copy 'cmdline-tools' to
	# '~/.config/android/Android/Sdk', then finally uninstall
	# 'android-sdk-cmdline-tools-latest'.
	#
	# Lastly, run: 'sdkmanager --install "build-tools;$ZI_ANDROID_SDK_VER"'
	export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-${XDG_CONFIG_HOME:-$HOME/.config}/android/Android/Sdk}"
	export ANDROID_HOME="${ANDROID_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/android/Android/Sdk}"
	export ANDROID_PREFS_ROOT="$ANDROID_HOME"
	# << Android stuff
fi
export ANDROID_AVD_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android/.android/avd"
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
export PATH="${PATH}:${ANDROID_HOME}/build-tools/$ZI_ANDROID_SDK_VER"

# -- Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# -- Python
if [ $ZI_IS_DARWIN = 1 ]; then
	export PYTHONNOUSERSITE=1
fi

# -- Path
export BUN_INSTALL="$HOME/.bun"
if [ $ZI_IS_DARWIN = 1 ]; then
	export PYTHONPATH="$HOME/Library/Python/3.10/lib:$PYTHONPATH"
	LOCAL_PATH=$(du -d1 "$ZI_BINARY_HOME" | cut -f2 > /tmp/ENV_PATH && paste -sd ':' /tmp/ENV_PATH)
	LOCAL_PATH="/run/current-system/sw/bin:/usr/local/bin:$HOME/.rd/bin:$HOME/Library/Python/3.10/bin:$LOCAL_PATH"
else
	LOCAL_PATH=$(du "$ZI_BINARY_HOME" -d 1 | cut -f2 | paste -sd ':')
	LOCAL_PATH="/run/system-manager/sw/bin:$LOCAL_PATH"
fi
PATH="$HOME/.rokit/bin:$BUN_INSTALL/bin:$HOME/.pub-cache/bin:$HOME/.local/share/go/bin:$ANDROID_AVD_HOME:$HOME/.local/share/npm/bin:$HOME/.local/share/cargo/bin:$ZI_SCRIPTS_HOME/bin:$LOCAL_PATH${PATH:+:${PATH}}"
# export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library

# -- IBus stuff (IME)
# if [[ "$XDG_SESSION_TYPE" != "wayland" ]]; then
# 	export GTK_IM_MODULE="ibus"
# 	export QT_IM_MODULE="ibus"
# 	export GLFW_IM_MODULE="ibus"
# 	export XMODIFIERS=@im="ibus"
# else
# 	unset GTK_IM_MODULE
# 	unset QT_IM_MODULE
# 	unset GLFW_IM_MODULE
# 	unset XMODIFIERS
# fi

# -- rootless docker
if [ $ZI_IS_DARWIN = 1 ]; then
	export DOCKER_HOST=unix:///var/run/docker.sock
else
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
export BROWSER="zen-browser"
export TERMINAL="kitty"
export READER="zathura"
export HTTPS="localhost:9050"
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/Downloads/youtube-9ab71578c563.json"
# vim/nvim as manpager

# if [ $ZI_IS_DARWIN = 0 ]; then
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

# >> [XDG]
# Clean up
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
# export SCRIPTS="$HOME/.scripts"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
# export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pyrc"
if [ $ZI_IS_DARWIN = 0 ]; then
	export GNUPGHOME="$XDG_DATA_HOME/gnupg"
	unset SSH_AGENT_PID
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
fi
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export PKG_CACHE_PATH="$XDG_DATA_HOME/pkg-cache"
export NVM_DIR="$XDG_DATA_HOME/nvm"

# Fixes
[ -d $XDG_CONFIG_HOME ] || mkdir -p $XDG_CONFIG_HOME
[ -f $WGETRC ] || touch $WGETRC  # wget will fail to run without this file
if [ $ZI_IS_DARWIN = 0 ]; then
	[ -d $GNUPGHOME ] || mkdir -p $GNUPGHOME
fi
[ -d $WAKATIME_HOME ] || mkdir -p $WAKATIME_HOME
[ -d $WINEPREFIX ] || mkdir -p $WINEPREFIX

[ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
# << [XDG]

# zsh
export ZSH_PLUGINS="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/include/lf ] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/include/lf
