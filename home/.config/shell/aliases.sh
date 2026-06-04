#!/bin/bash

# Custom aliases
# alias mux=tmuxinator
alias mux=tmuxifier
alias tload="tmuxifier load-session"
alias gs='git status'
# alias reload='source ~/.bashrc' 
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias home='cd ~'
alias c='clear'
alias cls='clear'
alias sv='source .venv/bin/activate'
alias pipfreeze='source pip freeze > requirements.txt'
alias to_clip='xclip -selection clipboard'
alias myip='curl ifconfig.me; echo ""'
alias df="df -kTh"
alias desk="cd ~/Desktop"
alias down="cd ~/Downloads"
alias bashrc="$EDITOR ~/.bashrc ; reload"

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
