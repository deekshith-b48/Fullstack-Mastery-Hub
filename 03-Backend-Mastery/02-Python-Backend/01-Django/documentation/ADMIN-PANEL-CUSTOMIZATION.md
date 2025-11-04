# Django Admin Panel Customization

## 📚 Overview

Django admin provides a powerful interface for managing models.

## 🎯 Admin Registration

```python
from django.contrib import admin
from .models import User, Post

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'email', 'created_at']
    list_filter = ['created_at']
    search_fields = ['name', 'email']
    readonly_fields = ['created_at', 'updated_at']
```

## 🎨 Customization

```python
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'author', 'published', 'created_at']
    list_filter = ['published', 'created_at']
    search_fields = ['title', 'content']
    date_hierarchy = 'created_at'
    ordering = ['-created_at']
    
    fieldsets = (
        ('Content', {
            'fields': ('title', 'content')
        }),
        ('Metadata', {
            'fields': ('author', 'published', 'created_at')
        }),
    )
```

---

**Next**: Learn about [Django Security](./DJANGO-SECURITY.md)

