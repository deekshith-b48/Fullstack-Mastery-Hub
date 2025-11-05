# Authorization Fundamentals

## 📚 Overview

Authorization determines what authenticated users can do within an application. It's the process of granting or denying access to resources based on user permissions, roles, and policies. Proper authorization is essential for preventing unauthorized access.

## 🎯 What is Authorization?

Authorization answers: "What can you do?" It's different from authentication (who you are). Authorization controls access to resources, actions, and data based on user identity and permissions.

### Authorization Concepts

1. **Permissions**: Specific actions users can perform
2. **Roles**: Collections of permissions
3. **Policies**: Rules that define access
4. **Resources**: Objects being protected
5. **Actions**: Operations on resources

## 🔍 Role-Based Access Control (RBAC)

### Basic RBAC

```javascript
// Define roles and permissions
const roles = {
  admin: ['read', 'write', 'delete', 'admin'],
  editor: ['read', 'write'],
  viewer: ['read']
};

function hasPermission(user, permission) {
  const userRole = user.role || 'viewer';
  const rolePermissions = roles[userRole] || [];
  return rolePermissions.includes(permission);
}

// Check permissions
app.delete('/api/posts/:id', authenticate, (req, res, next) => {
  if (!hasPermission(req.user, 'delete')) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  next();
}, deletePost);
```

## 🔍 Permission-Based Authorization

### Direct Permission Checks

```javascript
// Check specific permissions
function checkPermission(user, resource, action) {
  const userPermissions = user.permissions || [];
  const requiredPermission = `${resource}:${action}`;
  
  return userPermissions.includes(requiredPermission) ||
         userPermissions.includes('*:*'); // Super admin
}

// Usage
app.get('/api/users/:id', authenticate, (req, res) => {
  if (!checkPermission(req.user, 'user', 'read')) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  const user = await User.findById(req.params.id);
  res.json(user);
});
```

## 🔍 Resource Ownership

### Ownership-Based Authorization

```javascript
// Check resource ownership
function isOwner(user, resource) {
  return resource.userId === user.id;
}

function canAccess(user, resource, action) {
  // Owner can do anything
  if (isOwner(user, resource)) {
    return true;
  }
  
  // Check role-based permissions
  if (action === 'read' && hasPermission(user, 'read')) {
    return true;
  }
  
  // Check specific permissions
  return checkPermission(user, resource.type, action);
}

app.get('/api/posts/:id', authenticate, async (req, res) => {
  const post = await Post.findById(req.params.id);
  
  if (!canAccess(req.user, post, 'read')) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  res.json(post);
});
```

## 🔍 Attribute-Based Access Control (ABAC)

### ABAC Implementation

```javascript
// Attribute-based authorization
function evaluatePolicy(user, resource, action, context) {
  const policies = [
    // Policy 1: Users can read their own posts
    {
      condition: (u, r) => r.userId === u.id && action === 'read',
      allow: true
    },
    // Policy 2: Admins can do anything
    {
      condition: (u) => u.role === 'admin',
      allow: true
    },
    // Policy 3: Editors can read/write during business hours
    {
      condition: (u, r, a, ctx) => 
        u.role === 'editor' && 
        ['read', 'write'].includes(a) &&
        isBusinessHours(ctx.time),
      allow: true
    },
    // Policy 4: Deny by default
    {
      condition: () => true,
      allow: false
    }
  ];
  
  for (const policy of policies) {
    if (policy.condition(user, resource, action, context)) {
      return policy.allow;
    }
  }
  
  return false;
}
```

## 🔍 Authorization Middleware

### Reusable Authorization Middleware

```javascript
// Authorization middleware factory
function authorize(requiredPermission) {
  return (req, res, next) => {
    const user = req.user;
    
    if (!user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    
    if (!hasPermission(user, requiredPermission)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    next();
  };
}

// Usage
app.delete('/api/users/:id', 
  authenticate, 
  authorize('admin'), 
  deleteUser
);
```

## 🔍 Row-Level Security

### Database-Level Authorization

```javascript
// Filter data based on user permissions
async function getUsers(user) {
  let query = {};
  
  if (user.role !== 'admin') {
    // Non-admins can only see their own data
    query = { id: user.id };
  }
  
  return await User.find(query);
}

// Or use database views/row-level security
// PostgreSQL example:
// CREATE POLICY user_policy ON users
//   FOR SELECT
//   USING (user_id = current_user_id() OR is_admin(current_user_id()));
```

## 🛡️ Best Practices

1. **Default Deny**: Deny by default, allow explicitly
2. **Least Privilege**: Grant minimum necessary permissions
3. **Server-Side**: Never rely on client-side checks
4. **Regular Audits**: Review permissions regularly
5. **Logging**: Log all authorization decisions
6. **Testing**: Test authorization thoroughly
7. **Documentation**: Document authorization policies

---

**Next**: Learn about [Role-Based Access Control](./ROLE-BASED-ACCESS-CONTROL.md)

