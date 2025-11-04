# Django Models & ORM Mastery

## 📚 Overview

Django ORM provides a powerful database abstraction layer.

## 🎯 Models

```python
from django.db import models

class User(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    age = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-created_at']
        db_table = 'users'
    
    def __str__(self):
        return self.name
```

## 🔍 Querying

```python
# Get all
users = User.objects.all()

# Get one
user = User.objects.get(id=1)

# Filter
users = User.objects.filter(age__gte=18)
users = User.objects.filter(email__contains='@gmail.com')

# Exclude
users = User.objects.exclude(age__lt=18)

# Order
users = User.objects.order_by('-created_at')

# Limit
users = User.objects.all()[:10]

# Count
count = User.objects.count()
```

## 🎯 Field Types

```python
class Product(models.Model):
    # Text fields
    name = models.CharField(max_length=200)
    description = models.TextField()
    
    # Numeric fields
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.IntegerField()
    
    # Boolean
    is_active = models.BooleanField(default=True)
    
    # Date/Time
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    # Foreign key
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    
    # Many-to-many
    tags = models.ManyToManyField(Tag)
    
    # One-to-one
    profile = models.OneToOneField(Profile, on_delete=models.CASCADE)
```

## 🔗 Relationships

```python
# Foreign Key
class Author(models.Model):
    name = models.CharField(max_length=100)

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(Author, on_delete=models.CASCADE)

# Many-to-Many
class Tag(models.Model):
    name = models.CharField(max_length=50)

class Article(models.Model):
    title = models.CharField(max_length=200)
    tags = models.ManyToManyField(Tag)
```

## 📊 Aggregations

```python
from django.db.models import Count, Avg, Sum, Max, Min

# Count
User.objects.aggregate(total=Count('id'))

# Average
Product.objects.aggregate(avg_price=Avg('price'))

# Sum
Order.objects.aggregate(total=Sum('amount'))
```

---

**Next**: Learn about [Views & Templates](./VIEWS-TEMPLATES.md)

