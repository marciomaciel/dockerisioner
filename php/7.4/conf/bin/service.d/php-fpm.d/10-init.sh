FPM_POOL_CONF="/opt/docker/etc/php/fpm/pool.d/application.conf"
if [[ -n "$CONTAINER_UID" ]]; then
    echo "Setting php-fpm user to $CONTAINER_UID"
    sed -i "s/^[\s;]*user[\s]*=/user = $CONTAINER_UID/g" /opt/docker/etc/php/fpm/*.conf
    sed -i "s/^[\s;]*group[\s]*=/group = $CONTAINER_UID/g" /opt/docker/etc/php/fpm/*.conf
fi
