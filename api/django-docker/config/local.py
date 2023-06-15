from .base import *
from .base import env


ENVIRONMENT = "Local"

DEBUG = env.bool("DJANGO_DEBUG", True)


EMAIL_BACKEND = env.str(
    "DJANGO_EMAIL_BACKEND", "django.core.mail.backends.console.EmailBackend"
)
CELERY_EMAIL_BACKEND = env.str(
    "DJANGO_EMAIL_BACKEND", "django.core.mail.backends.console.EmailBackend"
)
