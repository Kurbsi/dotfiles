# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hirschmuelle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

fpath=($fpath "/home/hirschmuelle/.zfunctions")

# Set typewritten ZSH as a prompt
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_SYMBOL=""

autoload -U promptinit; promptinit
prompt typewritten

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fdfind --type file --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi --color=dark --no-bold"

export EDITOR='nvim'

alias ls='ls --color=auto'
alias ll='ls -al'
alias v=$EDITOR
alias us='setxkbmap us'
alias de='setxkbmap de'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gco='git checkout'
alias gst='git status'

