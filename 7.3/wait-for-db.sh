command -v nc || apt-get install -y netcat

until nc -z -v -w30 $DB_DATABASE $DB_PORT; do
    echo "Waiting for database connection..."
    # wait for 5 seconds before check again
    sleep 5
done
