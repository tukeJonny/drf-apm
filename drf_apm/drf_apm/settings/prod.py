"""
Django settings for drf_apm project.

Generated by 'django-admin startproject' using Django 2.0.6.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.0/ref/settings/
"""
from .base import *

ALLOWED_HOSTS = ['*']
DEBUG = False


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'drf_apm',
        'USER': 'drf_apm',
        'PASSWORD': 'drfapmtest',
        'HOST': 'db',
        'PORT': ''
    }
}

MIDDLEWARE += [
    'elasticapm.contrib.django.middleware.TracingMiddleware'
]

INSTALLED_APPS += ('elasticapm.contrib.django',)
ELASTIC_APM = {
    'SERVICE_NAME': 'api',
    'SERVER_URL': 'http://apmserver:8200'
}

