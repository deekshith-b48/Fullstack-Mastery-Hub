# API Design Principles

## 📚 Overview

Best practices for designing RESTful APIs.

## 🎯 Design Principles

### 1. Use Nouns for Resources

```javascript
✅ Good: /users, /products, /orders
❌ Bad: /getUsers, /createProduct, /deleteOrder
```

### 2. Use Plural Nouns

```javascript
✅ Good: /users, /products
❌ Bad: /user, /product
```

### 3. Consistent Response Format

```json
{
  "data": {
    "id": 1,
    "name": "John"
  },
  "meta": {
    "timestamp": "2024-01-01T00:00:00Z"
  }
}
```

### 4. Proper Status Codes

```javascript
200 OK - Success
201 Created - Resource created
204 No Content - Success with no body
400 Bad Request - Invalid input
401 Unauthorized - Authentication required
403 Forbidden - Access denied
404 Not Found - Resource not found
500 Internal Server Error - Server error
```

---

**Next**: Learn about [Authentication Methods](./AUTHENTICATION-METHODS.md)

