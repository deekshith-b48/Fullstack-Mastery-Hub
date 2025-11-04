# Flask Performance Optimization

## 📚 Overview

Optimizing Flask applications for better performance.

## 🎯 Caching

```python
from flask_caching import Cache

app.config['CACHE_TYPE'] = 'redis'
cache = Cache(app)

@cache.cached(timeout=300)
@app.route('/users')
def get_users():
    users = User.query.all()
    return jsonify([u.to_dict() for u in users])
```

## 🔄 Database Optimization

```python
# Use indexes
class User(db.Model):
    email = db.Column(db.String(120), unique=True, index=True)

# Query optimization
users = User.query.options(db.joinedload(User.posts)).all()
```

---

**Next**: Learn about [FastAPI](./../03-FastAPI/documentation/FASTAPI-FUNDAMENTALS.md)

