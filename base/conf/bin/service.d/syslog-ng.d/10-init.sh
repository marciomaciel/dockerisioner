if [ ! -S /dev/log ]; then rm -f /dev/log; fi
if [ ! -S /var/lib/syslog-ng/syslog-ng.ctl ]; then rm -f /var/lib/syslog-ng/syslog-ng.ctl; fi
if [[ ! -p /docker.stdout ]]; then
    sed -i 's/pipe("\/docker.stdout")/file("\/docker.stdout")/g' /opt/docker/etc/syslog-ng/syslog-ng.conf
fi
