#!/usr/bin/env bash

set -euo pipefail

USAGE="Usage: $(basename "${BASH_SOURCE[0]}") [command]
Commands:
  update  Update all go modules to the latest versions.
  init    Initialize a new go module in the current directory.
Options:
  -h, --help  Show this help message.
"

function check_dependencies() {
	if ! command -v go &>/dev/null; then
		echo "Error: 'go' command not found. Please install it first."
		exit 1
	fi
	if ! command -v git &>/dev/null; then
		echo "Error: 'git' command not found. Please install it first."
		exit 1
	fi
}

function source_utils() {
	if [ -f "$(dirname "${BASH_SOURCE[0]}")/utils.sh" ]; then
		# shellcheck disable=SC1091
		source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"
	else
		echo "Error: utils definitions file not found."
		exit 1
	fi
}

function mod_updates() {
	echo -e "${COLOR_REGULAR_BLUE}Updating all go modules to the latest versions...${COLOR_RESET}"
	find . -name 'go.mod' -execdir sh -c '
		GO_MOD_NAME="$(cat go.mod | grep "^module " | awk "{print \$2}")"
		echo -e "${COLOR_REGULAR_BLUE}Updating module for ${GO_MOD_NAME}...${COLOR_RESET}"
		go mod tidy
		go get -u ./...
		echo -e "${COLOR_REGULAR_GREEN}Module updated successfully for ${GO_MOD_NAME}.${COLOR_RESET}"
	' \;
	echo "All go modules updated successfully."
}

function mod_init() {
	echo -e "${COLOR_REGULAR_BLUE}Initializing go module...${COLOR_RESET}"
	local REPO_BASE
	REPO_BASE="$(git remote get-url origin | sed -e 's|https://||g' -e 's|.git||g')"
	local PATH_FROM_GIT_ROOT
	PATH_FROM_GIT_ROOT="$(git rev-parse --show-prefix)"
	local REPO_PATH
	REPO_PATH="$(echo "${REPO_BASE}/${PATH_FROM_GIT_ROOT}" | sed -e 's|/$||g')"
	go mod init "${REPO_PATH}"
	echo -e "${COLOR_REGULAR_GREEN}Go module initialized successfully with path: ${REPO_PATH}.${COLOR_RESET}"
}

function main() {
	check_dependencies
	source_utils

	local command="${1:-}"
	shift

	if [[ -z "${command}" ]]; then
		echo "No command provided."
		echo "${USAGE}"
		exit 1
	elif [[ "${command}" == "-h" || "${command}" == "--help" ]]; then
		echo "${USAGE}"
		exit 0
	fi

	case "${command}" in
	update)
		cd_repo_root
		mod_updates
		;;
	init)
		mod_init
		;;
	"-h" | "--help")
		echo "${USAGE}"
		;;
	*)
		echo "Unknown command: ${command}"
		echo "${USAGE}"
		exit 1
		;;
	esac
}

main "${@}"
