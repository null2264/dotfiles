#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1 with Git Indicator
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " [${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function _myps1() {
	local __name_hostname="\[$(tput bold)\]\[\033[38;5;45m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\]"
	local __space="\[$(tput sgr0)\]"
	local __git_branch='`parse_git_branch`'
	local __git_status='`parse_git_dirty`'
	local __ps1end="\[\033[00m\]$> $__space"
	local __dir="\[\033[38;5;7m\]\w"
	PS1=" $__dir$__git_branch $__ps1end"
}
_myps1

#Fetch, just for eyecandy
pfetch

#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

#extract script from DistroTube's dotfiles repo
ex ()
{
	if [ -f $1 ] ; then
			case $1 in
	      		*.tar.bz2)   tar xjf $1   ;;
	      		*.tar.gz)    tar xzf $1   ;;
	      		*.bz2)       bunzip2 $1   ;;
	      		*.rar)       unrar x $1     ;;
	      		*.gz)        gunzip $1    ;;
	      		*.tar)       tar xf $1    ;;
      			*.tbz2)      tar xjf $1   ;;
      			*.tgz)       tar xzf $1   ;;
      			*.zip)       unzip $1     ;;
      			*.Z)         uncompress $1;;
      			*.7z)        7z x $1      ;;
     			*)           echo "'$1' cannot be extracted via ex()" ;;
    			esac
	else
		echo "'$1' is not a valid file"
	fi
}

#Default
export EDITOR="nvim"
export BROWSER='firefox'
export TERMINAL='urxvt'

#Askpass
export SUDO_ASKPASS=/usr/bin/rofi-askpass

#XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

#vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

#Aliases
alias nano='nvim'
alias vim='nvim'
alias vi='nvim'
alias weather='curl wttr.in'
alias pac='sudo pacman'
alias pacS='sudo pacman -S'
alias pacSy='sudo pacman -Sy'
alias pacSyu='sudo pacman -Syu'
alias pacR='sudo pacman -R'
alias aur='yay'
alias aurS='yay -S'
alias aurSy='yay -Sy'
alias aurSyu='yay -Syu'
alias aurR='yay -R'
alias spotifyrip='spotify-ripper -u palembani@gmail.com'
alias xreload='xrdb ~/.Xresources'
alias ytv='youtube-viewer'
alias yt='youtube-dl'
alias ytaudio='youtube-dl -x --audio-format'
alias gravit='~/my\ Files/Gravit/GravitDesigner.AppImage'
alias redoom='~/doom refresh'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias rvim='sudo vim'
alias py='python'
alias ps2c='sudo sh $HOME/.scripts/ps2c'
alias cls='clear'
alias classprop='xprop WM_CLASS'
alias storagelist='lsblk -f'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='exa --color=always'
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -a'
alias cfvim='vim $XDG_CONFIG_HOME/vim/vimrc'
alias cfbash='vim $HOME/.bashrc'
alias cfzsh='vim $HOME/.zshrc'
alias cfbsp='vim $XDG_CONFIG_HOME/bspwm/bspwmrc'
alias cfpoly='vim $XDG_CONFIG_HOME/polybar/config'
alias cfkeys='vim $XDG_CONFIG_HOME/sxhkd/sxhkdrc'
alias htop='htop -t'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

#Git Aliases
alias gs='git status'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
