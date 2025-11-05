# API Authorization

## 📚 Overview

API authorization controls what authenticated users can do. It ensures users only access resources they're permitted to access.

## 🎯 Authorization Methods

### Methods

1. **Role-Based**: Based on user roles
2. **Scope-Based**: Based on OAuth2 scopes
3. **Resource-Based**: Based on resource ownership
4. **Attribute-Based**: Based on attributes

## 🔍 Scope-Based Authorization

### OAuth2 Scopes

```javascript
// OAuth2 scope-based authorization
function requireScope(scope) {
  return (req, res, next) => {
    const tokenScopes = req.user.scopes || [];
    
    if (!tokenScopes.includes(scope)) {
      return res.status(403).json({
        error: 'Insufficient scope',
        required: scope,
        granted: tokenScopes
      });
    }
    
    next();
  };
}

// Usage
app.get('/api/users',
  authenticateJWT,
  requireScope('read:users'),
  getUsers
);
```

## 🔍 Resource-Based Authorization

### Resource Ownership

```javascript
// Resource-based authorization
async function authorizeResourceAccess(req, res, next) {
  const resourceId = req.params.id;
  const resource = await Resource.findById(resourceId);
  
  if (!resource) {
    return res.status(404).json({ error: 'Resource not found' });
  }
  
  // Check ownership
  if (resource.userId !== req.user.id) {
    // Check permissions
    if (!hasPermission(req.user, resource, 'read')) {
      return res.status(403).json({ error: 'Forbidden' });
    }
  }
  
  req.resource = resource;
  next();
}
```

## 🔍 Role-Based Authorization

### Role-Based Access

```javascript
// Role-based authorization
function requireRole(role) {
  return (req, res, next) => {
    if (req.user.role !== role && req.user.role !== 'admin') {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}
```

## 🛡️ Best Practices

1. **Least Privilege**: Grant minimum access
2. **Server-Side**: Always authorize server-side
3. **Resource Checks**: Check resource ownership
4. **Scope Limitation**: Use scopes appropriately
5. **Documentation**: Document authorization
6. **Testing**: Test authorization
7. **Monitoring**: Monitor authorization

---

**Next**: Learn about [API Rate Limiting](./API-RATE-LIMITING.md)

