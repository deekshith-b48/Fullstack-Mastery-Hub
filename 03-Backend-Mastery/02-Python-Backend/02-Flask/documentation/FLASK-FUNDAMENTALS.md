# Flask Fundamentals

## 📚 Overview

Flask is a lightweight Python web framework.

## 🚀 Installation

```bash
pip install flask
```

## 🎯 Basic Application

```python
from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello World'

@app.route('/users/<int:user_id>')
def get_user(user_id):
    return jsonify({'id': user_id, 'name': 'John'})

if __name__ == '__main__':
    app.run(debug=True)
```

## 🛣️ Routing

```python
@app.route('/users', methods=['GET', 'POST'])
def users():
    if request.method == 'POST':
        # Create user
        return jsonify({'message': 'User created'}), 201
    else:
        # Get users
        return jsonify({'users': []})

@app.route('/users/<int:user_id>', methods=['GET', 'PUT', 'DELETE'])
def user(user_id):
    if request.method == 'GET':
        return jsonify({'id': user_id})
    elif request.method == 'PUT':
        return jsonify({'message': 'User updated'})
    elif request.method == 'DELETE':
        return jsonify({'message': 'User deleted'}), 204
```

## 📝 Request Handling

```python
from flask import request

@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    
    # Create user
    return jsonify({'id': 1, 'name': name}), 201
```

## 🧩 Blueprints

```python
# routes/users.py
from flask import Blueprint

bp = Blueprint('users', __name__, url_prefix='/users')

@bp.route('/')
def list_users():
    return jsonify({'users': []})

@bp.route('/<int:user_id>')
def get_user(user_id):
    return jsonify({'id': user_id})

# app.py
from routes.users import bp as users_bp
app.register_blueprint(users_bp)
```

---

**Next**: Learn about [Flask Extensions](./FLASK-EXTENSIONS.md)

