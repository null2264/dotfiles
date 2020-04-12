# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# MOTDs
pfetch

# Path
PATH="$HOME/.local/bin${PATH:+:${PATH}}"

# Path to your oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
export ZSH_CUSTOM="$ZSH"

# History in cache directory
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Theme
ZSH_THEME="spaceship"

# Plugins
plugins=(
git
)

source $ZSH/oh-my-zsh.sh

# Default
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
export BROWSER='firefox'
export TERMINAL='urxvt'

#Askpass
export SUDO_ASKPASS=/usr/bin/rofi-askpass

#vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases

