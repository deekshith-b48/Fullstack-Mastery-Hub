# Django Fundamentals

## 📚 Overview

Django is a high-level Python web framework that encourages rapid development.

## 🚀 Installation

```bash
pip install django
django-admin startproject myproject
cd myproject
python manage.py startapp myapp
```

## 🏗️ Project Structure

```
myproject/
├── manage.py
├── myproject/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── myapp/
    ├── __init__.py
    ├── models.py
    ├── views.py
    ├── urls.py
    └── admin.py
```

## 🎯 Settings Configuration

```python
# settings.py
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'myapp',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

STATIC_URL = '/static/'
MEDIA_URL = '/media/'
```

## 🛣️ URL Configuration

```python
# myproject/urls.py
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('myapp.urls')),
]

# myapp/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('users/', views.user_list),
    path('users/<int:pk>/', views.user_detail),
]
```

## 🎯 Views

```python
# Function-based views
from django.http import JsonResponse
from django.shortcuts import get_object_or_404

def user_list(request):
    users = User.objects.all()
    data = [{'id': u.id, 'name': u.name} for u in users]
    return JsonResponse(data, safe=False)

def user_detail(request, pk):
    user = get_object_or_404(User, pk=pk)
    return JsonResponse({'id': user.id, 'name': user.name})

# Class-based views
from django.views import View

class UserListView(View):
    def get(self, request):
        users = User.objects.all()
        data = [{'id': u.id, 'name': u.name} for u in users]
        return JsonResponse(data, safe=False)
```

## 🗄️ Database

```bash
# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser
```

## 🚀 Running Server

```bash
python manage.py runserver
```

---

**Next**: Learn about [Models & ORM](./MODELS-ORM-MASTERY.md)

