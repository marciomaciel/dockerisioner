#!/usr/bin/env bash
if [[ -n "$APPLICATION_USER" ]]; then
    echo "Setting php-fpm user to $APPLICATION_USER"
    sed -i "s/^[\s;]*user[\s]*=/user = $APPLICATION_USER/g" /opt/docker/etc/php/fpm/*.conf
fi
if [[ -n "$APPLICATION_GROUP" ]]; then
    echo "Setting php-fpm group to $APPLICATION_GROUP"
  sed -i "s/^[\s;]*group[\s]*=/group = $CONTAINER_GROUP/g" /opt/docker/etc/php/fpm/*.conf
fi
