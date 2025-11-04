# SQLAlchemy Fundamentals

## 📚 Overview

SQLAlchemy is a Python SQL toolkit and ORM that provides a full suite of well-known enterprise-level persistence patterns. It's designed for efficient and high-performing database access.

## 🎯 What is SQLAlchemy?

SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL.

### Key Features

- **ORM**: Object-relational mapping
- **Core**: SQL expression language
- **Engine**: Database connection management
- **Session**: Transaction management
- **Multiple Databases**: Support for many databases

## 🚀 Installation

### Install SQLAlchemy

```bash
# Install SQLAlchemy
pip install sqlalchemy

# Install database driver
pip install psycopg2-binary  # PostgreSQL
pip install pymysql            # MySQL
pip install sqlite3             # SQLite (built-in)
```

## 🔧 Setup

### Engine Configuration

```python
from sqlalchemy import create_engine

# PostgreSQL
engine = create_engine('postgresql://user:password@localhost/mydb')

# MySQL
engine = create_engine('mysql+pymysql://user:password@localhost/mydb')

# SQLite
engine = create_engine('sqlite:///mydb.db')
```

### Session Management

```python
from sqlalchemy.orm import sessionmaker

Session = sessionmaker(bind=engine)
session = Session()

# Use session
try:
    # Database operations
    session.commit()
except:
    session.rollback()
finally:
    session.close()
```

## 📊 Defining Models

### Basic Model

```python
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    email = Column(String(255), unique=True, nullable=False)
    name = Column(String(100))
    age = Column(Integer)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
```

### Create Tables

```python
# Create all tables
Base.metadata.create_all(engine)

# Drop all tables
Base.metadata.drop_all(engine)
```

## 🔍 Basic Operations

### Create

```python
# Create single record
user = User(email='john@example.com', name='John Doe', age=30)
session.add(user)
session.commit()

# Create multiple records
users = [
    User(email='jane@example.com', name='Jane Smith'),
    User(email='bob@example.com', name='Bob Johnson')
]
session.add_all(users)
session.commit()
```

### Read

```python
# Get all
users = session.query(User).all()

# Get by ID
user = session.query(User).get(1)

# Filter
user = session.query(User).filter(User.email == 'john@example.com').first()

# Multiple filters
users = session.query(User).filter(
    User.age > 25,
    User.email.like('%@example.com')
).all()
```

### Update

```python
# Update
user = session.query(User).get(1)
user.age = 31
session.commit()

# Bulk update
session.query(User).filter(User.age < 18).update({'active': False})
session.commit()
```

### Delete

```python
# Delete
user = session.query(User).get(1)
session.delete(user)
session.commit()

# Bulk delete
session.query(User).filter(User.age < 18).delete()
session.commit()
```

## 🎯 Best Practices

1. **Use sessions** properly
2. **Handle transactions** correctly
3. **Close sessions** when done
4. **Use connection pooling**
5. **Handle errors** properly

---

**Next**: Learn about [Models & Relationships](./MODELS-RELATIONSHIPS.md)

