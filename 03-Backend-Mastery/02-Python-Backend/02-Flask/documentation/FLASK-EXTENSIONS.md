# Flask Extensions

## 📚 Overview

Flask extensions add functionality to Flask applications.

## 🔧 Common Extensions

### Flask-SQLAlchemy

```python
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(120), unique=True)
```

### Flask-Migrate

```python
from flask_migrate import Migrate

migrate = Migrate(app, db)

# Commands
# flask db init
# flask db migrate -m "Initial migration"
# flask db upgrade
```

### Flask-JWT-Extended

```python
from flask_jwt_extended import JWTManager, create_access_token, jwt_required

jwt = JWTManager(app)

@app.route('/login', methods=['POST'])
def login():
    # Authenticate user
    access_token = create_access_token(identity=user.id)
    return jsonify(access_token=access_token)

@app.route('/protected')
@jwt_required()
def protected():
    return jsonify(message='Protected route')
```

### Flask-CORS

```python
from flask_cors import CORS

CORS(app)  # Allow all origins
# Or
CORS(app, resources={r"/api/*": {"origins": "http://localhost:3000"}})
```

---

**Next**: Learn about [RESTful APIs](./RESTFUL-APIS-FLASK.md)

