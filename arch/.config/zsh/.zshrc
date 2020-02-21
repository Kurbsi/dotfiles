# Path to your oh-my-zsh installation.
export ZSH="/home/korbinian/.oh-my-zsh"

# Set history specific vars
HISTFILE="$HOME/.cache/history"
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Set name of the theme to load
ZSH_THEME="arrow"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	colorize
	alias-finder)

setopt autolist		# Display completion candidates immediatly
setopt histignoredups	# Ignore duplicate commands for history
setopt nolistbeep	# No bell on ambigous completion

source $ZSH/oh-my-zsh.sh

# User configuration
bindkey -v
export KEYTIMEOUT=1

bindkey '^R' history-incremental-search-backward

function zle-line-init zle-keymap-select {
	VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}%{$fg[yellow]%}%p $(git_prompt_info)%{$reset_color%} $EPS1"
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M menuselect '^M' .accept-line

