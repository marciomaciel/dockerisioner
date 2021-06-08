FROM dockerisioner/php-nginx:7.4
ENV APPLICATION_USER=magento \
    APPLICATION_GROUP=magento \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=magento.localhost
COPY .docker/ /opt/docker/
COPY --chown=$APPLICATION_UID:$APPLICATION_GID auth.json /home/magento/.composer/auth.json
RUN set -Eue; \
    echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list; \
    wget -qO - https://download.newrelic.com/548C16BF.gpg | apt-key add -; \
    echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list; \
    wget -qO - https://packages.blackfire.io/gpg.key | apt-key add -; \
    apt-update; \
    apt-install \
        newrelic-php5 \
        blackfire-php; \
    #docker-php-ext-enable newrelic-php5 blackfire; \
    # composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
    docker-service enable cron; \
    docker-service enable syslog; \
    run-bootstrap; \
    docker-image-cleaner
