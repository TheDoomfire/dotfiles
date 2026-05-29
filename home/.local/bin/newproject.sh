#!/bin/bash

# TODO:
# - Create tmux windows for each project
# - Fix windows
# - Make so you can do something like this: "newproject python"

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


_create_and_switch_tmux() {

    # Create a new detached session and set its starting directory to the project folder
    tmux new-session -d -s "$SESSION_NAME" -c "$TARGET_DIR"

    # Double-check that the session actually exists before switching
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            # Inside tmux: Switch client, but redirect stderr to keep your terminal clean
            tmux switch-client -t "$SESSION_NAME"
        else
            # Outside tmux: Attach normally
            tmux attach-session -t "$SESSION_NAME"
        fi
    else
        echo "Error: Failed to create or find tmux session '$SESSION_NAME'."
        exit 1
    fi
}


_create_from_template() {
    local template="$1"

    mkdir -p "$TARGET_DIR"
    _generate_repo_from_template "$template"
    _create_and_switch_tmux
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

    PYTHON_TEMPLATE="python-template"
    WEBSITE_TEMPLATE="website-template"

    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "❌ Error: A project named '$PROJ_NAME' already exists at $TARGET_DIR."
        exit 1
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

            # JUST FOR TESTING
            open "$TARGET_DIR"

        ;;
        2)
            echo "Creating Python project structure..."
            _create_from_template "$PYTHON_TEMPLATE"
        ;;
        3)
            echo "Creating Web Development project structure..."
            _create_from_template "$WEBSITE_TEMPLATE"
        ;;
        *)
            echo "❌ Invalid choice. Exiting."
            exit 1
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
