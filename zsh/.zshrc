
setopt autocd extended_glob
setopt auto_param_slash
setopt histignoredups
setopt append_history inc_append_history share_history
setopt globdots


[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# The following lines were added by compinstall

# zstyle ':completion:*' completer _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/piahirschmuller/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/sh/aliases" ] && source "$XDG_CONFIG_HOME/sh/aliases"

# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


# set up prompt
NEWLINE=$'\n'
PROMPT="%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%p) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme

# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme
echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's $(print -P '%D{%_I:%M%p}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime | cut -c 7-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

