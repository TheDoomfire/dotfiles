#!/bin/bash
SESSION="chooseinvesting"
PROJECT_PATH="$HOME/Documents/GitHub/chooseinvesting"
TEXT_EDITOR="nvim"
START_SERVER="pnpm start"

FIRST_WINDOW="editor"
SECOND_WINDOW="server"
SPLIT_ORIENTATION="h"  # 'h' for horizontal, 'v' for vertical

# Create new session and first window (for Neovim)
tmux new-session -d -s "$SESSION" -c "$PROJECT_PATH" -n "$FIRST_WINDOW"
tmux send-keys -t "$SESSION" "$TEXT_EDITOR" C-m

# Create second window with initial pane
tmux new-window -c "$PROJECT_PATH" -n "$SECOND_WINDOW"

# Split window horizontally (side-by-side)
tmux split-window -$SPLIT_ORIENTATION -c "$PROJECT_PATH"

# Run server in the right pane (pane 1)
tmux send-keys -t "$SESSION:$SECOND_WINDOW.1" "$START_SERVER" C-m

# Return to first window and attach session
tmux select-window -t "$SESSION:$FIRST_WINDOW"
tmux attach -t "$SESSION"
