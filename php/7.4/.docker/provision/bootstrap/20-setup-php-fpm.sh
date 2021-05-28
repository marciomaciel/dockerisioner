#!/usr/bin/env bash
set -o pipefail -Ee
PHP_MAIN_CONF=/usr/local/etc/php-fpm.conf
if [[ ! -f /opt/docker/etc/php/fpm/php-fpm.conf ]]; then
    mv -- "$PHP_MAIN_CONF" /opt/docker/etc/php/fpm/php-fpm.conf
else
    rm -f -- "$PHP_MAIN_CONF"
fi
ln -sf -- /opt/docker/etc/php/fpm/php-fpm.conf "$PHP_MAIN_CONF"
go-replace --mode=lineinfile --regex \
    --lineinfile-after='\[global\]' \
    -s '^[\s;]*error_log[\s]*=' -r 'error_log = /docker.stderr' \
    -s '^[\s;]*pid[\s]*=' -r 'pid = /var/run/php-fpm.pid' \
    -s '^[\s;]*log_level[\s]*=' -r 'log_level = warning' \
    -- /opt/docker/etc/php/fpm/php-fpm.conf
go-replace --mode=line --regex \
    -s '^[\s;]*listen[\s]*=' -r 'listen = [::]:9000' \
    --path=/opt/docker/etc/php/fpm/ \
    --path-pattern='*.conf'
