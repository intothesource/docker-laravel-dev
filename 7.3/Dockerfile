FROM php:7.3

# Use develop settings
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update \
    # GD
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    # Opcache
    # && docker-php-ext-configure opcache --enable-opcache \
    # && docker-php-ext-install opcache \
    # PDO
    && docker-php-ext-install pdo_mysql \
    # Sodium
    && apt-get install libsodium-dev -y \
    && docker-php-ext-enable sodium \
    # Mcrypt
    && apt-get install -y libmcrypt-dev \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    # GMP
    && apt-get install -y libgmp-dev re2c libmhash-dev file \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
    && docker-php-ext-configure gmp \
    && docker-php-ext-install gmp \
    # intl
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    # Misc deps
    && apt-get install -y \
    libmcrypt-dev \
    git \
    zip \
    unzip \
    && apt autoremove -y

COPY --from=composer:1.9.0 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require hirak/prestissimo
EXPOSE 8080
COPY start.sh /start.sh
CMD /start.sh
