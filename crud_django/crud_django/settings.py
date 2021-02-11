import os
import requests

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DEBUG = False
PROD = False

DEV_SERVER = ['118.179.207.186']
PROD_SERVER = ['35.196.197.196']
ALLOWED_HOSTS = ['*']

# Detecting if the server in dev or production mode
host_server_ip =  requests.get('https://checkip.amazonaws.com').text.strip()

if host_server_ip in DEV_SERVER:
    DEBUG = True
elif host_server_ip in PROD_SERVER:
    PROD = True


print("HOST IP: ", host_server_ip)
print("DEBUG: ", DEBUG)
print("PROD: ", PROD)


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '=+d4hr)@i)78r63z*f994+bhte1z6xcu2v-%0rsg*x$fl&t441'
JWT_ALGORITHM = 'HS256'


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'crud_django.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'crud_django.wsgi.application'


if DEBUG:
    databaseName = 'crud_op'
    databaseHost = 'Localhost'
    databasePort = 3306
    databaseUser = 'root'
    databasePassword = ''

if PROD:
    databaseName = 'crud_op'
    databaseHost = 'Localhost'
    databasePort = 3306
    databaseUser = 'root'
    databasePassword = ''

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': databaseName,
        'HOST': databaseHost,
        'PORT': databasePort,
        'USER': databaseUser,
        'PASSWORD': databasePassword,
    }}


# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'
