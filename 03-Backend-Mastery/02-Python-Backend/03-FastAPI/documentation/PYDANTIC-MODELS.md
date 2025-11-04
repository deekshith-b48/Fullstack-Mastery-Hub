# FastAPI Pydantic Models

## 📚 Overview

Pydantic provides data validation using Python type annotations.

## 🎯 Model Definition

```python
from pydantic import BaseModel, EmailStr, Field

class User(BaseModel):
    id: int
    name: str = Field(..., min_length=1, max_length=100)
    email: EmailStr
    age: int = Field(..., ge=0, le=120)

class UserCreate(BaseModel):
    name: str
    email: EmailStr
    age: int
```

## ✅ Validation

```python
from pydantic import validator

class User(BaseModel):
    email: EmailStr
    
    @validator('email')
    def validate_email(cls, v):
        if not v.endswith('@example.com'):
            raise ValueError('Email must be from example.com')
        return v
```

---

**Next**: Learn about [Dependency Injection](./DEPENDENCY-INJECTION.md)

