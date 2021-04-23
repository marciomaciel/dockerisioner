FROM evinobr/base:latest
LABEL maintainer=marcio.maciel@evino.com.br \
      vendor=evino.com.br
ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000
COPY conf/ /opt/docker/
RUN set -Eeu; \
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
    docker-run-bootstrap; \
    docker-image-cleanup
