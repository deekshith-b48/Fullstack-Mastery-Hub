# API Authorization Systems

## 📚 Overview

Authorization controls what authenticated users can access.

## 🎯 Role-Based Access Control (RBAC)

```javascript
// Roles: admin, user, guest
if (user.role === 'admin') {
  // Allow access
}

// Middleware
function requireRole(role) {
  return (req, res, next) => {
    if (req.user.role !== role) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}
```

## 🔐 Permission-Based Access

```javascript
// Permissions: read:users, write:users, delete:users
if (user.hasPermission('write:users')) {
  // Allow access
}
```

## 📝 Attribute-Based Access Control (ABAC)

```javascript
// Check attributes
if (user.department === 'sales' && resource.owner === user.id) {
  // Allow access
}
```

---

**Next**: Learn about [API Versioning](./API-VERSIONING.md)

