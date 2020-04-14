# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# colors
autoload -U colors && colors

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# MOTDs
pfetch

# Path
PATH="$HOME/.local/bin${PATH:+:${PATH}}"

# Path to your oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export PLUGINS="$XDG_DATA_HOME/zsh/plugins"

# History in cache directory
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Theme
#ZSH_THEME="zi"
ZSH_THEME="spaceship"
# configuration
SPACESHIP_CHAR_SYMBOL="$> "
SPACESHIP_GIT_BRANCH_COLOR="magenta"
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_SUFFIX=""
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_TRUNC_PREFIX="~/"
SPACESHIP_PYENV_SYMBOL=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#60C0FF,bold,underline"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="ls *,cd *"

# Completion (from Luke Smith)
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Default
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export BROWSER='firefox'
export TERMINAL='urxvt'

#vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# vi mode
#bindkey -v
#export KEYTIMEOUT=1

# Plugins
plugins=(
git
fast-syntax-highlighting
#zsh-syntax-highlighting
zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
#source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/fsh/fast-syntax-highlighting.plugin.zsh
#binding/alias
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases
[ -f ~/.config/zsh/keybinds ] && source ~/.config/zsh/keybinds
source $HOME/.zprofile
