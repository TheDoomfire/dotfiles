#!/bin/bash

# BASE_DIR="$HOME/Documents/projects"
BASE_DIR="$HOME/Documents/GitHub"

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
    echo "1) Python Dev Layout"
    echo "2) Web Dev Layout"
    echo "========================================"
    read -p "Enter choice (1-2): " CHOICE

    read -p "Enter a name for your project: " PROJ_NAME

    # Sanitize the project name (lowercase, replace spaces with dashes)
    PROJ_NAME=$(echo "$PROJ_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    TARGET_DIR="$BASE_DIR/$PROJ_NAME"

    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "❌ Error: A project named '$PROJ_NAME' already exists at $TARGET_DIR."
        exit 1
    fi

    case $CHOICE in
        1)
            echo "Creating Python project structure..."
        ;;
        2)
            echo "Creating Web Development project structure..."
        ;;
        *)
            echo "❌ Invalid choice. Exiting."
            exit 1
            ;;
        esac
}
