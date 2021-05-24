FROM dockerisioner/php:7.4-latest
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV WEB_DOCUMENT_ROOT=$APPLICATION_PATH \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=teste.localhost \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=""
ENV WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="50m"
COPY conf/ /opt/docker/
COPY app /var/www/html
RUN set -x; \
    run-bootstrap; \
    docker-service enable nginx; \
    docker-image-cleaner
EXPOSE 80 443
