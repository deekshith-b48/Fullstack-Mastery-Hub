# Fine-Grained Authorization

## 📚 Overview

Fine-grained authorization provides detailed, context-aware access control at the field, record, or operation level. It goes beyond simple role checks to make decisions based on multiple factors.

## 🎯 Fine-Grained Authorization Concepts

### Granularity Levels

1. **Field-Level**: Control access to specific fields
2. **Record-Level**: Control access to individual records
3. **Operation-Level**: Control specific operations
4. **Context-Aware**: Decisions based on environment

## 🔍 Field-Level Authorization

### Field Access Control

```javascript
// Filter fields based on permissions
function filterFields(user, data, resourceType) {
  const allowedFields = getAllowedFields(user, resourceType);
  const filtered = {};
  
  for (const field of allowedFields) {
    if (field in data) {
      filtered[field] = data[field];
    }
  }
  
  return filtered;
}

// Get allowed fields for user
function getAllowedFields(user, resourceType) {
  const fieldPermissions = {
    user: {
      admin: ['id', 'email', 'name', 'role', 'createdAt'],
      editor: ['id', 'email', 'name'],
      viewer: ['id', 'name']
    }
  };
  
  const role = user.role;
  return fieldPermissions[resourceType]?.[role] || [];
}

// Usage
app.get('/api/users/:id', authenticate, async (req, res) => {
  const user = await User.findById(req.params.id);
  const filtered = filterFields(req.user, user.toObject(), 'user');
  res.json(filtered);
});
```

## 🔍 Record-Level Authorization

### Conditional Record Access

```javascript
// Filter records based on permissions
async function getAccessibleRecords(user, resourceType) {
  let query = {};
  
  // Admin can see all
  if (user.role === 'admin') {
    return await Resource.find({ type: resourceType });
  }
  
  // Department members can see department records
  if (user.department) {
    query.$or = [
      { department: user.department },
      { userId: user.id }
    ];
  } else {
    query.userId = user.id;
  }
  
  // Check sensitivity level
  if (user.clearance < 5) {
    query.sensitivity = { $ne: 'high' };
  }
  
  return await Resource.find({ ...query, type: resourceType });
}
```

## 🔍 Time-Based Authorization

### Time-Restricted Access

```javascript
// Time-based access control
function checkTimeBasedAccess(user, resource, action) {
  const now = new Date();
  const hour = now.getHours();
  
  // Business hours only for write operations
  if (action !== 'read' && (hour < 9 || hour > 17)) {
    if (user.role !== 'admin') {
      return false;
    }
  }
  
  // Weekend restrictions
  const day = now.getDay();
  if (day === 0 || day === 6) { // Sunday or Saturday
    if (resource.sensitive && user.role !== 'admin') {
      return false;
    }
  }
  
  return true;
}
```

## 🔍 Location-Based Authorization

### Geographic Restrictions

```javascript
// Location-based access control
async function checkLocationAccess(user, resource, context) {
  // Get user location
  const userLocation = await getUserLocation(user.id);
  
  // Check if resource has location restrictions
  if (resource.allowedLocations && resource.allowedLocations.length > 0) {
    if (!resource.allowedLocations.includes(userLocation)) {
      return false;
    }
  }
  
  // Check IP-based restrictions
  if (resource.allowedIPs && resource.allowedIPs.length > 0) {
    if (!resource.allowedIPs.includes(context.ip)) {
      return false;
    }
  }
  
  return true;
}
```

## 🔍 Dynamic Policy Evaluation

### Context-Aware Policies

```javascript
// Evaluate policies with full context
function evaluateAccess(user, resource, action, context) {
  const policies = [
    // Policy 1: Owner can do anything
    {
      condition: () => resource.userId === user.id,
      allow: true
    },
    // Policy 2: Admin can do anything
    {
      condition: () => user.role === 'admin',
      allow: true
    },
    // Policy 3: Department access during business hours
    {
      condition: () => 
        resource.department === user.department &&
        isBusinessHours(context.time),
      allow: action === 'read'
    },
    // Policy 4: High clearance required for sensitive data
    {
      condition: () => resource.sensitivity === 'high',
      allow: user.clearance >= 5
    },
    // Policy 5: Default deny
    {
      condition: () => true,
      allow: false
    }
  ];
  
  for (const policy of policies) {
    if (policy.condition()) {
      return policy.allow;
    }
  }
  
  return false;
}
```

## 🛡️ Best Practices

1. **Context Awareness**: Consider all relevant factors
2. **Performance**: Cache policy evaluations
3. **Auditing**: Log all authorization decisions
4. **Testing**: Test policy combinations
5. **Documentation**: Document policy logic
6. **Monitoring**: Monitor access patterns

---

**Next**: Learn about [Authorization Servers](./AUTHORIZATION-SERVERS.md)

