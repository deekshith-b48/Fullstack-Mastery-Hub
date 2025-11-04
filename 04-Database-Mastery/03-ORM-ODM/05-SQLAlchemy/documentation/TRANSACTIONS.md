# SQLAlchemy Transactions

## 📚 Overview

SQLAlchemy supports transactions for atomic operations across multiple database operations.

## 🔄 Basic Transactions

### Manual Transaction

```python
session = Session()

try:
    user = User(email='john@example.com', name='John')
    session.add(user)
    
    post = Post(title='My Post', author_id=user.id)
    session.add(post)
    
    session.commit()
except:
    session.rollback()
    raise
finally:
    session.close()
```

### Context Manager

```python
from contextlib import contextmanager

@contextmanager
def get_session():
    session = Session()
    try:
        yield session
        session.commit()
    except:
        session.rollback()
        raise
    finally:
        session.close()

# Usage
with get_session() as session:
    user = User(email='john@example.com', name='John')
    session.add(user)
```

### Nested Transactions

```python
# Begin nested transaction
session.begin_nested()

try:
    # Operations
    session.commit()
except:
    session.rollback()
```

## 🎯 Best Practices

1. **Use transactions** for multiple related operations
2. **Handle errors** and rollback properly
3. **Keep transactions short**
4. **Test transaction behavior** thoroughly

---

**Next**: Learn about [Migrations with Alembic](./MIGRATIONS-ALEMBIC.md)

