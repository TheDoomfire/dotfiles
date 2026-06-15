# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Sources:
# https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c 

# MAIN TODO:
#   - Split into multiple files. Inside of: ~/.config/shell/
#   - ALias file.
#   - Variables file.
#   - Utils echo with colors.
#   - Default help popup. So I can remember all the custom commands.

# Exit immediately if a command exits with a non-zero status
# set -e

# ENV_FILE="$HOME/.config/env.sh"
# if [ -f "$ENV_FILE" ]; then
#     source "$ENV_FILE"
# else
#     echo "Error: Central env file not found at $ENV_FILE" >&2
#     exit 1
# fi


# ------ Variables ------
# Find the variables in ~/.profile

# ------ Imports ------
source ~/.local/bin/newproject.sh
source ~/.local/bin/add_jellyfin_user.sh

# Load shared shell aliases
if [ -f "$HOME/.config/shell/aliases.sh" ]; then
    . "$HOME/.config/shell/aliases.sh"
fi

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

# TESTME: Add so it cd's to the directory of the unzipped file.
extract () {
    if [ -f $1 ] ; then
        local dir_before=$(find . -maxdepth 1 -type d)
        case $1 in
              *.tar.bz2)     tar xvjf $1    ;;
              *.tar.gz)      tar xvzf $1    ;;
              *.tar.xz)      tar xf $1      ;;
              *.bz2)         bunzip2 $1     ;;
              *.rar)         rar x $1       ;;
              *.gz)          gunzip $1      ;;
              *.tar)         tar xvf $1     ;;
              *.tbz2)        tar xvjf $1    ;;
              *.zip)         unzip $1       ;;
              *.Z)           uncompress $1  ;;
              *.7z)          7z x $1        ;;
              *)             echo "don't know how to extract '%1'..."
        esac
        local dir_after=$(find . -maxdepth 1 -type d)
        local new_dir=$(comm -13 <(echo "$dir_before" | sort) <(echo "$dir_after" | sort))
        if [ $(echo "$new_dir" | wc -l) -eq 1 ] && [ -d "$new_dir" ]; then
            cd "$new_dir" || return
        fi
    else
      echo "'$1' is not a valid file!"
    fi
}


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
export -f ga

# gitpull() {
gp() {
    git fetch && \
    git status && \
    # TODO: If there are changes, ask for confirmation? Or maybe it already asks for it?
    git pull --rebase
    # Have this instead of git pull?
    # git merge @{u}    # Merge upstream branch (same as pull without fetch)
}
export -f gp

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

  # Update Cinnamon
  cinnamon-spice-updater --update-all

  # # Update firmware (if fwupd is installed)
  # if command -v fwupdmgr &> /dev/null; then
  #   echo "Checking for firmware updates..."
  #   sudo fwupdmgr refresh
  #   sudo fwupdmgr update
  # fi

  cprint success "Finished updating"
}

