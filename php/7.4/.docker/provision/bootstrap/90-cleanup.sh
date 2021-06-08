#!/usr/bin/env bash
#cleanup cron default configs
set -Ee
rm -f -- \
    /etc/cron.daily/logrotate \
    /etc/cron.daily/apt-compat \
    /etc/cron.daily/dpkg \
    /etc/cron.daily/passwd \
    /etc/cron.daily/0yum-daily.cron \
    /etc/cron.daily/logrotate \
    /etc/cron.hourly/0yum-hourly.cron \
    /etc/periodic/daily/logrotate
