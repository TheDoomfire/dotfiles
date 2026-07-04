#!/bin/bash

# TODO:
# - Make so you can do something like this: "newproject python"
# - Add: newpython
# - Add: newwebsite


declare -Ag git_template
declare -Ag tmux_template

WEBSITE_NAME="website"
PYTHON_NAME="python"
DEFAULT_NAME="default"

declare -Ag template_setup_function=(
    ["$WEBSITE_NAME"]=_setup_website
    ["$PYTHON_NAME"]=_setup_python_project
)

git_template[$WEBSITE_NAME]="website-template"
tmux_template[$WEBSITE_NAME]="website" # TODO: use WEBSITE_NAME?

git_template[$PYTHON_NAME]="python-template"
tmux_template[$PYTHON_NAME]="python-template"

# git_template[$DEFAULT_NAME]="default-template"
tmux_template[$DEFAULT_NAME]="default"

# NOT IN USE YET
_create_repo_and_init() {
    # If a template is specified
    if [ -n "${1:-}" ]; then
        _generate_repo_from_template "$1"
    else
        _init_and_create_repo
    fi
}


_init_and_create_repo() {

    if [ ! -d "$TARGET_DIR/.git" ]; then
        git init -b main "$TARGET_DIR"
    else
        echo "Git repository already initialized."
    fi

    git -C "$TARGET_DIR" add .

    if ! git -C "$TARGET_DIR" diff-index --quiet HEAD -- 2>/dev/null; then
        git -C "$TARGET_DIR" commit -m "Initial commit"
    else
        echo "Nothing to commit, working tree clean."
    fi

    if ! gh repo view "$PROJ_NAME" &>/dev/null; then
        echo "Creating github repo."
        # gh repo create "$PROJ_NAME" --private --source="$TARGET_DIR" --remote=origin --push
        gh repo create "$PROJ_NAME" "$VISIBILITY_FLAG" --source="$TARGET_DIR" --remote=origin --push
    else
        echo "A repository named '$PROJ_NAME' already exists on your GitHub account."
    fi

}


_generate_repo_from_template() {
    local template="$1"

    # gh repo create "$PROJ_NAME" --private --template="$GITHUB_USERNAME/$template"
    gh repo create "$PROJ_NAME" "$VISIBILITY_FLAG" --template="$GITHUB_USERNAME/$template"

    # TODO: Use my custom: gitclone() function instead of this?
    git clone "git@github.com:$GITHUB_USERNAME/$PROJ_NAME.git" "$TARGET_DIR"

}


_create_from_template() {
    local template="$1"

    git=${git_template[$template]}
    tmux=${tmux_template[$template]}

    mkdir -p "$TARGET_DIR"
    _generate_repo_from_template "$git"

    # TODO: Test if this works!!
    # Run template‑specific setup if one exists
    if [[ -n ${template_setup_function[$template]} ]]; then
        "${template_setup_function[$template]}"
    fi

    _create_and_switch_tmux "$tmux"
}


_create_and_switch_tmux() {
    local template="${1:-"default"}"

    # Create a new detached session and set its starting directory to the project folder
    # tmux new-session -d -s "$SESSION_NAME" -c "$TARGET_DIR"
    
    # # tmuxp load ~/.tmuxp/"$template".yaml -a project_name="$SESSION_NAME" -a project_path="$TARGET_DIR"
    # export TMUX_SESSION_NAME="$SESSION_NAME"
    # export TMUX_PROJECT_PATH="$TARGET_DIR"


    # TODO: If no template is specified, use the default one
    TMUX_SESSION_NAME="$SESSION_NAME" START_DIR="$TARGET_DIR" \
    tmuxp load ~/.tmuxp/"$template".yaml

    # tmuxp load ~/.tmuxp/$template.yaml
    # name="$SESSION_NAME" start_dir="$TARGET_DIR" tmuxp load ~/.tmuxp/"$template".yaml
    # SESSION_NAME="$SESSION_NAME" TARGET_DIR="$TARGET_DIR" tmuxp load ~/.tmuxp/"$template".yaml


    # # Double-check that the session actually exists before switching
    # if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    #     if [ -n "$TMUX" ]; then
    #         # Inside tmux: Switch client, but redirect stderr to keep your terminal clean
    #         tmux switch-client -t "$SESSION_NAME"
    #     else
    #         # Outside tmux: Attach normally
    #         tmux attach-session -t "$SESSION_NAME"
    #     fi
    # else
    #     echo "Error: Failed to create or find tmux session '$SESSION_NAME'."
    #     exit 1
    # fi
}


_setup_website() {
    cd "$TARGET_DIR" || return 1
    pnpm install
}

_setup_python_project() {
    cd "$TARGET_DIR" || return 1
    uv sync
}


newproject() {
    echo "========================================"
    echo "      CREATE A NEW PROJECT WIZARD       "
    echo "========================================"
    echo "Select a template type:"
    echo "1) Standard"
    echo "2) Python"
    echo "3) Website"
    echo "========================================"

    read -p "Enter choice (1-2): " CHOICE
    echo "Choice: $CHOICE"
    read -p "Enter a name for your project: " PROJ_NAME
    echo "Name: $PROJ_NAME"
    read -p "Make repository private? (y/n): " prompt_response

    if [[ "$prompt_response" =~ ^[Yy]$ ]]; then
        VISIBILITY_FLAG="--private"
        echo "Private: True"
    else
        VISIBILITY_FLAG="--public"
        echo "Private: False"
    fi

    read -p "Does everything look correct? (y/n): " final_confirm

    if [[ ! "$final_confirm" =~ ^[Yy]$ ]]; then
        echo "❌ Aborting operation. No changes were made."

        # Check if the script is being sourced or run directly
        if [ "$0" = "$BASH_SOURCE" ]; then
            exit 0   # Safe to exit: run directly as a script
        else
            return 0 # Safe to return: script was sourced inside an active shell
        fi
    fi

    # Sanitize the project name (lowercase, replace spaces with dashes)
    PROJ_NAME=$(echo "$PROJ_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    TARGET_DIR="$PROJECTS_DIR/$PROJ_NAME"
    SESSION_NAME=$(echo "$PROJ_NAME" | tr '.:' '_')

    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "❌ Error: A project named '$PROJ_NAME' already exists at $TARGET_DIR."
        return 1 # exit 1 does turn off the entire terminal
    # else
    #     mkdir -p "$TARGET_DIR"
    fi

    case $CHOICE in
        1)
            echo "Creating Standard..."

            mkdir -p "$TARGET_DIR"
            echo "# $PROJ_NAME" > "$TARGET_DIR/README.md"
            _init_and_create_repo
            _create_and_switch_tmux
            
            # # JUST FOR TESTING
            # open "$TARGET_DIR"

        ;;
        2)
            echo "Creating Python project structure..."
            _create_from_template "$PYTHON_NAME"
        ;;
        3)
            echo "Creating Web Development project structure..."
            _create_from_template "$WEBSITE_NAME"

        ;;
        *)
            echo "❌ Invalid choice. Exiting."
            return 1
            ;;
        esac
}

alias pnew="newproject"
alias projectnew="newproject"
alias generateproject="newproject"
alias createproject="newproject"

# alias newpy="newproject python"
# alias newastro="newproject astro"
# alias newscraping="newproject scraper"
