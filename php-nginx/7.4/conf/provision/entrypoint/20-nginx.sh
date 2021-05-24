#!/bin/bash
set -o pipefail -Ee
mkdir -p /var/tmp/nginx/
ln -f -s /var/lib/nginx/logs /var/log/nginx
go-replace \
    -s "<DOCUMENT_INDEX>" -r "$WEB_DOCUMENT_INDEX" \
    -s "<DOCUMENT_ROOT>" -r "$WEB_DOCUMENT_ROOT" \
    -s "<ALIAS_DOMAIN>" -r "$WEB_ALIAS_DOMAIN" \
    -s "<SERVERNAME>" -r "$HOSTNAME" \
    -s "<PHP_SOCKET>" -r "$WEB_PHP_SOCKET" \
    -s "<PHP_TIMEOUT>" -r "$WEB_PHP_TIMEOUT" \
    -s "<SERVICE_NGINX_CLIENT_MAX_BODY_SIZE>" -r "$SERVICE_NGINX_CLIENT_MAX_BODY_SIZE" \
    --path=/opt/docker/etc/nginx/ \
    --path-pattern='*.conf' \
    --ignore-empty
if [[ -z "$WEB_PHP_SOCKET" ]]; then
    rm -f -- /opt/docker/etc/nginx/conf.d/10-php.conf
    rm -f -- /opt/docker/etc/nginx/vhost.common.d/10-php.conf
fi
