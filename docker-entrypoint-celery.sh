#!/bin/sh
cd /app/django-docker

/app/.venv/bin/celery -A config worker -l info