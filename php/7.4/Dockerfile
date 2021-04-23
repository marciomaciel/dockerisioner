FROM php:7.4-fpm-buster as php-fpm
FROM evinobr/base-app:latest
LABEL maintainer=marcio.maciel@evino.com.br \
      vendor=evino.com.br
COPY --from=php-fpm / /
ENV PHP_SENDMAIL_PATH="/usr/sbin/sendmail -t -i"
COPY conf/ /opt/docker/
RUN set -Eeux; \
    apt-update; \
    apt-upgrade; \
    docker-service enable syslog; \
    docker-service enable cron; \
    docker-run-bootstrap; \
    docker-image-cleanup
WORKDIR /
EXPOSE 9000
ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
