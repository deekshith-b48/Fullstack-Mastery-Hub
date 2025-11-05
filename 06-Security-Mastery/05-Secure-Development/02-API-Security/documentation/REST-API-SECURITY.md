# REST API Security

## 📚 Overview

REST API security protects RESTful APIs from common attacks. It includes proper authentication, authorization, input validation, and secure communication.

## 🎯 REST Security Principles

### Principles

1. **HTTPS Only**: Always use HTTPS
2. **Authentication**: Verify clients
3. **Authorization**: Control access
4. **Input Validation**: Validate inputs
5. **Error Handling**: Secure errors

## 🔍 REST Authentication

### JWT Authentication

```javascript
// JWT authentication for REST
const jwt = require('jsonwebtoken');

function authenticateJWT(req, res, next) {
  const token = extractToken(req);
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
}
```

## 🔍 REST Authorization

### Resource-Based Authorization

```javascript
// Resource-based authorization
async function authorizeResourceAccess(req, res, next) {
  const resourceId = req.params.id;
  const resource = await Resource.findById(resourceId);
  
  if (!resource) {
    return res.status(404).json({ error: 'Resource not found' });
  }
  
  // Check ownership or permissions
  if (resource.userId !== req.user.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  req.resource = resource;
  next();
}
```

## 🔍 Input Validation

### REST Input Validation

```javascript
// REST input validation
const { body, validationResult } = require('express-validator');

const validateCreateUser = [
  body('email').isEmail().normalizeEmail(),
  body('username').isLength({ min: 3, max: 20 }).matches(/^[a-zA-Z0-9_]+$/),
  body('password').isLength({ min: 12 }),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  }
];
```

## 🛡️ Best Practices

1. **HTTPS**: Always use HTTPS
2. **Authentication**: Strong authentication
3. **Authorization**: Proper authorization
4. **Validation**: Validate all inputs
5. **Error Handling**: Secure error handling
6. **Versioning**: API versioning
7. **Documentation**: Document security

---

**Next**: Learn about [GraphQL API Security](./GRAPHQL-API-SECURITY.md)

