FROM base
ENV APPLICATION_USER=magento \
    APPLICATION_GROUP=magento \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=magento.localhost
COPY .docker/ /opt/docker/

RUN set -Eue; \
    docker-service enable cron; \
    docker-service enable syslog; \
    run-bootstrap; \
    docker-image-cleaner
