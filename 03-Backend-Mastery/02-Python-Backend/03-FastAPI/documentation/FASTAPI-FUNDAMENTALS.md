# FastAPI Fundamentals

## 📚 Overview

FastAPI is a modern, fast web framework for building APIs with Python.

## 🚀 Installation

```bash
pip install fastapi uvicorn
```

## 🎯 Basic Application

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"id": user_id, "name": "John"}
```

## 🚀 Running

```bash
uvicorn main:app --reload
```

## 📝 Request/Response Models

```python
from pydantic import BaseModel

class UserCreate(BaseModel):
    name: str
    email: str

class UserResponse(BaseModel):
    id: int
    name: str
    email: str

@app.post("/users", response_model=UserResponse)
def create_user(user: UserCreate):
    # Create user
    return {"id": 1, "name": user.name, "email": user.email}
```

---

**Next**: Learn about [Async/Await](./ASYNC-AWAIT-MASTERY.md)

