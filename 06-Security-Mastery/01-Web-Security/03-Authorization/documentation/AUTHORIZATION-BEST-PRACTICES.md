# Authorization Best Practices

## 📚 Overview

This guide consolidates best practices for implementing secure authorization systems. Following these practices ensures proper access control and prevents unauthorized access.

## 🎯 Core Principles

### 1. Default Deny

Always deny by default, allow explicitly:
```javascript
function checkAccess(user, resource, action) {
  // Default deny
  let allowed = false;
  
  // Explicit allow conditions
  if (user.role === 'admin') allowed = true;
  if (resource.userId === user.id) allowed = true;
  if (hasPermission(user, resource, action)) allowed = true;
  
  return allowed;
}
```

### 2. Least Privilege

Grant minimum necessary permissions:
```javascript
// Grant only what's needed
const permissions = {
  viewer: ['read'],
  editor: ['read', 'write'],
  admin: ['read', 'write', 'delete', 'admin']
};
```

### 3. Server-Side Validation

Never trust client-side checks:
```javascript
// Always validate on server
app.delete('/api/users/:id', authenticate, async (req, res) => {
  // Server-side check
  if (req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  // Proceed with deletion
});
```

## 🔍 Authorization Patterns

### Pattern 1: Role-Based

```javascript
function requireRole(role) {
  return (req, res, next) => {
    if (req.user.role !== role) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}
```

### Pattern 2: Permission-Based

```javascript
function requirePermission(permission) {
  return (req, res, next) => {
    if (!hasPermission(req.user, permission)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}
```

### Pattern 3: Resource Ownership

```javascript
async function requireOwnership(req, res, next) {
  const resource = await Resource.findById(req.params.id);
  
  if (resource.userId !== req.user.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  req.resource = resource;
  next();
}
```

## 🔍 Authorization Testing

### Test Authorization

```javascript
// Test authorization logic
async function testAuthorization() {
  const testCases = [
    {
      user: { role: 'viewer', id: 1 },
      resource: { userId: 2 },
      action: 'read',
      expected: true
    },
    {
      user: { role: 'viewer', id: 1 },
      resource: { userId: 2 },
      action: 'delete',
      expected: false
    }
  ];
  
  for (const testCase of testCases) {
    const result = checkAccess(
      testCase.user,
      testCase.resource,
      testCase.action
    );
    
    if (result !== testCase.expected) {
      console.error('Authorization test failed:', testCase);
    }
  }
}
```

## 🔍 Logging and Auditing

### Log Authorization Decisions

```javascript
function checkAccessWithLogging(user, resource, action) {
  const allowed = checkAccess(user, resource, action);
  
  // Log authorization decision
  logSecurityEvent({
    type: 'authorization_check',
    userId: user.id,
    resource: resource.id,
    action: action,
    allowed: allowed,
    timestamp: Date.now()
  });
  
  return allowed;
}
```

## 🛡️ Security Checklist

- [ ] Default deny implemented
- [ ] Least privilege principle followed
- [ ] Server-side validation only
- [ ] Resource ownership checked
- [ ] Role-based access implemented
- [ ] Permission system in place
- [ ] Authorization logged
- [ ] Regular audits performed
- [ ] Testing comprehensive

## 🎯 Best Practices Summary

1. **Default Deny**: Deny by default, allow explicitly
2. **Least Privilege**: Grant minimum necessary access
3. **Server-Side**: Never trust client checks
4. **Ownership**: Check resource ownership
5. **Logging**: Log all authorization decisions
6. **Testing**: Test authorization thoroughly
7. **Auditing**: Regular permission audits

---

**Authorization section complete!** Next: [Data Protection Fundamentals](./../04-Data-Protection/documentation/DATA-PROTECTION-FUNDAMENTALS.md)

