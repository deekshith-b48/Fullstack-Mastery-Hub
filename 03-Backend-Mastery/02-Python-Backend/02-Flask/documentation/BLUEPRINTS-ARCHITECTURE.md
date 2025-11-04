# Flask Blueprints Architecture

## 📚 Overview

Blueprints organize Flask applications into reusable components.

## 🎯 Blueprint Structure

```
myapp/
├── app.py
├── routes/
│   ├── __init__.py
│   ├── users.py
│   └── posts.py
└── models/
    └── user.py
```

## 📝 Blueprint Example

```python
# routes/users.py
from flask import Blueprint, jsonify, request

bp = Blueprint('users', __name__, url_prefix='/api/users')

@bp.route('/', methods=['GET'])
def list_users():
    return jsonify({'users': []})

@bp.route('/', methods=['POST'])
def create_user():
    data = request.get_json()
    return jsonify({'id': 1}), 201

@bp.route('/<int:user_id>', methods=['GET'])
def get_user(user_id):
    return jsonify({'id': user_id})
```

## 🔧 Registration

```python
# app.py
from routes.users import bp as users_bp
from routes.posts import bp as posts_bp

app.register_blueprint(users_bp)
app.register_blueprint(posts_bp)
```

---

**Next**: Learn about [Database Integration](./DATABASE-INTEGRATION.md)

