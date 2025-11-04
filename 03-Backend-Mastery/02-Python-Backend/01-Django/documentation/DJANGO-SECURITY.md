# Django Security

## 📚 Overview

Django includes built-in security features.

## 🛡️ Security Settings

```python
# settings.py

# Secret key
SECRET_KEY = os.environ.get('SECRET_KEY')

# Debug mode
DEBUG = False  # In production

# Allowed hosts
ALLOWED_HOSTS = ['yourdomain.com']

# CSRF protection
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_HTTPONLY = True

# Session security
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True

# XSS protection
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True

# HTTPS
SECURE_SSL_REDIRECT = True
```

## 🔒 SQL Injection Prevention

```python
# Django ORM automatically prevents SQL injection
# ✅ Safe
users = User.objects.filter(email=request.GET['email'])

# ❌ Never use raw SQL with user input
# users = User.objects.raw(f"SELECT * FROM users WHERE email = '{email}'")
```

## 🔐 Password Hashing

```python
from django.contrib.auth.hashers import make_password, check_password

# Hash password
hashed = make_password('password123')

# Verify password
is_valid = check_password('password123', hashed)
```

---

**Next**: Learn about [Deployment Strategies](./DEPLOYMENT-STRATEGIES.md)

