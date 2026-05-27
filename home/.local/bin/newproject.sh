#!/bin/bash

# TODO:
# - Create the directory
# - Fork a template repo
# - Set up new tmux session
# - Fix windows

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

    read -p "Enter a name for your project: " PROJ_NAME

    # Sanitize the project name (lowercase, replace spaces with dashes)
    PROJ_NAME=$(echo "$PROJ_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    TARGET_DIR="$PROJECTS_DIR/$PROJ_NAME"

    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "❌ Error: A project named '$PROJ_NAME' already exists at $TARGET_DIR."
        exit 1
    fi

    case $CHOICE in
        1)
            echo "Creating Standard..."

            mkdir -p "$TARGET_DIR"
            echo "# $PROJ_NAME" > "$TARGET_DIR/README.md"

            git init -b main "$TARGET_DIR"
            git -C "$TARGET_DIR" add README.md
            git -C "$TARGET_DIR" commit -m "Initial commit"
            
            # gh repo create "$PROJ_NAME" --public --source="$TARGET_DIR" --remote=origin --push
            git -C "$TARGET_DIR" remote add origin "git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"
            git -C "$TARGET_DIR" push -u origin main

            SESSION_NAME=$(echo "$PROJ_NAME" | tr '.:' '_')

            echo "Setting up tmux session: $SESSION_NAME..."

            # Create a new detached session and set its starting directory to the project folder
            tmux new-session -d -s "$SESSION_NAME" -c "$TARGET_DIR"

            # Check if we are currently inside an active tmux session
            if [ -n "$TMUX" ]; then
                echo "Inside tmux. Switching client to new session..."
                tmux switch-client -t "$SESSION_NAME"
            else
                echo "Outside tmux. Attaching to new session..."
                tmux attach-session -t "$SESSION_NAME"
            fi

        ;;
        2)
            echo "Creating Python project structure..."
        ;;
        3)
            echo "Creating Web Development project structure..."
        ;;
        *)
            echo "❌ Invalid choice. Exiting."
            exit 1
            ;;
        esac
}
