#!/usr/bin/env bash
set -o pipefail -Ee
go-replace --mode=line --regex \
    -s '^[\s;]*user[\s]*=' -r "user = $APPLICATION_USER" \
    -s '^[\s;]*group[\s]*=' -r "group = $APPLICATION_GROUP" \
    --path=/opt/docker/etc/php/fpm/ \
    --path-pattern='*.conf'
echo '' >> /opt/docker/etc/php/fpm/php-fpm.conf
echo '; container env settings' >> /opt/docker/etc/php/fpm/php-fpm.conf
echo '[global]' >> /opt/docker/etc/php/fpm/php-fpm.conf
if [[ -n "${FPM_PROCESS_MAX+x}" ]]; then
    echo "process.max = ${FPM_PROCESS_MAX}" >> /opt/docker/etc/php/fpm/php-fpm.conf
fi
if [[ -n "${FPM_LOG_LEVEL+x}" ]]; then
    echo "log_level = ${FPM_LOG_LEVEL}" >> /opt/docker/etc/php/fpm/php-fpm.conf
fi
echo '' >> /opt/docker/etc/php/fpm/pool.d/application.conf
echo '; container env settings' >> /opt/docker/etc/php/fpm/pool.d/application.conf
if [[ -n "${FPM_DISABLE_ACCESS_LOG+x}" ]]; then
    go-replace --mode=lineinfile --regex \
    -s '^[\s;]*access.log[\s]*=' -r 'access.log = /dev/null' \
        --path=/opt/docker/etc/php/fpm/ \
        --path-pattern='*.conf'
fi
if [[ -n "${FPM_PM_MAX_CHILDREN+x}" ]]; then
    echo "pm.max_children = ${FPM_PM_MAX_CHILDREN}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_PM_START_SERVERS+x}" ]]; then
    echo "pm.start_servers = ${FPM_PM_START_SERVERS}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_PM_MIN_SPARE_SERVERS+x}" ]]; then
    echo "pm.min_spare_servers = ${FPM_PM_MIN_SPARE_SERVERS}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_PM_MAX_SPARE_SERVERS+x}" ]]; then
    echo "pm.max_spare_servers = ${FPM_PM_MAX_SPARE_SERVERS}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_PROCESS_IDLE_TIMEOUT+x}" ]]; then
    echo "pm.process_idle_timeout = ${FPM_PROCESS_IDLE_TIMEOUT}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_MAX_REQUESTS+x}" ]]; then
    echo "pm.max_requests = ${FPM_MAX_REQUESTS}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_REQUEST_TERMINATE_TIMEOUT+x}" ]]; then
    echo "request_terminate_timeout = ${FPM_REQUEST_TERMINATE_TIMEOUT}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_RLIMIT_FILES+x}" ]]; then
    echo "rlimit_files = ${FPM_RLIMIT_FILES}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${FPM_RLIMIT_CORE+x}" ]]; then
    echo "rlimit_core = ${FPM_RLIMIT_CORE}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi

if [[ -n "${PHP_SENDMAIL_PATH+x}" ]]; then
    echo "php_admin_value[sendmail_path] = ${PHP_SENDMAIL_PATH}" >> /opt/docker/etc/php/fpm/pool.d/application.conf
fi
