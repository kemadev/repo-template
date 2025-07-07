#!/usr/bin/env bash

set -euo pipefail

TEMPLATE_REPO="https://github.com/kemadev/repo-template"
CONFIG_PATH="config/copier/.copier-answers.yml"

USAGE="Usage: $(basename "${BASH_SOURCE[0]}") [command]
Commands:
  copy    Copy files from a template repository.
  update  Update files from a template repository.
  -h, --help  Show this help message.
"

function go_to_git_root() {
	local GIT_ROOT
	GIT_ROOT="$(git rev-parse --show-toplevel)"
	if [ -n "${GIT_ROOT}" ]
	then
		cd "${GIT_ROOT}"
	else
		echo "Error: Not a git repository."
		exit 1
	fi
}


function main() {
	go_to_git_root

	local command="${1:-}"
	shift

	case "${command}" in
	copy)
		copier copy "${TEMPLATE_REPO}" .
		;;
	update)
		copier update --answers-file "${CONFIG_PATH}" .
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
