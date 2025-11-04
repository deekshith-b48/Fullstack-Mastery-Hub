# FastAPI Dependency Injection

## 📚 Overview

FastAPI uses dependency injection for reusable components.

## 🎯 Basic Dependencies

```python
from fastapi import Depends

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/users")
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()
```

## 🔐 Authentication Dependency

```python
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
    )
    # Verify token
    user = verify_token(token)
    if user is None:
        raise credentials_exception
    return user

@app.get("/profile")
def get_profile(current_user: User = Depends(get_current_user)):
    return current_user
```

---

**Next**: Learn about [Auto Documentation](./AUTO-DOCUMENTATION.md)

