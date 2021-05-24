#!/bin/bash
set -o pipefail -Ee
PHP_POOL_CONF=www.conf
PHP_POOL_DIR=/usr/local/etc/php-fpm.d
if [[ ! -f "/opt/docker/etc/php/fpm/pool.d/application.conf" ]]; then
    mv -- "$PHP_POOL_DIR" /opt/docker/etc/php/fpm/pool.d
    mv -- "/opt/docker/etc/php/fpm/pool.d/${PHP_POOL_CONF}" /opt/docker/etc/php/fpm/pool.d/application.conf
fi
rm -rf -- "$PHP_POOL_DIR"
ln -sf -- /opt/docker/etc/php/fpm/pool.d "$PHP_POOL_DIR"
go-replace --mode=lineinfile --regex \
    -s '^[\s;]*catch_workers_output[\s]*=' -r 'catch_workers_output = yes' \
    -s '^[\s;]*access.format[\s]*=' -r 'access.format = "[php-fpm:access] %R - %u %t \"%m %r%Q%q\" %s %f %{mili}d %{kilo}M %C%%"' \
    -s '^[\s;]*access.log[\s]*=' -r 'access.log = /docker.stdout' \
    -s '^[\s;]*slowlog[\s]*=' -r 'slowlog = /docker.stderr' \
    -s '^[\s;]*php_admin_value\[error_log\][\s]*=' -r 'php_admin_value[error_log] = /docker.stderr' \
    -s '^[\s;]*php_admin_value\[log_errors\][\s]*=' -r 'php_admin_value[log_errors] = on' \
    -s '^[\s;]*listen.allowed_clients[\s]*=' -r ";listen.allowed_clients" \
    -- /opt/docker/etc/php/fpm/pool.d/application.conf
go-replace --mode=line --regex \
    -s '^[\s;]*user[\s]*=' -r "user = $APPLICATION_USER" \
    -s '^[\s;]*group[\s]*=' -r "group = $APPLICATION_GROUP" \
    --path=/opt/docker/etc/php/fpm/ \
    --path-pattern='*.conf'
go-replace --mode=lineinfile --regex \
    -s '^[\s;]*clear_env[\s]*=' -r 'clear_env = yes' \
    -- /opt/docker/etc/php/fpm/pool.d/application.conf
