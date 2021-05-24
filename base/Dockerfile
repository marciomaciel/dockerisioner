FROM debian:buster-slim
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV TERM="xterm-256color" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    LOG_STDOUT="" \
    LOG_STDERR=""
# utils tools
COPY /bin/ /usr/local/bin/
# configs and provisioning scripts
COPY conf/ /opt/docker/
RUN set -Ee; \
    chmod +x /usr/local/bin; \
    sed -ri "s/(deb.*\/debian buster main)/\1 contrib non-free /" -- /etc/apt/sources.list; \
    apt-update; \
    apt-upgrade; \
    # install basic packages
    apt-install \
        apt-transport-https \
        ca-certificates \
        locales \
        procps \
        gnupg \
        wget \
        curl \
        vim \
        net-tools \
        tzdata; \
    # basic image provisioning
    run-bootstrap; \
    # cleanup image before finish setup
    docker-image-cleaner;

# Override stop signal to stop process gracefully
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
