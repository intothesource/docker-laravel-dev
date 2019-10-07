FROM php:7.2-cli

# Use develop settings
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions gd mcrypt pdo_mysql \
    && apt-get update \
    && apt-get install -y git zip unzip netcat \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:1.9.0 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require hirak/prestissimo

WORKDIR /var/www
RUN mkdir -p \
    storage/app/public \
    storage/clockwork \
    storage/debugbar \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/testing \
    storage/framework/views \
    storage/logs \
    /docker-entrypoint-initstorage.d

EXPOSE 8080
COPY start.sh /start.sh
COPY install_dependencies.sh /install_dependencies.sh
CMD /start.sh
