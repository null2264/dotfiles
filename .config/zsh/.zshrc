# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# colors
#autoload -U colors && colors

# ----- MOTDs
# pfetch
# echo "--------------------------------------"
# rateUSD | sed 's/^/ /g'

setopt auto_cd # auto cd if directory
__CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}

# highlight on tab (completion)
[ -f $__CONFIG_DIR/zsh/include/completion ] && source $__CONFIG_DIR/zsh/include/completion
# zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# fpath=(/usr/local/share/zsh-completions $fpath)
# autoload -U compinit && compinit -u
# zmodload -i zsh/complist
# zstyle ':completion:*' menu select

# Alias 
[ -f $__CONFIG_DIR/zsh/include/aliases ] && source $__CONFIG_DIR/zsh/include/aliases

# Theme
[ -f $__CONFIG_DIR/zsh/include/theme ] && source $__CONFIG_DIR/zsh/include/theme

# opam
test -r /home/ziro/.opam/opam-init/init.zsh && . /home/ziro/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# History in cache directory
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# vi mode
set -o vi
bindkey -M viins "^?" backward-delete-char  # fix backspace after switching from visual mode
export KEYTIMEOUT=1

# Keybindings
[ -f $__CONFIG_DIR/zsh/include/keybinds ] && source $__CONFIG_DIR/zsh/include/keybinds

# [[ Plugins
ZSH_PLUGINS="$XDG_DATA_HOME/zsh/plugins"

[ ! -d $ZSH_PLUGINS ] && mkdir -p $ZSH_PLUGINS

# >> INSTALL: #!/bin/zsh
# cd $ZSH_PLUGINS && git clone <plugin repo git url>
# << INSTALL

# >> ENABLED: silently fail if not installed
source $ZSH_PLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null # https://github.com/zdharma-continuum/fast-syntax-highlighting
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null # https://github.com/zsh-users/zsh-autosuggestions
#source $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2>/dev/null # https://github.com/zsh-users/zsh-syntax-highlighting
# << ENABLED

# ]] Plugins

# bun completions
[ -s "/home/ziro/.bun/_bun" ] && source "/home/ziro/.bun/_bun"

pyenv --version >/dev/null 2>/dev/null && {
	eval "$(pyenv init -)";
	eval "$(pyenv virtualenv-init -)";
}

case "$OSTYPE" in
	"darwin"* )
		test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"

		# pnpm
		export PNPM_HOME="/Users/ziro/.local/share/pnpm"
		case ":$PATH:" in
		  *":$PNPM_HOME:"*) ;;
		  *) export PATH="$PNPM_HOME:$PATH" ;;
		esac
		# pnpm end

		export PATH=$PATH:/Users/ziro/.spicetify

		#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
		export SDKMAN_DIR="$HOME/.sdkman"
		[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
		;;
esac
