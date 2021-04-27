#!/bin/bash
# exec supervisor service
set -o pipefail -Ee
if [[ -z "$SERVICE_SUPERVISOR_OPTS" ]]; then SERVICE_SUPERVISOR_OPTS=""; fi
if [[ -z "$SERVICE_SUPERVISOR_USER" ]]; then SERVICE_SUPERVISOR_USER="root"; fi
if [[ -d "/opt/docker/bin/service.d/supervisor.d" ]]; then
    for FILE in "/opt/docker/bin/service.d/supervisor.d"/*.sh; do
        if test -e "$FILE" -o -L "$FILE"; then
            echo "-> Executing ${FILE}"
            # shellcheck source=$FILE
            . "$FILE"
        fi
    done
fi
exec supervisord -c /opt/docker/etc/supervisor.conf --logfile /dev/null --pidfile /dev/null --user "$SERVICE_SUPERVISOR_USER" $SERVICE_SUPERVISOR_OPTS
