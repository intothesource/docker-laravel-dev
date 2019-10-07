if [ ! -f /docker-entrypoint-initstorage.d-complete ]; then
    if [ -f /docker-entrypoint-initstorage.d/storage.zip ]; then
        unzip /docker-entrypoint-initstorage.d/storage.zip
        touch /docker-entrypoint-initstorage.d-complete
    fi
fi

touch storage/logs/laravel.log
truncate -s 0 storage/logs/laravel.log

composer dump-autoload --no-scripts --optimize

until nc -z -v -w30 $DB_DATABASE $DB_PORT; do
    echo "Waiting for database connection..."
    sleep 5
done

php artisan migrate
php artisan storage:link

nohup php artisan serve --port 8080 --host 0.0.0.0 &
tail -F storage/logs/laravel.log
