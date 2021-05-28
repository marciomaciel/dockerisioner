#!/usr/bin/env bash
# script execution entrypoint
set -o pipefail
set -Ee
if [ -n "$CLI_SCRIPT" ]; then
    if [ -n "$APPLICATION_USER" ]; then
        shift
        exec gosu "$APPLICATION_USER" "$CLI_SCRIPT" "$@"
    else
        exec "$CLI_SCRIPT" "$@"
    fi
else
    echo "[ERROR] No CLI_SCRIPT in in docker environment defined"
    exit 1
fi
