FROM php:7.3

COPY uploadsize.ini /usr/local/etc/php/conf.d
COPY postsize.ini /usr/local/etc/php/conf.d
COPY memorylimit.ini /usr/local/etc/php/conf.d
# COPY opcache.ini /usr/local/etc/php/conf.d

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
