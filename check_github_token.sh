#!/bin/bash

# Проверка GitHub токена через GitHub API /user
# Usage: checkGithubToken ENV_VAR_NAME
# Codes: 0 ok, 1 invalid/empty, 2 usage error

__CHECK_GH_TOKEN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${__CHECK_GH_TOKEN_DIR}/echo_colorize.sh"

checkGithubToken() {
    echoTitle "Check GitHub token"
    if [ $# -ne 1 ]; then
        echoRed "Usage: checkGithubToken ENV_VAR_NAME"; return 2; fi

    local env_var_name="${1:-}"
    if [ -z "${env_var_name}" ]; then
        echoRed "Usage: checkGithubToken ENV_VAR_NAME"; return 2; fi

    local token_value="${!env_var_name:-}"
    if [ -z "${token_value}" ]; then
        echoRed "GitHub token variable '${env_var_name}' is empty or not exported."; return 1; fi

    local api_url="https://api.github.com/user"
    local status
    status=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer ${token_value}" "${api_url}" || echo "000")

    if [ "${status}" != "200" ]; then
        echoRed "GitHub token '${env_var_name}' invalid or lacks required access (http ${status})."; return 1; fi

    echoGreen "GitHub token '${env_var_name}' OK"
    return 0
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    checkGithubToken "$@" || exit $?
fi
