#!/usr/bin/env bash
ln -sf -- "$PHP_FPM_BIN" /usr/local/bin/php-fpm
if [[ ! -f /opt/docker/etc/php/fpm/php-fpm.conf ]]; then
       mv -- "$PHP_MAIN_CONF" /opt/docker/etc/php/fpm/php-fpm.conf
else
       rm -f -- "$PHP_MAIN_CONF"
fi
ln -sf -- /opt/docker/etc/php/fpm/php-fpm.conf "$PHP_MAIN_CONF"
sed -i 's/^.*error_log.*=.*/error_log = \/docker.stderr/g' /opt/docker/etc/php/fpm/php-fpm.conf
sed -i 's/^.*pid.*=.*/pid = \/var\/run\/php-fpm.pid/g' /opt/docker/etc/php/fpm/php-fpm.conf
