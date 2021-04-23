mkdir -p /var/tmp/nginx/
ln -f -s /var/lib/nginx/logs /var/log/nginx
sed -i "s/<DOCUMENT_INDEX>/$WEB_DOCUMENT_INDEX/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<DOCUMENT_ROOT>/$WEB_DOCUMENT_ROOT/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<ALIAS_DOMAIN>/$WEB_ALIAS_DOMAIN/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<SERVERNAME/$HOSTNAME/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<PHP_SOCKET>/$WEB_PHP_SOCKET/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<PHP_TIMEOUT>/$WEB_PHP_TIMEOUT/g" /opt/docker/etc/nginx/*.conf
sed -i "s/<SERVICE_NGINX_CLIENT_MAX_BODY_SIZE>/$SERVICE_NGINX_CLIENT_MAX_BODY_SIZE/g" /opt/docker/etc/nginx/*.conf
if [[ -z "$WEB_PHP_SOCKET" ]]; then
    rm -f -- /opt/docker/etc/nginx/conf.d/10-php.conf
    rm -f -- /opt/docker/etc/nginx/vhost.common.d/10-php.conf
fi
