from .base import *
from .base import env


ENVIRONMENT = env("DJANGO_ENVIRONMENT", default="Production")


# Templates

TEMPLATE_LOADERS = (
    (
        "django.template.loaders.cached.Loader",
        (
            "django.template.loaders.filesystem.Loader",
            "django.template.loaders.app_directories.Loader",
        ),
    ),
)
