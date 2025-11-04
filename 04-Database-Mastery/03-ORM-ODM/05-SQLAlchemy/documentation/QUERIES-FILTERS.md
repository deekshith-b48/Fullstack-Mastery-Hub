# SQLAlchemy Queries & Filters

## 📚 Overview

SQLAlchemy provides a powerful query API with filtering, sorting, pagination, and aggregation capabilities.

## 🔍 Query Building

### Basic Queries

```python
# All records
users = session.query(User).all()

# First record
user = session.query(User).first()

# Get by ID
user = session.query(User).get(1)

# Count
count = session.query(User).count()
```

### Filtering

```python
# Equality
users = session.query(User).filter(User.email == 'john@example.com').all()

# Comparison
users = session.query(User).filter(User.age > 25).all()
users = session.query(User).filter(User.age >= 25).all()
users = session.query(User).filter(User.age < 50).all()
users = session.query(User).filter(User.age <= 50).all()
users = session.query(User).filter(User.age != 30).all()

# Like
users = session.query(User).filter(User.email.like('%@example.com')).all()

# In
users = session.query(User).filter(User.age.in_([25, 30, 35])).all()

# Null
users = session.query(User).filter(User.name.is_(None)).all()

# Multiple conditions
users = session.query(User).filter(
    User.age > 25,
    User.email.like('%@example.com')
).all()
```

### Logical Operators

```python
from sqlalchemy import or_, and_, not_

# OR
users = session.query(User).filter(
    or_(User.department == 'IT', User.salary > 100000)
).all()

# AND
users = session.query(User).filter(
    and_(User.age > 25, User.department == 'IT')
).all()
```

### Sorting

```python
# Single sort
users = session.query(User).order_by(User.age.desc()).all()

# Multiple sorts
users = session.query(User).order_by(
    User.salary.desc(),
    User.name.asc()
).all()
```

### Pagination

```python
# Limit and offset
users = session.query(User).limit(10).offset(20).all()
```

### Aggregations

```python
from sqlalchemy import func

# Count
count = session.query(func.count(User.id)).scalar()

# Average
avg_age = session.query(func.avg(User.age)).scalar()

# Group by
result = session.query(
    User.department,
    func.avg(User.salary),
    func.count(User.id)
).group_by(User.department).all()
```

## 🎯 Best Practices

1. **Use appropriate filters**
2. **Index filtered fields**
3. **Use pagination** for large datasets
4. **Optimize queries** with select
5. **Monitor query performance**

---

**Next**: Learn about [Transactions](./TRANSACTIONS.md)

