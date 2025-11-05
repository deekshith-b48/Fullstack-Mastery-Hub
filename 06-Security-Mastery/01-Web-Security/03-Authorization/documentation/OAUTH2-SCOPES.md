# OAuth2 Scopes

## 📚 Overview

OAuth2 scopes define the specific permissions granted to an access token. They limit what a client application can do on behalf of the user, following the principle of least privilege.

## 🎯 What are Scopes?

Scopes are strings that represent permissions. They allow fine-grained control over what resources a client can access. Common scope examples include `read`, `write`, `admin`.

### Scope Examples

```
read          - Read access to resources
write         - Write access to resources
read:profile  - Read user profile
write:profile - Modify user profile
admin         - Administrative access
```

## 🔍 Scope Definition

### Defining Scopes

```javascript
// Define available scopes
const availableScopes = {
  'read': {
    description: 'Read access to user data',
    permissions: ['user:read', 'profile:read']
  },
  'write': {
    description: 'Write access to user data',
    permissions: ['user:write', 'profile:write']
  },
  'read:profile': {
    description: 'Read user profile',
    permissions: ['profile:read']
  },
  'write:profile': {
    description: 'Modify user profile',
    permissions: ['profile:write']
  },
  'admin': {
    description: 'Administrative access',
    permissions: ['*:*']
  }
};
```

## 🔍 Scope Validation

### Validating Requested Scopes

```javascript
// Validate requested scopes
function validateScopes(requestedScopes, clientAllowedScopes) {
  const requested = requestedScopes.split(' ');
  const allowed = clientAllowedScopes.split(' ');
  
  // Check if all requested scopes are allowed
  for (const scope of requested) {
    if (!allowed.includes(scope)) {
      throw new Error(`Scope '${scope}' not allowed for this client`);
    }
  }
  
  return requested;
}

// During authorization
app.get('/oauth/authorize', (req, res) => {
  const { client_id, scope } = req.query;
  const client = getClient(client_id);
  
  try {
    const validatedScopes = validateScopes(scope, client.allowedScopes);
    // Show consent screen with scopes
    res.render('consent', { scopes: validatedScopes });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
```

## 🔍 Scope-Based Authorization

### Checking Scopes in API

```javascript
// Middleware to check scope
function requireScope(requiredScope) {
  return (req, res, next) => {
    const tokenScopes = req.user.scopes || [];
    
    if (!tokenScopes.includes(requiredScope)) {
      return res.status(403).json({ 
        error: 'Insufficient scope',
        required: requiredScope,
        granted: tokenScopes
      });
    }
    
    next();
  };
}

// Usage
app.get('/api/profile',
  requireAuth,
  requireScope('read:profile'),
  getProfile
);

app.put('/api/profile',
  requireAuth,
  requireScope('write:profile'),
  updateProfile
);
```

## 🔍 Scope Mapping to Permissions

### Mapping Scopes to Permissions

```javascript
// Map scopes to specific permissions
function getPermissionsFromScopes(scopes) {
  const permissions = [];
  
  for (const scope of scopes) {
    const scopeDef = availableScopes[scope];
    if (scopeDef) {
      permissions.push(...scopeDef.permissions);
    }
  }
  
  return [...new Set(permissions)]; // Remove duplicates
}

// Use in authorization
function checkPermission(user, resource, action) {
  const scopes = user.scopes || [];
  const permissions = getPermissionsFromScopes(scopes);
  
  const requiredPermission = `${resource}:${action}`;
  return permissions.includes(requiredPermission) || 
         permissions.includes('*:*');
}
```

## 🛡️ Best Practices

1. **Least Privilege**: Request minimum necessary scopes
2. **Scope Validation**: Validate all requested scopes
3. **Clear Documentation**: Document scope meanings
4. **User Consent**: Show scope descriptions to users
5. **Scope Limitation**: Limit client-requested scopes
6. **Monitoring**: Monitor scope usage

---

**Next**: Learn about [Fine-Grained Authorization](./FINE-GRAINED-AUTHORIZATION.md)

