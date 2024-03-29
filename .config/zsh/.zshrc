# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# colors
#autoload -U colors && colors

# ----- MOTDs
# pfetch
# echo "--------------------------------------"
# rateUSD | sed 's/^/ /g'

setopt auto_cd # auto cd if directory

# highlight on tab (completion)
[ -f ~/.config/zsh/completion ] && source ~/.config/zsh/completion
# zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# fpath=(/usr/local/share/zsh-completions $fpath)
# autoload -U compinit && compinit -u
# zmodload -i zsh/complist
# zstyle ':completion:*' menu select

# Alias 
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases

# Theme
[ -f ~/.config/zsh/theme ] && source ~/.config/zsh/theme

# opam
test -r /home/ziro/.opam/opam-init/init.zsh && . /home/ziro/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# History in cache directory
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# vi mode
set -o vi
bindkey -v
export KEYTIMEOUT=1

# Keybindings
[ -f ~/.config/zsh/keybinds ] && source ~/.config/zsh/keybinds

# ----- Plugins
ZSH_PLUGINS="$XDG_DATA_HOME/zsh/plugins"

# source $ZSH/oh-my-zsh.sh
# emulate -R zsh -c 'source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
# eval $(thefuck --alias) # thefuck - fix your stupid typo :)
source $ZSH_PLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/fsh/fast-syntax-highlighting.plugin.zsh

if [[ "$OSTYPE" == "darwin"* ]]; then
	test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"


	#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
	export SDKMAN_DIR="$HOME/.sdkman"
	[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
export PATH=$PATH:/home/ziro/.spicetify

# bun completions
[ -s "/home/ziro/.bun/_bun" ] && source "/home/ziro/.bun/_bun"
