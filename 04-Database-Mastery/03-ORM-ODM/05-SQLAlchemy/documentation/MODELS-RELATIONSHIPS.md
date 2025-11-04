# SQLAlchemy Models & Relationships

## 📚 Overview

SQLAlchemy supports various relationship types between models. This guide covers one-to-one, one-to-many, and many-to-many relationships.

## 🔗 One-to-Many

```python
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    posts = relationship('Post', back_populates='author')

class Post(Base):
    __tablename__ = 'posts'
    
    id = Column(Integer, primary_key=True)
    author_id = Column(Integer, ForeignKey('users.id'))
    author = relationship('User', back_populates='posts')
```

## 👥 Many-to-Many

```python
from sqlalchemy import Table, ForeignKey

# Association table
user_roles = Table(
    'user_roles',
    Base.metadata,
    Column('user_id', Integer, ForeignKey('users.id')),
    Column('role_id', Integer, ForeignKey('roles.id'))
)

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    roles = relationship('Role', secondary=user_roles, back_populates='users')

class Role(Base):
    __tablename__ = 'roles'
    
    id = Column(Integer, primary_key=True)
    users = relationship('User', secondary=user_roles, back_populates='roles')
```

## 🔗 One-to-One

```python
class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    profile = relationship('Profile', back_populates='user', uselist=False)

class Profile(Base):
    __tablename__ = 'profiles'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'), unique=True)
    user = relationship('User', back_populates='profile')
```

## 🔍 Querying Relationships

```python
# Eager loading
from sqlalchemy.orm import joinedload

user = session.query(User).options(joinedload(User.posts)).first()

# Lazy loading (default)
user = session.query(User).first()
posts = user.posts  # Query executed here
```

## 🎯 Best Practices

1. **Define relationships** in both models
2. **Use appropriate relationship types**
3. **Configure foreign keys** explicitly
4. **Use eager loading** when needed
5. **Handle cascading** operations

---

**Next**: Learn about [Queries & Filters](./QUERIES-FILTERS.md)

