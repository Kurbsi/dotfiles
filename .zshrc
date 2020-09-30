# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

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
alias us='setxkbmap us'
alias de='setxkbmap de'

###  ACCEPT FROM MENU IMMEDIATLY  ###
bindkey -M menuselect '^M' .accept-line

###  BMWRPP-BEGIN  ###
# Do not change content between BEGIN and END!
# This section is managed by a script.

if [ -f "/etc/bmwrpp-bootstrap/zshrc" ]; then
  . "/etc/bmwrpp-bootstrap/zshrc"
else
  echo "bmwrpp-bootstrap not installed, please remove BMWRPP section from /home/qxz0sxz/.zshrc"
fi
###  BMWRPP-END  ###

###  ENABLE FZF  ### 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###  HIDE user@hostname  ###
prompt_context(){}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hirschmuelle/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hirschmuelle/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hirschmuelle/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hirschmuelle/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export ROS_HOSTNAME=localhost
export ROS_MASTER_URL=http://localhost:11311

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
