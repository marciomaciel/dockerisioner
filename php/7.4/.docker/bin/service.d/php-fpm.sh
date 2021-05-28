#!/usr/bin/env bash
if [[ -z "$SERVICE_PHPFPM_OPTS" ]]; then SERVICE_PHPFPM_OPTS=""; fi
SCRIPT_DIRECTORY="/opt/docker/bin/service.d/php-fpm.d"
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
exec /usr/local/sbin/php-fpm --nodaemonize $SERVICE_PHPFPM_OPTS
