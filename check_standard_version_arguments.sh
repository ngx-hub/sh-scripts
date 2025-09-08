#!/bin/bash

# Валидация аргументов standard-version
# Usage: checkStandardVersionArguments "$@" || exit 1
# Flags:
#   -r|--release-as <major|minor|patch>
#   -p|--prerelease <alpha|beta|rc>
# Codes: 0 ok, 1 invalid

__CHECK_STANDARD_VERSION_ARGUMENTS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$__CHECK_STANDARD_VERSION_ARGUMENTS_DIR/echo_colorize.sh"

checkStandardVersionArguments() {
    echoTitle "Check standard-version arguments"
    if [ $# -ne 2 ]; then
        echoRed "Need: -r|--release-as <major|minor|patch> OR -p|--prerelease <alpha|beta|rc>" >&2
        return 1
    fi
    local flag="$1"; local value="$2"
    case "$flag" in
        -r|--release-as)
            case "$value" in
                major|minor|patch) echoGreen "OK"; return 0 ;;
                *) echoRed "Invalid value for $flag: $value" >&2; return 1 ;;
            esac
            ;;
        -p|--prerelease)
            case "$value" in
                alpha|beta|rc) echoGreen "OK"; return 0 ;;
                *) echoRed "Invalid value for $flag: $value" >&2; return 1 ;;
            esac
            ;;
        *)
            echoRed "Unknown flag $flag" >&2; return 1 ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    checkStandardVersionArguments "$@" || exit $?
fi
