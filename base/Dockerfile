FROM debian:buster-slim
LABEL maintainer=marcio.maciel@evino.com.br \
      vendor=evino.com.br
ENV TERM="xterm-256color" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    DOCKER_CONF_HOME=/opt/docker/ \
    LOG_STDOUT="" \
    LOG_STDERR=""
COPY /bin/ /usr/local/bin/
RUN set -Eeux; \
    chmod +x /usr/local/bin; \
    sed -ri "s/(deb.*\/debian buster main)/\1 contrib non-free /" -- /etc/apt/sources.list; \
    apt-update; \
    apt-upgrade; \
    apt-install \
        apt-transport-https \
        ca-certificates \
        locales \
        procps \
        gnupg \
        supervisor \
        wget \
        curl \
        vim \
        net-tools \
        tzdata
RUN set -Eeux; \
    wget -O "/sbin/gosu" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"; \
    wget -O "/tmp/gosu.asc" "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /tmp/gosu.asc "/sbin/gosu"; \
    rm -rf "$GNUPGHOME" /tmp/gosu.asc; \
    chmod +x "sbin/gosu"; \
    "sbin/gosu" nobody true
COPY conf/ /opt/docker/
RUN set -Eeux; \
    chmod +x /opt/docker/bin/*; \
    docker-run-bootstrap; \
    docker-service enable cron; \
    docker-service enable syslog; \
    docker-image-cleanup
ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
