#!/usr/bin/env bash

set -eu

help() {
  cat <<-EOF
		Script to validate all plugins using the built-in Claude Code plugin validator
		Usage: ./validate-plugins.sh [plugin_name]
		Examples:
		  ./validate-plugins.sh --help       # show this help
		  ./validate-plugins.sh              # Validate all plugins
		  ./validate-plugins.sh my-plugin    # Validate specific plugin
		EOF
}

test_plugin() {
  if [ ! -d "${1}" ]; then
    # is not a directory
    return 0
  fi

  if ! output=$(claude plugin validate "${1}" 2>&1); then
    echo -e "❌ ${1} - INVALID\n${output}"
    return 1
  fi

  echo "✅ ${1} - VALID"
  return 0
}

test_claude() {
  # Check if claude command is available
  if ! command -v claude &>/dev/null; then
    cat <<-EOF
			❌ Error: 'claude' command not found
			Please install Claude Code first: https://docs.claude.com/claude-code
		EOF
    exit 1
  fi
}

test_all_plugins() {
  # iterate over the folders in the marketplace
  has_failure=false

  for plugin_dir in ./**; do
    test_plugin "${plugin_dir}" || has_failure=true
  done

  ${has_failure} && exit 1 || exit 0
}

# args iter
if [ $# -eq 0 ]; then
  test_claude
  test_all_plugins || exit 1
fi

for arg in "$@"; do
  case "${arg}" in
  --help)
    help
    exit 0
    ;;

  *)
    test_claude
    test_plugin "${arg}" || exit 1
    ;;

  esac
done
