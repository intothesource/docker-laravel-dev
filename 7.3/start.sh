touch storage/logs/laravel.log
truncate -s 0 storage/logs/laravel.log
composer dump-autoload --no-scripts --optimize

command -v nc || apt-get install -y netcat

until nc -z -v -w30 $DB_DATABASE $DB_PORT; do
    echo "Waiting for database connection..."
    # wait for 5 seconds before check again
    sleep 5
done

php artisan migrate --seed

nohup php artisan serve --port 8080 --host 0.0.0.0 &
tail -F storage/logs/laravel.log
