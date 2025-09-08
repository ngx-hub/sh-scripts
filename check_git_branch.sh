#!/bin/bash

# Проверка: текущая git ветка == ожидаемой.
# Usage: checkGitBranch <BRANCH_NAME>
# Codes: 0 ok, 1 mismatch, 2 usage, 3 not git/detached

__CHECK_GIT_BRANCH_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${__CHECK_GIT_BRANCH_DIR}/echo_colorize.sh"

checkGitBranch() {
    echoTitle "Check git branch"
    if [ $# -ne 1 ]; then
        echoRed "Usage: checkGitBranch BRANCH_NAME"; return 2; fi

    local expected="$1"
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echoRed "Not a git repository"; return 3; fi

    local current
    current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
    if [ -z "$current" ] || [ "$current" = "HEAD" ]; then
        echoRed "Cannot determine branch (detached HEAD?)"; return 3; fi

    if [ "$current" = "$expected" ]; then
        echoGreen "Branch OK: $current"; return 0
    else
        echoRed "Branch mismatch: current '$current' != expected '$expected'"; return 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    checkGitBranch "$@" || exit $?
fi
