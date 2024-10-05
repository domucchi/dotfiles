#!/bin/bash

# Set variables
SESSION_NAME="corplifting"
PROJECT_DIR="~/dev/job/corplifting/corplifting-frontend"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION_NAME -n "nvim"
    
    tmux send-keys -t $SESSION_NAME:nvim "cd $PROJECT_DIR" C-m
    tmux send-keys -t $SESSION_NAME:nvim "nvim ." C-m

    tmux new-window -t $SESSION_NAME -n "terminal"
    tmux send-keys -t $SESSION_NAME:terminal "cd $PROJECT_DIR" C-m
    tmux send-keys -t $SESSION_NAME:terminal "clear" C-m
    tmux send-keys -t $SESSION_NAME:terminal "yarn dev" C-m

    tmux split-window -h -t $SESSION_NAME:terminal
    tmux send-keys -t $SESSION_NAME:terminal "cd $PROJECT_DIR" C-m
    tmux send-keys -t $SESSION_NAME:terminal "clear" C-m

    tmux select-window -t $SESSION_NAME:nvim
fi

tmux attach -t $SESSION_NAME
