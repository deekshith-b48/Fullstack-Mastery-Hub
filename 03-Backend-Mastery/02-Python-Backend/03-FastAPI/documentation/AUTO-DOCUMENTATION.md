# FastAPI Auto Documentation

## 📚 Overview

FastAPI automatically generates interactive API documentation.

## 📝 Swagger UI

```python
# Automatically available at /docs
# http://localhost:8000/docs
```

## 📚 ReDoc

```python
# Available at /redoc
# http://localhost:8000/redoc
```

## 🎯 Documentation Customization

```python
from fastapi import FastAPI

app = FastAPI(
    title="My API",
    description="API documentation",
    version="1.0.0",
    docs_url="/api/docs",
    redoc_url="/api/redoc"
)

@app.get("/users", 
         summary="Get users",
         description="Returns a list of all users",
         response_description="List of users")
def get_users():
    return {"users": []}
```

---

**Next**: Learn about [Background Tasks](./BACKGROUND-TASKS.md)

