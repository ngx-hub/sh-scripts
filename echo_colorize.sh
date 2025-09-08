#!/bin/bash


_DIVIDER="------------------------------------------------------------------------------"
_GRAY="\033[0;90m"
_RED="\033[0;31m"
_GREEN="\033[0;32m"
_CYAN="\033[0;36m"
_NO_COLOR="\033[0m"

echoGray() {
  echo -e "${_GRAY}$1${_NO_COLOR}"
}

echoCyan() {
  echo -e "${_CYAN}$1${_NO_COLOR}"
}

echoGreen() {
  echo -e "${_GREEN}$1${_NO_COLOR}"
}

echoRed() {
  echo -e "${_RED}$1${_NO_COLOR}"
}

echoTitle() {
  echoGray "\n${_DIVIDER}"
  echoCyan "$@\n"
}
