# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# MAIN TODO:
#   - Split into multiple files
#   - Variables file. For a central place to store variables.
#   - Utils echo with colors.
#   - Default help popup. So I can remember all the custom commands.

# ------ Variables ------
export GITHUB_USERNAME="TheDoomfire"
export GITHUB_DEFAULT_REPO_FOLDER="~/Documents/GitHub"

# ------ Utils ------

cprint() {
    local reset="\e[0m"
    local msg_type="info"
    local msg=""

    # Parse message type if specified
    # TODO: No one source of truth for this. Make one.
    if [[ "$1" =~ ^(success|error|warning|info|debug|highlight)$ ]]; then
        msg_type="$1"
        shift
    fi
    msg="$*"

    # 256-color palette definitions
    declare -A colors=(
        [success]="\e[38;5;82m"     # Bright green
        [error]="\e[1;38;5;196m"    # Bold vivid red
        [warning]="\e[38;5;226m"    # Bright yellow
        [info]="\e[38;5;39m"        # Deep sky blue
        [debug]="\e[38;5;247m"      # Medium gray
        [highlight]="\e[1;38;5;213m" # Bold bright pink
        [default]="\e[1;32m"        # Bold green
    )

    # Use default if no message
    [ -z "$msg" ] && msg="[No message]" && msg_type="warning"

    # Print with appropriate color
    printf "${colors[$msg_type]}%s${reset}\n" "$msg"
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
    # sources /etc/bash.bashrc).
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Tmuxifier for tmux
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier/layouts"

eval "$(tmuxifier init -)"
# Tmux projects
tmux-project() {
  local script="$HOME/.config/tmux-projects/$1.sh"
  if [ -f "$script" ]; then
    bash "$script"
  else
    cprint error "Project not found. Available projects:"
    ls -1 ~/.config/tmux-projects | sed 's/\.sh$//'
  fi
}

# ------ Command aliasing ------

# --- Git ---
# TODO: Test this!
# If your at home directory, perhaps ask for confirmation? If false then put at Documents/Github folder. Perhaps name the folder something else?

# Git clone shortcut function
gitclone() {

    if [ $# -ne 1 ]; then
        cprint info "Usage: gitclone <repo>"
        return 1
    fi

    local repo_input="$1"
    local repo_url

    # Check if input contains a slash (other user's repo)
    # TODO: Make it also check if it ends with .git?
    if [[ "$repo_input" == */* ]]; then
        repo_url="git@github.com:${repo_input}.git"
    else
        # Use personal repo
        repo_url="git@github.com:${GITHUB_USERNAME}/${repo_input}.git"
    fi

    cprint warning "Cloning $repo_url"
    git clone "$repo_url"
}


# Git Add-Commit-Push: gitacp [msg]
# gitacp() {
ga() {
  local message="${1:-misc}"
  git add . && git commit -m "$message" && git push
}

# gitpull() {
gp() {
    git fetch && \
    git status && \
    # TODO: If there are changes, ask for confirmation? Or maybe it already asks for it?
    git pull
    # Have this instead of git pull?
    # git merge @{u}    # Merge upstream branch (same as pull without fetch)
}

# TODO: Run at startup? With backup.
# TODO: TEST!
sysup() {
  cprint info "Updating system..."
  # Update APT packages and system
  sudo apt update && \
  sudo apt upgrade -y && \
  sudo apt full-upgrade -y && \
  sudo apt autoremove -y && \
  sudo apt autoclean

  # Update Flatpaks
  if command -v flatpak &> /dev/null; then
    # echo "Updating Flatpaks..."
    # cprint info "Updating Flatpaks..."
    cprint info "Updating Flatpaks..."
    flatpak update -y
  fi

  # # Update firmware (if fwupd is installed)
  # if command -v fwupdmgr &> /dev/null; then
  #   echo "Checking for firmware updates..."
  #   sudo fwupdmgr refresh
  #   sudo fwupdmgr update
  # fi

  cprint success "Finished updating"
}

reloading() {
  cprint info "Reloading bashrc..."
  source ~/.bashrc
}

tmux() {
    # Check if we're already inside tmux or arguments were provided
    if [ -n "$TMUX" ] || [ $# -gt 0 ]; then
        command tmux "$@"
        return
    fi

    # Try to attach to an existing session
    if command tmux has-session 2>/dev/null; then
        command tmux attach
    else
        # command tmux new-session
        command tmux
    fi
}

# --- TESTING ---
friend() {
  cprint "This is a test"
  cprint info "This is an info message"
  cprint success "This is a success message"
  cprint error "This is an error message"
  cprint warning "This is a warning message"
  cprint debug "This is a debug message"
  cprint highlight "This is a highlight message"
}

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

# TODO: add first? Not being used?
export EDITOR='nvim'
