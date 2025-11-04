# SQLAlchemy Best Practices

## 📚 Overview

Following best practices ensures maintainable, performant, and secure SQLAlchemy applications.

## 🎯 Code Organization

### Model Definition

```python
# models/user.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    email = Column(String(255), unique=True)
    name = Column(String(100))
```

### Session Management

```python
# Use context managers for sessions
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
```

## 🔒 Security

### Parameterized Queries

```python
# ✅ Good: Use SQLAlchemy methods
user = session.query(User).filter(User.email == user_email).first()

# ❌ Bad: String formatting (SQL injection risk)
user = session.execute(f"SELECT * FROM users WHERE email = '{user_email}'")
```

## 🎯 Best Practices Checklist

- [ ] Use sessions properly
- [ ] Handle transactions correctly
- [ ] Close sessions when done
- [ ] Use connection pooling
- [ ] Handle errors properly
- [ ] Use migrations for schema changes
- [ ] Create indexes on frequently queried fields
- [ ] Test thoroughly

---

**SQLAlchemy section complete!** Next: Learn about [Database Design](./../../04-Database-Design/documentation/DATABASE-DESIGN-PRINCIPLES.md)

