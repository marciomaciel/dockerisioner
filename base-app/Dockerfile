FROM dockerisioner/base:debian-buster
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000
COPY .docker/ /opt/docker/
RUN set -Eue; \
    apt-update; \
    apt-install \
        zip \
        unzip \
        bzip2 \
        moreutils \
        dnsutils \
        openssh-client \
        rsync \
        git \
        patch; \
    /usr/local/bin/generate-locales; \
    run-bootstrap; \
    docker-image-cleaner
