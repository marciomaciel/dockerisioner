#!/usr/bin/env bash
if [[ ! -f "/opt/docker/etc/php/fpm/pool.d/application.conf" ]]; then
    mv -- "$PHP_POOL_DIR" /opt/docker/etc/php/fpm/pool.d
    mv -- "/opt/docker/etc/php/fpm/pool.d/${PHP_POOL_CONF}" /opt/docker/etc/php/fpm/pool.d/application.conf
fi
rm -rf -- "$PHP_POOL_DIR"
ln -sf -- /opt/docker/etc/php/fpm/pool.d "$PHP_POOL_DIR"
sed -i 's/^.*catch_workers_output.*=.*/catch_workers_output = yes/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*access.format.*=.*/access.format = "[php-fpm:access] %R - %u %t \"%m %r%Q%q\" %s %f %{mili}d %{kilo}M %C%%"/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*access.log.*=.*/access.log = \/docker.stdout/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*slowlog.*=.*/slowlog = \/docker.stderr/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*php_admin_value\[error_log\].*=.*/php_admin_value[error_log] = \/docker.stderr/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*php_admin_value\[log_errors\].*=.*/php_admin_value[log_errors] = on/g' /opt/docker/etc/php/fpm/pool.d/application.conf
sed -i 's/^.*listen.allowed_clients.*=.*/;listen.allowed_clients/g' /opt/docker/etc/php/fpm/pool.d/application.conf
if [[ "$PHP_CLEAR_ENV_AVAILABLE" -eq 1 ]]; then
    sed -i 's/^.*clear_env.*=.*/clear_env = no/g' /opt/docker/etc/php/fpm/pool.d/application.conf
    rm -f /opt/docker/bin/service.d/php-fpm.d/11-clear-env.sh
else
    echo ';#CLEAR_ENV_WORKAROUND#' >>/opt/docker/etc/php/fpm/pool.d/application.conf
fi
