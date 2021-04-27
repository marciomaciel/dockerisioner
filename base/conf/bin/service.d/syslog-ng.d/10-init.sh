#!/bin/bash
# init syslog-ng configs
set -o pipefail -Ee
if [ ! -S /dev/log ]; then rm -f /dev/log; fi
if [ ! -S /var/lib/syslog-ng/syslog-ng.ctl ]; then rm -f /var/lib/syslog-ng/syslog-ng.ctl; fi
if [[ ! -p /docker.stdout ]]; then
    sed -i '/pipe("\/docker.stdout")/c\file("\/docker.stdout")' /opt/docker/etc/syslog-ng/syslog-ng.conf
fi
