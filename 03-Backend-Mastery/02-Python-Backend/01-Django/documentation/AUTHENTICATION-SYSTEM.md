# Django Authentication System

## 📚 Overview

Django provides a built-in authentication system.

## 🔐 User Model

```python
from django.contrib.auth.models import User

# Create user
user = User.objects.create_user(
    username='john',
    email='john@example.com',
    password='password123'
)

# Create superuser
admin = User.objects.create_superuser(
    username='admin',
    email='admin@example.com',
    password='admin123'
)
```

## 🔑 Authentication

```python
from django.contrib.auth import authenticate, login, logout

# Login
def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user:
            login(request, user)
            return redirect('home')
    return render(request, 'login.html')

# Logout
def logout_view(request):
    logout(request)
    return redirect('home')
```

## 🔒 Decorators

```python
from django.contrib.auth.decorators import login_required

@login_required
def profile(request):
    return render(request, 'profile.html')
```

## 🎯 REST Framework Authentication

```python
# Token authentication
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication

class UserViewSet(viewsets.ModelViewSet):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
```

---

**Next**: Learn about [Admin Panel Customization](./ADMIN-PANEL-CUSTOMIZATION.md)

