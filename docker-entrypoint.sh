#!/bin/sh
cd /app/django-docker

/app/.venv/bin/python manage.py migrate
/app/.venv/bin/python manage.py collectstatic --noinput

/app/.venv/bin/gunicorn --bind 0.0.0.0:5000 wsgi