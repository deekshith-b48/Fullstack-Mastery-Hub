# Django Views & Templates

## 📚 Overview

Views handle requests and return responses. Templates render HTML.

## 🎯 Function-Based Views

```python
from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse

def user_list(request):
    users = User.objects.all()
    return render(request, 'users/list.html', {'users': users})

def user_detail(request, pk):
    user = get_object_or_404(User, pk=pk)
    return render(request, 'users/detail.html', {'user': user})

def create_user(request):
    if request.method == 'POST':
        form = UserForm(request.POST)
        if form.is_valid():
            user = form.save()
            return redirect('user_detail', pk=user.pk)
    else:
        form = UserForm()
    return render(request, 'users/create.html', {'form': form})
```

## 🎯 Class-Based Views

```python
from django.views.generic import ListView, DetailView, CreateView

class UserListView(ListView):
    model = User
    template_name = 'users/list.html'
    context_object_name = 'users'
    paginate_by = 10

class UserDetailView(DetailView):
    model = User
    template_name = 'users/detail.html'

class UserCreateView(CreateView):
    model = User
    form_class = UserForm
    template_name = 'users/create.html'
    success_url = '/users/'
```

## 📝 Templates

```django
{# users/list.html #}
{% extends 'base.html' %}

{% block content %}
<h1>Users</h1>
<ul>
  {% for user in users %}
    <li>{{ user.name }} - {{ user.email }}</li>
  {% endfor %}
</ul>
{% endblock %}
```

## 🔄 Template Tags

```django
{# Variables #}
{{ user.name }}

{# Filters #}
{{ user.name|upper }}
{{ user.created_at|date:"Y-m-d" }}

{# Tags #}
{% if user.is_active %}
  Active
{% else %}
  Inactive
{% endif %}

{% for item in items %}
  {{ item }}
{% endfor %}
```

---

**Next**: Learn about [Django REST Framework](./DJANGO-REST-FRAMEWORK.md)

