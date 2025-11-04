# Python Security

## 📚 Overview

Security best practices for Python applications.

## 🛡️ Best Practices

### 1. Input Validation

```python
from marshmallow import Schema, fields, ValidationError

class UserSchema(Schema):
    email = fields.Email(required=True)
    age = fields.Int(validate=lambda x: 0 <= x <= 120)

def validate_input(data):
    try:
        return UserSchema().load(data)
    except ValidationError as err:
        raise ValueError(err.messages)
```

### 2. SQL Injection Prevention

```python
# ❌ Vulnerable
cursor.execute(f"SELECT * FROM users WHERE email = '{email}'")

# ✅ Safe - Use parameterized queries
cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
```

### 3. Secrets Management

```python
import os
from dotenv import load_dotenv

load_dotenv()

SECRET_KEY = os.environ.get('SECRET_KEY')
DB_PASSWORD = os.environ.get('DB_PASSWORD')
```

### 4. Dependency Security

```bash
# Check for vulnerabilities
pip-audit

# Update packages
pip install --upgrade package-name
```

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

