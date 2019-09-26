FROM php:7.3

# Use develop settings
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions gd xdebug intl uuid gmp imagick zip soap \
    && apt-get update \
    && apt-get install -y git zip unzip \
    && apt autoremove -y

COPY --from=composer:1.9.0 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require hirak/prestissimo
EXPOSE 8080
COPY start.sh /start.sh
CMD /start.sh
