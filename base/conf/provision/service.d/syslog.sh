#!/bin/bash
set -Euex
apt-install syslog-ng syslog-ng-core
SYSLOG_NG_VERSION=$(syslog-ng --version | grep -E -e '^Installer-Version:[ ]+[0-9]+\.[0-9]+' | head -n 1 | awk '{print $2}' | cut -f 1,2 -d .)
if [[ -f /etc/default/syslog-ng ]]; then
    sed -i 's/SYSLOGNG_OPTS.*/SYSLOGNG_OPTS = --no-caps/g' /etc/default/syslog-ng
fi
ln -s -f /opt/docker/etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
sed -i "s/@version.*/@version: ${SYSLOG_NG_VERSION}/g" /etc/syslog-ng/syslog-ng.conf
mkdir -p /var/lib/syslog-ng
