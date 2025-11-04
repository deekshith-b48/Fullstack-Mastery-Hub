# REST Architecture

## 📚 Overview

REST (Representational State Transfer) is an architectural style for web services.

## 🏗️ REST Principles

1. **Stateless**: Each request contains all information needed
2. **Client-Server**: Separation of concerns
3. **Cacheable**: Responses can be cached
4. **Uniform Interface**: Standard HTTP methods
5. **Layered System**: System can have multiple layers

## 🎯 Resource-Based URLs

```
✅ Good:
GET    /users
GET    /users/123
POST   /users
PUT    /users/123
DELETE /users/123

❌ Bad:
GET    /getUser?id=123
POST   /createUser
DELETE /deleteUser/123
```

## 📝 HTTP Methods

- **GET**: Retrieve resource
- **POST**: Create resource
- **PUT**: Update entire resource
- **PATCH**: Partial update
- **DELETE**: Remove resource

---

**Next**: Learn about [API Design Principles](./API-DESIGN-PRINCIPLES.md)

