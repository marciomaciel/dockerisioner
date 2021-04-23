#!/bin/bash
rm -rf /usr/sbin/service
rm -rf -- /etc/supervisor*
ln -sf /opt/docker/etc/supervisor.conf /etc/supervisord.conf
