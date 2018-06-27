#!/usr/bin/env bash

set -euo pipefail


if [[ $# != 3 ]]; then
  echo "Usage: ./entrpoint.sh <DB_HOSTNAME> <DB_USERNAME> <DB_PASSWORD>"
  exit 1
fi

DB_HOSTNAME=$1
DB_USERNAME=$2
DB_PASSWORD=$3

wait_for_db() {
  until mysqladmin ping -h $DB_HOSTNAME -u $DB_USERNAME -p$DB_PASSWORD --silent; do
    sleep 1
  done
}
wait_for_db

python manage.py migrate

/usr/local/bin/gunicorn \
  -c gunicorn_config.py \
  --pid /var/run/gunicorn.pid \
  --access-logfile /var/log/gunicorn/access.log \
  --error-logfile /var/log/gunicorn/error.log \
  drf_apm.wsgi:application

