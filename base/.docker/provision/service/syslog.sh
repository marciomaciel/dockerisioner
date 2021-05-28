#!/usr/bin/env bash
set -Ee
apt-update
apt-install syslog-ng syslog-ng-core
SYSLOG_NG_VERSION=$(syslog-ng --version | grep -E -e '^Installer-Version:[ ]+[0-9]+\.[0-9]+' | head -n 1 | awk '{print $2}' | cut -f 1,2 -d .)
if [[ -f /etc/default/syslog-ng ]]; then
    sed -i '/SYSLOGNG_OPTS.*/c\SYSLOGNG_OPTS = --no-caps' /etc/default/syslog-ng
fi
sed -i "/@version.*/c\@version: ${SYSLOG_NG_VERSION}" /opt/docker/etc/syslog-ng/syslog-ng.conf
ln -s -f /opt/docker/etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
mkdir -p /var/lib/syslog-ng
