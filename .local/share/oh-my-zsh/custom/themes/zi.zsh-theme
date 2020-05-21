# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b %u%c'

# Prompt
setopt PROMPT_SUBST
PROMPT='
$fg[white]${PWD/#$HOME/~} $fg[blue]${vcs_info_msg_0_}
$fg[green]$> %b'

#Autocomplete
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c5c8c6,bold,underline"

