#!/bin/bash

read -p "Do you want to run the tmux session setup script? (y/n): " response
if [[ "$response" != "y" && "$response" != "Y" ]]; then
  echo "Entering default tmux terminal"
  tmux
  exit 0
fi
SESSION_NAME="pilot"
unset TMUX

CURRENT_SESSION=$(tmux display-message -p '#S')

# Check if the current session is not the desired session and kill it
if [ "$CURRENT_SESSION" != "$SESSION_NAME" ]; then
  tmux kill-session -t "$CURRENT_SESSION"
fi

# Start a new tmux session
tmux new-session -d -s $SESSION_NAME -n 'processes' -c /Users/andrewmorrison/Desktop/workspace/RailsProjects/pilot/pilot-backend
tmux send-keys -t $SESSION_NAME:0.0 'rs' C-m

# Set up the first window with the desired layout
tmux split-pane -h -t $SESSION_NAME:0 -c /Users/andrewmorrison/Desktop/workspace/RailsProjects/pilot/pilot-frontend
tmux send-keys -t $SESSION_NAME:0.1 'yarn dev' C-m
tmux select-pane -t $SESSION_NAME:0.0
tmux split-window -v -t $SESSION_NAME:0 -c /Users/andrewmorrison/Desktop/workspace/RailsProjects/pilot/pilot-backend
# This becomes the new pane 1 when it is split vertically
tmux send-keys -t $SESSION_NAME:0.1 'be sidekiq' C-m

# Create additional windows with different paths
tmux new-window -t $SESSION_NAME:1 -n 'backend' -c /Users/andrewmorrison/Desktop/workspace/RailsProjects/pilot/pilot-backend
tmux new-window -t $SESSION_NAME:2 -n 'frontend' -c /Users/andrewmorrison/Desktop/workspace/RailsProjects/pilot/pilot-frontend
tmux new-window -t $SESSION_NAME:3 -n 'notes' -c /Users/andrewmorrison/Desktop/workspace/obsidian
tmux select-window -t $SESSION_NAME:1

# Attach to the session
tmux attach-session -t $SESSION_NAME

