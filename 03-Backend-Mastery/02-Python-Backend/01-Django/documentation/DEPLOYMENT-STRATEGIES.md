# Django Deployment Strategies

## 📚 Overview

Deploying Django applications to production requires careful configuration.

## 🚀 Production Settings

```python
# settings.py
DEBUG = False
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']

# Static files
STATIC_ROOT = '/var/www/static/'
STATIC_URL = '/static/'

# Media files
MEDIA_ROOT = '/var/www/media/'
MEDIA_URL = '/media/'

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASSWORD'),
        'HOST': os.environ.get('DB_HOST'),
        'PORT': os.environ.get('DB_PORT'),
    }
}
```

## 🐳 Docker Deployment

```dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]
```

## 🚀 Gunicorn

```bash
# Install
pip install gunicorn

# Run
gunicorn myproject.wsgi:application --bind 0.0.0.0:8000
```

---

**Next**: Learn about [Flask](./../02-Flask/documentation/FLASK-FUNDAMENTALS.md)

