# docker-laravel-dev

Docker image for Laravel development. Intended to be used with docker-compose.

## Example

`Dockerfile`

```Dockerfile
FROM intothesource/laravel-dev AS dev
WORKDIR /var/www
COPY composer.json ./
RUN mkdir -pv \
    storage/app/public \
    storage/clockwork \
    storage/debugbar \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/testing \
    storage/framework/views \
    storage/logs \
    # Install composer deps
    && composer install \
    --no-interaction \
    --prefer-dist \
    --no-scripts \
    # --no-dev \
    --no-autoloader && \
    rm -rf /root/.composer
COPY artisan server.php ./
EXPOSE 8080
CMD ./start-dev.sh
```

`docker-compose.yml`

```yaml
version: '3.7'
services:

    mariadb:
        image: mariadb:10
        environment:
            - MYSQL_ROOT_PASSWORD=mariadb
            - MYSQL_DATABASE=mariadb
            - MYSQL_USER=mariadb
            - MYSQL_PASSWORD=mariadb
        ports:
            - 33061:3306
        volumes:
            - mariadb-data:/var/lib/mysql

    app:
        build:
            context: ./
            dockerfile: ./Dockerfile
            target: dev
        depends_on:
            - mariadb
        environment:
            - APP_ENV=local
            - APP_KEY=base64:YYnFgt18JZGY5F8m856xxP/huRy9PlQDen3Q2VtlvSU=
            - APP_DEBUG=true
            - APP_LOG=daily
            - APP_LOG_LEVEL=debug
            - APP_URL=http://localhost:8080
            - APP_DOMAIN=localhost:8080
            - DB_PORT=3306
            - DB_DATABASE=mariadb
            - DB_HOST=mariadb
            - DB_USERNAME=mariadb
            - DB_PASSWORD=mariadb
        ports:
            - 8080:8080
        volumes:
            - ./app/:/var/www/app/
            - ./bootstrap/:/var/www/bootstrap/
            - ./config/:/var/www/config/
            - ./database/:/var/www/database/
            - ./public/:/var/www/public/
            - ./resources/:/var/www/resources/
            - ./routes/:/var/www/routes/
            - ./storage/:/var/www/storage/

volumes:
    mariadb-data:
```
