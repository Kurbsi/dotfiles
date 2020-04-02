# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hirschmuelle/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	colored-man-pages
	colorize
	git
	vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration
alias v=$EDITOR

###  ACCEPT FROM MENU IMMEDIATLY  ###
bindkey -M menuselect '^M' .accept-line

###  BMWRPP-BEGIN  ###
# Do not change content between BEGIN and END!
# This section is managed by a script.

if [ -f "/etc/bmwrpp-bootstrap/zshrc" ]; then
  . "/etc/bmwrpp-bootstrap/zshrc"
else
  echo "bmwrpp-bootstrap not installed, please remove BMWRPP section from /home/hirschmuelle/.zshrc"
fi
###  BMWRPP-END  ###

###  ENABLE FZF  ### 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###  HIDE user@hostname  ###
prompt_context(){}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
