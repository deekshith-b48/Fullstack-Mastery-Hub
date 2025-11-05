# Permission Models

## 📚 Overview

Permission models define how access rights are structured and managed. Different models suit different use cases, from simple role-based to complex attribute-based systems.

## 🎯 Common Permission Models

### 1. Flat Permissions

Simple list of permissions:
```javascript
const userPermissions = ['read:posts', 'write:posts', 'delete:comments'];
```

### 2. Hierarchical Permissions

Permissions organized in hierarchy:
```javascript
const permissions = {
  posts: {
    read: true,
    write: true,
    delete: false
  },
  comments: {
    read: true,
    write: false,
    delete: false
  }
};
```

### 3. Resource-Action Permissions

Format: `resource:action`
```javascript
function checkPermission(user, resource, action) {
  const permission = `${resource}:${action}`;
  return user.permissions.includes(permission);
}
```

## 🔍 Permission Management

### Granting Permissions

```javascript
async function grantPermission(userId, resource, action) {
  const permission = `${resource}:${action}`;
  
  await User.updateOne(
    { id: userId },
    { $addToSet: { permissions: permission } }
  );
  
  // Log permission grant
  await logSecurityEvent({
    type: 'permission_granted',
    userId: userId,
    permission: permission,
    timestamp: Date.now()
  });
}
```

### Revoking Permissions

```javascript
async function revokePermission(userId, resource, action) {
  const permission = `${resource}:${action}`;
  
  await User.updateOne(
    { id: userId },
    { $pull: { permissions: permission } }
  );
  
  // Invalidate user sessions to apply changes
  await invalidateUserSessions(userId);
}
```

## 🔍 Permission Inheritance

### Role Permission Inheritance

```javascript
// Permissions inherited from roles
function getUserPermissions(user) {
  const rolePermissions = getRolePermissions(user.role);
  const directPermissions = user.permissions || [];
  
  // Combine and deduplicate
  return [...new Set([...rolePermissions, ...directPermissions])];
}

function hasPermission(user, resource, action) {
  const permissions = getUserPermissions(user);
  const requiredPermission = `${resource}:${action}`;
  return permissions.includes(requiredPermission);
}
```

## 🔍 Permission Caching

### Cache Permissions

```javascript
const permissionCache = new Map();

async function getCachedPermissions(userId) {
  const cacheKey = `permissions:${userId}`;
  
  if (permissionCache.has(cacheKey)) {
    return permissionCache.get(cacheKey);
  }
  
  const user = await User.findById(userId);
  const permissions = getUserPermissions(user);
  
  permissionCache.set(cacheKey, permissions);
  
  // Invalidate cache after 5 minutes
  setTimeout(() => {
    permissionCache.delete(cacheKey);
  }, 5 * 60 * 1000);
  
  return permissions;
}
```

## 🛡️ Best Practices

1. **Least Privilege**: Grant minimum necessary permissions
2. **Regular Review**: Audit permissions regularly
3. **Documentation**: Document permission structure
4. **Caching**: Cache permissions for performance
5. **Testing**: Test permission checks thoroughly
6. **Monitoring**: Monitor permission usage

---

**Next**: Learn about [API Authorization](./API-AUTHORIZATION.md)

