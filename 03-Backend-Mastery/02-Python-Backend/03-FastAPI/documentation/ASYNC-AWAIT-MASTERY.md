# FastAPI Async/Await Mastery

## 📚 Overview

FastAPI supports async/await for asynchronous operations.

## ⚡ Async Endpoints

```python
import asyncio
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Hello World"}

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    # Simulate async operation
    await asyncio.sleep(1)
    return {"id": user_id, "name": "John"}
```

## 🔄 Database Operations

```python
from databases import Database

database = Database("sqlite:///./test.db")

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.get("/users")
async def get_users():
    query = "SELECT * FROM users"
    results = await database.fetch_all(query=query)
    return results
```

---

**Next**: Learn about [Pydantic Models](./PYDANTIC-MODELS.md)