sysclean() {
    echo "--- Cleaning APT packages ---"
    sudo apt-get clean
    sudo apt-get autoclean
    sudo apt-get autoremove -y

    echo "--- Cleaning Flatpak runtimes ---"
    flatpak uninstall --unused -y

    echo "--- Vacuuming Systemd logs to X MB ---"
    sudo journalctl --vacuum-size=200M

    echo "--- Clearing cache ---"
    rm -rf ~/.cache/thumbnails/*
    # TODO: Make so it only clears old files
    # rm -rf ~/.cache/ms-playwright/*

    echo "--- Checking for large log files in /var/log ---"
    # This lists the top 5 largest logs without deleting them
    sudo du -h /var/log | sort -rh | head -n 5

    echo "--- Checking biggest flatpak apps ---"
    du -h --max-depth=2 ~/.var/app | sort -hr

    echo "--- Current Disk Usage ---"
    df -h / | grep /

    cprint success "Finished cleaning!"
}

distroupdate() {
  sudo apt update && \
  sudo apt dist-upgrade -y && \
  sudo apt install mintupgrade && \
  sudo mintupgrade

  # After rebooting, run:
  # sudo apt remove mintupgrade
}

reloading() {
  # Asks for the password upfront if the timestamp has expired
  sudo -v
  cprint info "Reloading bashrc..."
  source ~/.bashrc
  cprint info "Reloading keyd..."
  sudo keyd reload
  cprint success "Finished reloading!"
}

# Create a combined audio sink. Check sound and enable it.
combinedaudio() {
  pactl load-module module-combine-sink sink_name=Combined_Audio
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

va() {
    if [ -f .venv/bin/activate ]; then
        source .venv/bin/activate
    elif [ -f venv/bin/activate ]; then
        source venv/bin/activate
    elif [ -f env/bin/activate ]; then
        source env/bin/activate
    else
        echo "No virtual environment (.venv, venv, or env) found in this directory."
    fi
}

# Show the current distribution
distribution ()
{
	local dtype
	# Assume unknown
	dtype="unknown"
	
	# First test against Fedora / RHEL / CentOS / generic Redhat derivative
	if [ -r /etc/rc.d/init.d/functions ]; then
		source /etc/rc.d/init.d/functions
		[ zz`type -t passed 2>/dev/null` == "zzfunction" ] && dtype="redhat"
	
	# Then test against SUSE (must be after Redhat,
	# I've seen rc.status on Ubuntu I think? TODO: Recheck that)
	elif [ -r /etc/rc.status ]; then
		source /etc/rc.status
		[ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ] && dtype="suse"
	
	# Then test against Debian, Ubuntu and friends
	elif [ -r /lib/lsb/init-functions ]; then
		source /lib/lsb/init-functions
		[ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ] && dtype="debian"
	
	# Then test against Gentoo
	elif [ -r /etc/init.d/functions.sh ]; then
		source /etc/init.d/functions.sh
		[ zz`type -t ebegin 2>/dev/null` == "zzfunction" ] && dtype="gentoo"
	
	# For Mandriva we currently just test if /etc/mandriva-release exists
	# and isn't empty (TODO: Find a better way :)
	elif [ -s /etc/mandriva-release ]; then
		dtype="mandriva"

	# For Slackware we currently just test if /etc/slackware-version exists
	elif [ -s /etc/slackware-version ]; then
		dtype="slackware"

	fi
	echo $dtype
}

ver() {
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		if [ -s /etc/redhat-release ]; then
			cat /etc/redhat-release && uname -a
		else
			cat /etc/issue && uname -a
		fi
	elif [ $dtype == "suse" ]; then
		cat /etc/SuSE-release
	elif [ $dtype == "debian" ]; then
		lsb_release -a
		# sudo cat /etc/issue && sudo cat /etc/issue.net && sudo cat /etc/lsb_release && sudo cat /etc/os-release # Linux Mint option 2
	elif [ $dtype == "gentoo" ]; then
		cat /etc/gentoo-release
	elif [ $dtype == "mandriva" ]; then
		cat /etc/mandriva-release
	elif [ $dtype == "slackware" ]; then
		cat /etc/slackware-version
	else
		if [ -s /etc/issue ]; then
			cat /etc/issue
		else
			echo "Error: Unknown distribution"
			exit 1
		fi
	fi
}


# FIXME: Use this for my installation script.
# TODO: Make it work with android?
check_device() {
    local chassis
    chassis=$(hostnamectl | grep "Chassis:" | awk '{print $2}')

    if [ "$chassis" = "laptop" ]; then
        echo "💻 Laptop detected!"
        
    elif [ "$chassis" = "desktop" ]; then
        echo "🖥️ Desktop detected!"
        
    else
        echo "Device type is: $chassis"
    fi
}

# Backups file or directory
bak() {
    local file="$1"
    cp -r "$file" "${file}.$(date +%Y%m%d).bak"
    echo "Backup created: ${file}.$(date +%Y%m%d).bak"
}

# Find the largest file in  current directory
duck() {
    du -cks * | sort -rn | head -n 11
}

# Find a file with a pattern in name:
function ff() { find $(pwd -P) -type f -iname '*'$*'*' -ls ; }
# Find a directory with a pattern in name:
function fd() { find $(pwd -P) -type d -iname '*'$*'*' -ls ; }

# Installs .EXE file in Bottles
winexec() {
    if [ $# -eq 0 ]; then
        echo "Usage: winexec <path-to-exe> [bottle-name]"
        echo "If bottle-name is not provided, will use 'Default'"
        return 1
    fi

    local exe_file="$1"
    local bottle_name="${2:-Gaming}"  # Use "Gaming" if no bottle specified
    local source_dir=$(dirname "$(realpath "$exe_file")")
    
    # Let the user choose where to move the directory
    echo "Where would you like to move the game directory? (Press Enter for current directory)"
    echo "TODO: Add a list of options?"
    # read -p "Target directory: " target_dir
    # target_dir=${target_dir:-$(pwd)}  # Use current directory if empty
    local target_dir="/mnt/linux_apps/Data/bottles/Gaming/drive_c/INSTALLATION_FILES"  
    
    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"
    
    # Move the entire directory containing the EXE
    local dir_name=$(basename "$source_dir")
    mv -v "$source_dir" "$target_dir/"
    
    # New path to the EXE
    local new_exe_path="$target_dir/$dir_name/$(basename "$exe_file")"
    
    # Run in Bottles
    flatpak run --command=bottles-cli com.usebottles.bottles run -b "$bottle_name" -e "$new_exe_path"
}

minecraft() {
  # TODO: maybe run the server in the background?
  # cd /mnt/movies_games/Servers/Minecraft/EmmasServer
  # java -Xms4G -Xmx4G -jar paper-*.jar --nogui 
  cd /mnt/linux_apps/Games/SKlauncher # TODO: Make this a variable?
  java -jar SKlauncher-*.jar &
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


export EDITOR='nvim'
# So I can use sudoedit
export SUDO_EDITOR='nvim'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
