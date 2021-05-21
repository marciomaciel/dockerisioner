#!/bin/bash
# exec cron service
set -Ee
if [[ -z "$SERVICE_CRON_OPTS" ]]; then SERVICE_CRON_OPTS=""; fi
if [[ -d "/opt/docker/bin/service.d/cron.d" ]]; then
    for FILE in "/opt/docker/bin/service.d/cron.d/"*.sh; do
        echo "-> Executing ${FILE}"
        # shellcheck source=$FILE
        . "$FILE"
    done
fi
exec /usr/sbin/cron -f $SERVICE_CRON_OPTS
