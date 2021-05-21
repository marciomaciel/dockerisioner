#!/bin/bash
set -Ee
apt-install supervisor
rm -rf /usr/sbin/service
rm -rf -- /etc/supervisor*
mkdir -p /etc/supervisor
ln -sf /opt/docker/etc/supervisor.conf /etc/supervisor/supervisord.conf
ln -sf /opt/docker/etc/supervisor.d /etc/supervisor/conf.d
