#!/bin/bash
# install cron
set -Ee
apt-install nginx
go-replace --mode=lineinfile --regex --regex-backrefs \
    -s '^[\s#]*daemon ' -r '' \
    -- /etc/nginx/nginx.conf
go-replace --mode=line --regex --regex-backrefs \
    -s '^([ \t]*access_log)[ \t]*([^\t ;]+)(.*;)$' -r '$1 /docker.stdout $3' \
    -s '^([ \t]*error_log)[ \t]*([^\t ;]+)(.*;)$' -r '$1 /docker.stderr $3' \
    --  /etc/nginx/nginx.conf
ln -sf /opt/docker/etc/nginx/main.conf /etc/nginx/conf.d/10-docker.conf
rm -f \
    /etc/nginx/sites-enabled/default \
    /etc/nginx/conf.d/default.conf
rm -rf /var/lib/nginx/logs
mkdir -p /var/lib/nginx/logs
ln -sf /var/lib/nginx/logs/access.log /docker.stdout
ln -sf /var/lib/nginx/logs/error.log /docker.stderr
chown -R root:root /opt/docker/etc/nginx/ssl
find /opt/docker/etc/nginx/ssl -type d -exec chmod 750 {} \;
find /opt/docker/etc/nginx/ssl -type f -exec chmod 640 {} \;

