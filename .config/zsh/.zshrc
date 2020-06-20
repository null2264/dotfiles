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

# Theme
[ -f ~/.config/zsh/theme ] && source ~/.config/zsh/theme

# History in cache directory
HISTFILE=~/.cache/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Theme
#ZSH_THEME="zi"
# ZSH_THEME="spaceship"
# configuration
# SPACESHIP_CHAR_SYMBOL="$> "
# SPACESHIP_GIT_BRANCH_COLOR="magenta"
# SPACESHIP_GIT_PREFIX=""
# SPACESHIP_GIT_SUFFIX=""
# SPACESHIP_GIT_BRANCH_SUFFIX=""
# SPACESHIP_GIT_STATUS_PREFIX=' '
# SPACESHIP_GIT_STATUS_SUFFIX=''
# SPACESHIP_EXEC_TIME_SHOW=false
# SPACESHIP_DIR_COLOR="blue"
# SPACESHIP_DIR_TRUNC_PREFIX="~/"
# SPACESHIP_PYENV_SYMBOL=""

# vimrc
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# vi mode
#bindkey -v
#export KEYTIMEOUT=1

# Plugins
ZSH_PLUGIN="$XDG_DATA_HOME/zsh/plugins"
#plugins=(
#git
#fast-syntax-highlighting
##zsh-syntax-highlighting
#zsh-autosuggestions
#)

# source $ZSH/oh-my-zsh.sh
# Binds/Alias (Preventing from reverted to the original one)
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases
[ -f ~/.config/zsh/keybinds ] && source ~/.config/zsh/keybinds
# emulate -R zsh -c 'source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#source $ZSH_CUSTOM/plugins/fsh/fast-syntax-highlighting.plugin.zsh

