# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# colors
#autoload -U colors && colors

# MOTDs
pfetch
echo "--------------------------------------"
rateUSD
#python ~/Currency/USD2IDR/rate.py #PYTHON IS JUST TOO SLOW FOR TERMINAL
#sh ~/.scripts/motd.sh

setopt auto_cd # auto cd if directory
# highlight on tab (completion)
[ -f ~/.config/zsh/completion ] && source ~/.config/zsh/completion
# zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# fpath=(/usr/local/share/zsh-completions $fpath)
# autoload -U compinit && compinit
# zmodload -i zsh/complist
# zstyle ':completion:*' menu select

# Alias 
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases

# Theme
[ -f ~/.config/zsh/theme ] && source ~/.config/zsh/theme

# History in cache directory
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# vimrc
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# vi mode
set -o vi
bindkey -v
export KEYTIMEOUT=1
[ -f ~/.config/zsh/keybinds ] && source ~/.config/zsh/keybinds

# Plugins
ZSH_PLUGIN="$XDG_DATA_HOME/zsh/plugins"

# source $ZSH/oh-my-zsh.sh
# emulate -R zsh -c 'source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/fsh/fast-syntax-highlighting.plugin.zsh

