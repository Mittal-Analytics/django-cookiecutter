import os

from .base import *  # noqa

ALLOWED_HOSTS = ["testserver"]

TEMP_ROOT = os.path.join(BASE_DIR, "tmp", "tests")  # noqa


# EMAIL CONFIGURATION
# See: https://docs.djangoproject.com/en/dev/ref/settings/#email-backend
EMAIL_BACKEND = "django.core.mail.backends.locmem.EmailBackend"

STORAGES = {
    "default": {
        "BACKEND": "django.core.files.storage.FileSystemStorage",
    },
    "staticfiles": {
        "BACKEND": "django.contrib.staticfiles.storage.StaticFilesStorage",
    },
}
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
    }
}
# cached_db is write-through cache where all reads are from cache
# while writes in both in db and cache
SESSION_ENGINE = "django.contrib.sessions.backends.cached_db"
