#!/bin/bash
# copy cron files configs to cron.d
set -o pipefail
set -Ee
CONFIG_DIRECTORY="/opt/docker/etc/cron"
if [ -d "$CONFIG_DIRECTORY" ]; then
    mkdir -p /etc/cron.d/

    for CRONTAB_FILE in "$CONFIG_DIRECTORY/"*; do
        if test -e "$CRONTAB_FILE" -o -L "$CRONTAB_FILE"; then
            chmod 0644 -- "$CRONTAB_FILE"
            echo >>"$CRONTAB_FILE"
            cp -a -- "$CRONTAB_FILE" "/etc/cron.d/$(basename "$CRONTAB_FILE")"
        fi
    done
fi
