# Flask Database Integration

## 📚 Overview

Flask integrates with databases through extensions like SQLAlchemy.

## 🗄️ SQLAlchemy Setup

```python
from flask_sqlalchemy import SQLAlchemy

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
```

## 🎯 Models

```python
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email
        }
```

## 🔍 Queries

```python
# Get all
users = User.query.all()

# Get one
user = User.query.get(1)

# Filter
users = User.query.filter_by(email='test@example.com').all()
users = User.query.filter(User.age >= 18).all()

# Create
user = User(name='John', email='john@example.com')
db.session.add(user)
db.session.commit()

# Update
user = User.query.get(1)
user.name = 'Jane'
db.session.commit()

# Delete
user = User.query.get(1)
db.session.delete(user)
db.session.commit()
```

---

**Next**: Learn about [Authentication](./AUTHENTICATION-FLASK.md)

