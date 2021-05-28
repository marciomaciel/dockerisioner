FROM dockerisioner/base-app:debian-buster as base-app
FROM php:7.4-fpm-buster
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    LOG_STDOUT="" \
    LOG_STDERR=""
ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000
ENV PHP_SENDMAIL_PATH="/usr/sbin/sendmail -t -i"
COPY --from=base-app /opt/docker /opt/docker
COPY --from=base-app /usr/local/bin/ /usr/local/bin/
COPY .docker/ /opt/docker/
RUN set -Eue; \
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
        lsb-release \
        gpg \
        gpg-agent \
        wget \
        curl \
        vim \
        net-tools \
        tzdata \
        zip \
        unzip \
        bzip2 \
        moreutils \
        dnsutils \
        openssh-client \
        rsync \
        git \
        patch; \
    MYSQL_TEMP=$(mktemp); wget -O $MYSQL_TEMP https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb; \
    DEBIAN_FRONTEND=noninteractive dpkg -i $MYSQL_TEMP; \
    rm -f $MYSQL_TEMP; \
    /usr/local/bin/generate-locales; \
    apt-update; \
    apt-install \
        mysql-client \
        jpegoptim \
        libjpeg-turbo-progs \
        pngcrush \
        optipng \
        apngopt \
        pngnq \
        pngquant \
        libvips42 \
        librabbitmq4 \
        libxslt1.1 \
        zlibc \
        zlib1g \
        libpq5 \
        libpng16-16 \
        libmcrypt4 \
        libzip4 \
        libjpeg62-turbo-dev \
        libwebp-dev \
        libfreetype6-dev \
        libbz2-dev \
        libicu-dev \
        libmcrypt-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        librabbitmq-dev; \
    # Install new version of ICU
    curl -sS -o /tmp/icu.tar.gz -L https://github.com/unicode-org/icu/releases/download/release-69-1/icu4c-69_1-src.tgz; \
    tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source && ./configure --prefix=/usr/local && make && make install && cd / && rm -rf /tmp/icu*; \
    PKG_CONFIG_PATH=/usr/local docker-php-ext-configure intl; \
    docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp; \
    docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        intl \
        gettext \
        mysqli \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        tokenizer \
        sysvmsg \
        sysvsem \
        sysvshm \
        shmop \
        xmlrpc \
        xsl \
        zip \
        gd \
        gettext \
        opcache;
RUN set -Eeu; \
    pecl install apcu; \
    pecl install redis; \
    pecl install amqp; \
    #docker-php-ext-enable apcu redis amqp; \
    apt-get purge -y -f --force-yes \
        libbz2-dev \
        libicu-dev \
        libmcrypt-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        libpng-dev \
        libwebp-dev \
        libpq-dev \
        libzip-dev \
        librabbitmq-dev; \
    rm -f /usr/local/etc/php-fpm.d/zz-docker.conf; \
    run-bootstrap; \
    docker-image-cleaner
WORKDIR $APPLICATION_PATH
EXPOSE 9000

# Override stop signal to stop process gracefully
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]
