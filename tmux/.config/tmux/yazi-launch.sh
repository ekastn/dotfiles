#!/usr/bin/env bash

set -eu

session_name="file"
home_dir="${HOME:?}"
home_dir_escaped="$(printf '%q' "$home_dir")"
shell_path="${SHELL:-/bin/sh}"
shell_escaped="$(printf '%q' "$shell_path")"
launch_command="cd $home_dir_escaped && yazi; exec $shell_escaped"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new-session -d -s "$session_name" -c "$home_dir"
	tmux set-option -t "$session_name" status off
fi

pane_target="$session_name:1.1"
pane_command="$(tmux display-message -t "$pane_target" -p '#{pane_current_command}' 2>/dev/null || true)"

if [ "$pane_command" != "yazi" ]; then
	tmux send-keys -t "$pane_target" C-c
	tmux send-keys -t "$pane_target" "$launch_command" C-m
fi

tmux switch-client -t "$session_name"
