#!/usr/bin/env bash
# php-cli execution entrypoint
set -Ee
if [ -n "$APPLICATION_USER" ]; then
    shift
    exec gosu "$APPLICATION_USER" /usr/local/bin/php -a "$@"
else
    exec /usr/local/bin/php -a "$@"
fi
