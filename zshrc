# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt autocd extendedglob
setopt histignoredups
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/hirschmuelle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

fpath=($fpath "/home/hirschmuelle/.zfunctions")

# TYPEWRITTEN
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_SYMBOL=""

fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fdfind --type file --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi --color=dark --no-bold"

export EDITOR='nvim'

if [ -f ~/.zsh/aliases/aliases.zsh ]; then
	. ~/.zsh/aliases/aliases.zsh
fi

if [ -d ~/.pyenv ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
    eval "$(pyenv init -)"
fi
