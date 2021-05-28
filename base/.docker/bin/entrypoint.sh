#!/usr/bin/env bash
set -o pipefail
set -Ee
TASK=$1
runScripts() {
    SCRIPT_DIRECTORY="$1"
    if [ -d "$SCRIPT_DIRECTORY" ]; then
        echo ":: Running scripts in $SCRIPT_DIRECTORY"
        for FILE in "$SCRIPT_DIRECTORY/"*.sh; do
            if test -e "$FILE" -o -L "$FILE"; then
                echo "-> Executing $FILE"
                # shellcheck source=$FILE
                . "$FILE"
                rm -f -- "$FILE"
            else
                echo "[ERROR] Entrypoint bootstrap file $FILE is not valid"
                exit 1
            fi
        done
    fi
}
runEntrypoint() {
    ENTRYPOINT_SCRIPT="/opt/docker/bin/entrypoint.d/${TASK}.sh"
    if [ -f "$ENTRYPOINT_SCRIPT" ]; then
        # shellcheck source=$ENTRYPOINT_SCRIPT
        . "$ENTRYPOINT_SCRIPT"
    else
        echo "[ERROR] Invalid entrypoint $ENTRYPOINT_SCRIPT"
    fi
    if [ -f "/opt/docker/bin/entrypoint.d/default.sh" ]; then
        . /opt/docker/bin/entrypoint.d/default.sh
    fi
    exit 1
}
if [[ "$UID" -eq 0 ]]; then
    if [ "$TASK" == "supervisord" ] || [ "$TASK" == "noop" ]; then
        runScripts "/opt/docker/provision/entrypoint"
    else
        runScripts "/opt/docker/provision/entrypoint" >/dev/null
    fi
fi
runEntrypoint "$@"
