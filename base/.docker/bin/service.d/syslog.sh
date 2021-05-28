#!/usr/bin/env bash
set -Ee
if [[ -z "$SERVICE_SYSLOG_OPTS" ]]; then SERVICE_SYSLOG_OPTS=""; fi
if [[ -d "/opt/docker/bin/service.d/syslog-ng.d" ]]; then
    for FILE in "/opt/docker/bin/service.d/syslog-ng.d/"*.sh; do
        echo "-> Executing ${FILE}"
        # shellcheck source=$FILE
        . "$FILE"
    done
fi
exec syslog-ng -F --no-caps -p /var/run/syslog-ng.pid $SYSLOGNG_OPTS $SERVICE_SYSLOG_OPTS
