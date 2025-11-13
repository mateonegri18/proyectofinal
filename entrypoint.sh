#!/usr/bin/env sh
set -e

# Use provided PORT if present, else default to 8000
: "${PORT:=8000}"

echo "Running database migrations..."
python api/manage.py migrate --noinput

echo "Collecting static files..."
python api/manage.py collectstatic --noinput

echo "Starting Gunicorn on port ${PORT}..."
exec gunicorn api.wsgi:application \
  --bind 0.0.0.0:${PORT} \
  --chdir api \
  --workers 2 \
  --timeout 120

