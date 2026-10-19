#!/usr/bin/env bash

set -eu

session_name="${1:?usage: $0 <session> <command> [process-name] [start-dir]}"
launch_cmd="${2:?usage: $0 <session> <command> [process-name] [start-dir]}"
process_name="${3:-${launch_cmd%% *}}"
start_dir_arg="${4:-}"

if [ "$start_dir_arg" != "" ]; then
	start_dir="$start_dir_arg"
else
	start_dir="$(tmux display-message -p '#{pane_current_path}')"
fi

start_dir_escaped="$(printf '%q' "$start_dir")"
shell_path="${SHELL:-/bin/sh}"
shell_escaped="$(printf '%q' "$shell_path")"
launch_command="cd $start_dir_escaped && $launch_cmd; exec $shell_escaped"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new-session -d -s "$session_name" -c "$start_dir"
	sleep 0.5
fi

pane_target="$session_name:1.1"
pane_command="$(tmux display-message -t "$pane_target" -p '#{pane_current_command}' 2>/dev/null || true)"

if [ "$pane_command" != "$process_name" ]; then
	tmux send-keys -t "$pane_target" C-c
	sleep 0.3
	tmux send-keys -t "$pane_target" "$launch_command" C-m
fi

tmux switch-client -t "$session_name"
