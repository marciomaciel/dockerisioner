#!/bin/bash
# configure stderr and stdout files
set -o pipefail
set -Ee
if [[ -n "$LOG_STDOUT" ]]; then
    echo "Log stdout redirected to $LOG_STDOUT"
else
    LOG_STDOUT="/proc/$$/fd/1"
fi

if [[ -n "$LOG_STDERR" ]]; then
    echo "Log stderr redirected to $LOG_STDERR"
else
    LOG_STDERR="/proc/$$/fd/2"
fi

ln -f -s "$LOG_STDOUT" /docker.stdout
ln -f -s "$LOG_STDERR" /docker.stderr
