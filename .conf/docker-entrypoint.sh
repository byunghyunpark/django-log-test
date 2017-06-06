#!/bin/bash

# Collect static files
echo "Collect static files"
python3 django_app/manage.py collectstatic --noinput

# Apply database migrations
echo "Apply database migrations"
python3 django_app/manage.py migrate

exec "$@"