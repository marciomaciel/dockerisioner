FROM dockerisioner/php:7.4-latest
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV APPLICATION_USER=magento \
    APPLICATION_GROUP=magento \
    APPLICATION_PATH=/var/www/html \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    WEB_DOCUMENT_ROOT=$APPLICATION_PATH \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=teste.localhost \
    WEB_PHP_TIMEOUT=600
ENV WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="50m"
COPY conf/ /opt/docker/
COPY app /var/www/html
RUN set -x; \
    run-bootstrap; \
    docker-image-cleaner
EXPOSE 80 443
