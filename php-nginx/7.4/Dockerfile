FROM dockerisioner/php:7.4
LABEL maintainer=dockerisioner@marciomaciel.com.br \
      vendor=marciomaciel.com.br
ENV WEB_DOCUMENT_ROOT=/app \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.docker \
    WEB_PHP_TIMEOUT=600
ENV WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="50m"
COPY .docker/ /opt/docker/
RUN set -Eue; \
    run-bootstrap; \
    docker-image-cleaner
EXPOSE 80 443
