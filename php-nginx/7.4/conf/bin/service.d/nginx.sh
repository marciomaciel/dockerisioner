#!/bin/bash
set -Ee
if [[ -z "$SERVICE_NGINX_OPTS" ]]; then SERVICE_NGINX_OPTS=""; fi
SCRIPT_DIRECTORY="/opt/docker/bin/service.d/nginx.d"
if [[ -d "$SCRIPT_DIRECTORY" ]]; then
   echo ":: Running scripts in $SCRIPT_DIRECTORY"
    for FILE in "$SCRIPT_DIRECTORY/"*.sh; do
        if test -e "$FILE" -o -L "$FILE"; then
            echo "-> Executing ${FILE}"
            # shellcheck source=$FILE
            . "$FILE"
        fi
    done
fi
exec /usr/sbin/nginx -g 'daemon off;' $SERVICE_NGINX_OPTS
