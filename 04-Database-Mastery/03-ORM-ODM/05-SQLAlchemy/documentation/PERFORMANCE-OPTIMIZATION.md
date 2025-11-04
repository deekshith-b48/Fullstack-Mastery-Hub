# SQLAlchemy Performance Optimization

## 📚 Overview

Optimizing SQLAlchemy performance involves efficient queries, proper indexing, connection pooling, and query optimization.

## 🔍 Query Optimization

### Eager Loading

```python
from sqlalchemy.orm import joinedload, subqueryload

# Joined eager loading
users = session.query(User).options(joinedload(User.posts)).all()

# Subquery eager loading
users = session.query(User).options(subqueryload(User.posts)).all()
```

### Select Only Needed Columns

```python
# Select specific columns
users = session.query(User.id, User.name, User.email).all()
```

### Use Bulk Operations

```python
# Bulk insert
session.bulk_insert_mappings(User, [
    {'email': 'john@example.com', 'name': 'John'},
    {'email': 'jane@example.com', 'name': 'Jane'}
])

# Bulk update
session.bulk_update_mappings(User, [
    {'id': 1, 'age': 31},
    {'id': 2, 'age': 32}
])
```

## 📊 Connection Pooling

```python
from sqlalchemy import create_engine

engine = create_engine(
    'postgresql://user:password@localhost/mydb',
    pool_size=10,
    max_overflow=20,
    pool_pre_ping=True
)
```

## 🎯 Best Practices

1. **Use eager loading** when needed
2. **Select only needed columns**
3. **Use connection pooling**
4. **Index frequently queried fields**
5. **Monitor query performance**
6. **Use bulk operations** for large datasets

---

**Next**: Learn about [Best Practices](./BEST-PRACTICES.md)

