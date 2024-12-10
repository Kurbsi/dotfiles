alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -="cd -"

alias ls='ls --color=auto'
alias ll='ls -alh'

alias v='nvim'

alias us='setxkbmap us'
alias de='setxkbmap de'

alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gst='git status --short'
alias gb='git branch'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias weather='curl wttr.in/munich'
alias cw='date +%V'

alias xclip='xclip -sel c'

alias soa='cd $HOME/dev/soa-com-middleware'
alias soa-clean='rm -rf build build-generated'
alias soa-exec='docker compose exec motionwise-lean'
alias soa-pipeline='soa-exec ./ci/pipeline_hook.sh'
alias soa-sh='docker compose exec -it motionwise-lean /bin/bash'

soa-build() {
    soa-exec ./build.sh linux-host "$1" && "$HOME/.local/bin/compile-commands-at-home"
}
