#!/usr/bin/env bash

set -eu

tmux_option_or_fallback() {
	local option_value
	option_value="$(tmux show-option -gqv "$1")"
	if [ -z "$option_value" ]; then
		option_value="$2"
	fi
	echo "$option_value"
}

tmux_version() {
	tmux -V | cut -d ' ' -f 2
}

is_tmux_version_supported() {
	local version
	IFS='.' read -r -a version < <(tmux_version)

	if [ "${version[0]}" -gt 3 ]; then
		return 0
	fi

	if [ "${version[0]}" -eq 3 ] && [ "${version[1]//[!0-9]}" -ge 3 ]; then
		return 0
	fi

	return 1
}

popup_session() {
	local session_name="$1"
	local title="$2"

	tmux popup \
		-S fg="$(tmux_option_or_fallback '@floax-border-color' 'magenta')" \
		-s fg="$(tmux_option_or_fallback '@floax-text-color' 'blue')" \
		-T "$title" \
		-w "$(tmux_option_or_fallback '@floax-width' '80%')" \
		-h "$(tmux_option_or_fallback '@floax-height' '80%')" \
		-b rounded \
		-E \
		"tmux attach-session -t \"$session_name\""
}

popup_command() {
	local title="$1"
	local command="$2"

	tmux popup \
		-S fg="$(tmux_option_or_fallback '@floax-border-color' 'magenta')" \
		-s fg="$(tmux_option_or_fallback '@floax-text-color' 'blue')" \
		-T "$title" \
		-w "$(tmux_option_or_fallback '@floax-width' '80%')" \
		-h "$(tmux_option_or_fallback '@floax-height' '80%')" \
		-b rounded \
		-E \
		"$command"
}

popup_command_to_pane() {
	local title="$1"
	local origin_pane="$2"
	local query="${3:-}"
	local origin_pane_escaped
	local query_escaped

	origin_pane_escaped="$(printf '%q' "$origin_pane")"
	query_escaped="$(printf '%q' "$query")"

	tmux popup \
		-S fg="$(tmux_option_or_fallback '@floax-border-color' 'magenta')" \
		-s fg="$(tmux_option_or_fallback '@floax-text-color' 'blue')" \
		-T "$title" \
		-w "$(tmux_option_or_fallback '@floax-width' '80%')" \
		-h "$(tmux_option_or_fallback '@floax-height' '80%')" \
		-b rounded \
		-E \
		"origin_pane=$origin_pane_escaped ATUIN_QUERY=$query_escaped ATUIN_SHELL_ZSH=t ATUIN_LOG=error bash -lc 'output=\$(ATUIN_SHELL_ZSH=t ATUIN_LOG=error ATUIN_QUERY=\"\${ATUIN_QUERY:-}\" atuin search -i 3>&1 1>&2 2>&3); if [ -n \"\$output\" ]; then case \"\$output\" in __atuin_accept__:* ) output=\${output#__atuin_accept__:} ;; esac; tmux send-keys -t \"\$origin_pane\" -l \"\$output\"; fi'"
}

launch_app() {
	local session_name="$1"
	local title="$2"
	local command="$3"
	local current_dir
	local current_dir_escaped
	local command_escaped
	local session_dir
	local change_path

	current_dir="$(tmux display-message -p '#{pane_current_path}')"
	current_dir_escaped="$(printf '%q' "$current_dir")"
	command_escaped="$(printf '%q' "$command")"
	change_path="$(tmux_option_or_fallback '@floax-change-path' 'true')"

	if tmux has-session -t "$session_name" 2>/dev/null; then
		session_dir="$(tmux display-message -t "$session_name" -p '#{pane_current_path}')"

		if [ "$change_path" = "true" ] && [ "$session_dir" != "$current_dir" ]; then
			tmux send-keys -t "$session_name" "cd $current_dir_escaped" C-m
		fi

		tmux send-keys -t "$session_name" C-c
		tmux send-keys -t "$session_name" "$command_escaped" C-m
	else
		tmux new-session -d -s "$session_name" -c "$current_dir" "$command"
		tmux set-option -t "$session_name" status off
	fi

	if is_tmux_version_supported; then
		popup_session "$session_name" "$title"
	else
		tmux display-message -d 2000 "FloaX requires tmux version 3.3 or newer"
	fi
}

case "${1:-}" in
	atuin)
		popup_command_to_pane "Atuin" "$(tmux display-message -p '#{pane_id}')" ''
		;;
	lazygit)
		launch_app "floax-lazygit" "LazyGit" "lazygit"
		;;
	lazydocker)
		launch_app "floax-lazydocker" "LazyDocker" "lazydocker"
		;;
	*)
		printf 'usage: %s {atuin|lazygit|lazydocker}\n' "$0" >&2
		exit 1
		;;
esac
