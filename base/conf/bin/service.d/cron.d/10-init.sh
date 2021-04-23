if [[ -d "/opt/docker/etc/cron" ]]; then
    mkdir -p /etc/cron.d/
    find /opt/docker/etc/cron -type f | while read CRONTAB_FILE; do
        chmod 0644 -- "$CRONTAB_FILE"
        echo >>"$CRONTAB_FILE"
        cp -a -- "$CRONTAB_FILE" "/etc/cron.d/$(basename "$CRONTAB_FILE")"
    done
fi
