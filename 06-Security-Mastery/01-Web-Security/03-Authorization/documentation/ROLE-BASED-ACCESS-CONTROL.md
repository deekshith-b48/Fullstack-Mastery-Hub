# Role-Based Access Control (RBAC)

## 📚 Overview

Role-Based Access Control (RBAC) is a security model that restricts access based on user roles. Users are assigned roles, and roles are granted permissions. This simplifies access management and follows the principle of least privilege.

## 🎯 RBAC Fundamentals

### RBAC Components

1. **Users**: Individuals who need access
2. **Roles**: Collections of permissions
3. **Permissions**: Specific actions on resources
4. **Resources**: Objects being protected

### RBAC Benefits

- Simplified permission management
- Easy to audit
- Scalable for large organizations
- Clear separation of duties

## 🔍 RBAC Implementation

### Basic RBAC Model

```javascript
// Define roles and their permissions
const rolePermissions = {
  admin: {
    users: ['create', 'read', 'update', 'delete'],
    posts: ['create', 'read', 'update', 'delete'],
    settings: ['read', 'update']
  },
  editor: {
    posts: ['create', 'read', 'update'],
    comments: ['create', 'read', 'update', 'delete']
  },
  viewer: {
    posts: ['read'],
    comments: ['read']
  }
};

function hasRolePermission(user, resource, action) {
  const role = user.role;
  const permissions = rolePermissions[role] || {};
  const resourcePermissions = permissions[resource] || [];
  return resourcePermissions.includes(action);
}
```

### Hierarchical RBAC

```javascript
// Roles can inherit from other roles
const roleHierarchy = {
  superAdmin: ['admin', 'editor', 'viewer'],
  admin: ['editor', 'viewer'],
  editor: ['viewer'],
  viewer: []
};

function hasRolePermission(user, resource, action) {
  const role = user.role;
  const rolesToCheck = [role, ...roleHierarchy[role] || []];
  
  for (const checkRole of rolesToCheck) {
    const permissions = rolePermissions[checkRole] || {};
    const resourcePermissions = permissions[resource] || [];
    if (resourcePermissions.includes(action)) {
      return true;
    }
  }
  
  return false;
}
```

## 🔍 Dynamic Role Assignment

### Role Management

```javascript
// Assign roles to users
async function assignRole(userId, role) {
  const allowedRoles = ['admin', 'editor', 'viewer'];
  
  if (!allowedRoles.includes(role)) {
    throw new Error('Invalid role');
  }
  
  await User.updateOne({ id: userId }, { role: role });
  
  // Log role change
  await logSecurityEvent({
    type: 'role_assigned',
    userId: userId,
    role: role,
    timestamp: Date.now()
  });
}

// Check role permissions
function requireRole(requiredRole) {
  return (req, res, next) => {
    if (req.user.role !== requiredRole) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }
    next();
  };
}
```

## 🔍 RBAC with Database

### Database Schema

```javascript
// Role model
const Role = {
  name: String,
  permissions: [String],
  createdAt: Date
};

// User-Role relationship
const UserRole = {
  userId: ObjectId,
  roleId: ObjectId,
  assignedAt: Date,
  assignedBy: ObjectId
};

// Permission model
const Permission = {
  name: String,
  resource: String,
  action: String
};

// Check permissions
async function checkPermission(userId, resource, action) {
  const user = await User.findById(userId).populate('roles');
  
  for (const role of user.roles) {
    const permission = `${resource}:${action}`;
    if (role.permissions.includes(permission)) {
      return true;
    }
  }
  
  return false;
}
```

## 🛡️ Best Practices

1. **Least Privilege**: Grant minimum necessary permissions
2. **Role Separation**: Separate duties across roles
3. **Regular Audits**: Review role assignments regularly
4. **Documentation**: Document role permissions
5. **Testing**: Test role-based access thoroughly
6. **Monitoring**: Monitor role usage and changes

---

**Next**: Learn about [Attribute-Based Access Control](./ATTRIBUTE-BASED-ACCESS-CONTROL.md)

