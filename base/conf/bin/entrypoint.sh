#!/bin/bash
set -o pipefail
set -Eeux
trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL
TASK="$(echo $1 | sed 's/[^-_a-zA-Z0-9]*//g')"
source /opt/docker/bin/config.sh
createDockerStdoutStderr
if [[ "$UID" -eq 0 ]]; then
    if [ "$TASK" == "supervisord" -o "$TASK" == "noop" ]; then
        runProvisionEntrypoint
    else
        runProvisionEntrypoint >/dev/null
    fi
fi
runEntrypoints "$@"
