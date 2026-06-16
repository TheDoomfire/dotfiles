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
# alias myip='curl ifconfig.me; echo ""'
alias myip='echo -n "Local:  " && ip route get 1 | awk "{print \$7}" && echo -n "Public: " && curl -s ifconfig.me && echo ""'
alias df="df -kTh"
alias desk="cd ~/Desktop"
alias down="cd ~/Downloads"
alias movies="cd /mnt/movies_games/Videos/Movies"
alias gmovies="open /mnt/movies_games/Videos/Movies"
alias series="cd /mnt/movies_games/Videos/Series"
alias gseries="open /mnt/movies_games/Videos/Series"
alias books="cd /mnt/movies_games/Documents/Books"
alias gbooks="open /mnt/movies_games/Documents/Books"
alias bashrc="$EDITOR ~/.bashrc ; reload"
alias sshkeygen="ssh-keygen -t ed25519 -f ~/.ssh/FILENAME -C 'A COMMENT'"
alias lab-on="docker compose -f /mnt/linux_apps/Documents/GitHub/homelab/media/compose.yaml up -d"
alias lab-off="docker compose -f /mnt/linux_apps/Documents/GitHub/homelab/media/compose.yaml down"

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
