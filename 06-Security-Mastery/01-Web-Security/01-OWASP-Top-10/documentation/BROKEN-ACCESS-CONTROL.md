# Broken Access Control

## 📚 Overview

Broken access control is the #1 risk in the OWASP Top 10 2021. It occurs when restrictions on what authenticated users are allowed to do are not properly enforced. Attackers can exploit these flaws to access unauthorized functionality or data.

## 🎯 What is Broken Access Control?

Broken access control happens when applications fail to properly enforce authorization checks, allowing users to access resources or perform actions they shouldn't have permission for. This can lead to unauthorized data access, privilege escalation, and data breaches.

### Common Access Control Flaws

1. **Insecure Direct Object References (IDOR)**: Direct access to resources
2. **Missing Function Level Access Control**: Missing authorization checks
3. **Horizontal Privilege Escalation**: Accessing other users' data
4. **Vertical Privilege Escalation**: Gaining admin privileges
5. **Path Traversal**: Accessing files outside intended directory
6. **CORS Misconfiguration**: Unauthorized cross-origin access
7. **Missing Authorization**: No authorization checks

## 🔍 Insecure Direct Object References (IDOR)

### Vulnerable Code - IDOR

```javascript
// VULNERABLE CODE - No authorization check
app.get('/api/users/:id', authenticate, (req, res) => {
  const user = User.findById(req.params.id);
  res.json(user); // Any authenticated user can access any user's data!
});

// Attack: GET /api/users/123 (access other user's data)
```

### Secure Code - IDOR Prevention

```javascript
// SECURE CODE - Authorization check
app.get('/api/users/:id', authenticate, async (req, res) => {
  const userId = req.params.id;
  const currentUser = req.user;
  
  // Check if user can access this resource
  if (userId !== currentUser.id && currentUser.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  const user = await User.findById(userId);
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  res.json(user);
});

// Better: Use access control middleware
function canAccessUser(currentUser, targetUserId) {
  return currentUser.id === targetUserId || currentUser.role === 'admin';
}

app.get('/api/users/:id', authenticate, async (req, res) => {
  if (!canAccessUser(req.user, req.params.id)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  const user = await User.findById(req.params.id);
  res.json(user);
});
```

## 🔍 Missing Function Level Access Control

### Vulnerable Code - Missing Authorization

```javascript
// VULNERABLE CODE - No authorization check
app.delete('/api/users/:id', authenticate, async (req, res) => {
  await User.deleteOne({ id: req.params.id });
  res.json({ success: true }); // Any user can delete any user!
});

// VULNERABLE CODE - Client-side only check
// Frontend code
if (user.role === 'admin') {
  showDeleteButton(); // Client-side check can be bypassed!
}
```

### Secure Code - Server-Side Authorization

```javascript
// SECURE CODE - Server-side authorization
app.delete('/api/users/:id', authenticate, authorize(['admin']), async (req, res) => {
  const targetUserId = req.params.id;
  const currentUser = req.user;
  
  // Additional check: Admins can't delete themselves
  if (targetUserId === currentUser.id) {
    return res.status(400).json({ error: 'Cannot delete own account' });
  }
  
  await User.deleteOne({ id: targetUserId });
  
  // Log the action
  await logSecurityEvent({
    type: 'user_deleted',
    actor: currentUser.id,
    target: targetUserId,
    timestamp: Date.now()
  });
  
  res.json({ success: true });
});

// Authorization middleware
function authorize(allowedRoles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
    
    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    next();
  };
}
```

## 🔍 Horizontal Privilege Escalation

### Vulnerable Code - Horizontal Escalation

```javascript
// VULNERABLE CODE - No ownership check
app.get('/api/orders/:orderId', authenticate, async (req, res) => {
  const order = await Order.findById(req.params.orderId);
  res.json(order); // Users can access other users' orders!
});
```

### Secure Code - Ownership Check

```javascript
// SECURE CODE - Ownership verification
app.get('/api/orders/:orderId', authenticate, async (req, res) => {
  const order = await Order.findById(req.params.orderId);
  
  if (!order) {
    return res.status(404).json({ error: 'Order not found' });
  }
  
  // Check ownership
  if (order.userId !== req.user.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  res.json(order);
});

// Using middleware
function checkOwnership(model, userIdField = 'userId') {
  return async (req, res, next) => {
    const resource = await model.findById(req.params.id);
    
    if (!resource) {
      return res.status(404).json({ error: 'Resource not found' });
    }
    
    if (resource[userIdField] !== req.user.id && req.user.role !== 'admin') {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    req.resource = resource;
    next();
  };
}

app.get('/api/orders/:id', authenticate, checkOwnership(Order), (req, res) => {
  res.json(req.resource);
});
```

## 🔍 Vertical Privilege Escalation

### Vulnerable Code - Vertical Escalation

```javascript
// VULNERABLE CODE - Role in request body
app.post('/api/users', authenticate, async (req, res) => {
  const user = await User.create({
    username: req.body.username,
    role: req.body.role // User can set their own role to 'admin'!
  });
  res.json(user);
});

// Attack: POST /api/users with { "username": "hacker", "role": "admin" }
```

### Secure Code - Prevent Role Manipulation

```javascript
// SECURE CODE - Server-side role assignment
app.post('/api/users', authenticate, authorize(['admin']), async (req, res) => {
  // Only admins can create users
  // Role is set server-side, not from request
  const user = await User.create({
    username: req.body.username,
    email: req.body.email,
    password: await hashPassword(req.body.password),
    role: 'user' // Default role, set server-side
  });
  
  res.json(user);
});

// Update role separately with proper authorization
app.patch('/api/users/:id/role', authenticate, authorize(['admin']), async (req, res) => {
  const allowedRoles = ['user', 'moderator', 'admin'];
  const newRole = req.body.role;
  
  if (!allowedRoles.includes(newRole)) {
    return res.status(400).json({ error: 'Invalid role' });
  }
  
  // Prevent removing last admin
  if (newRole !== 'admin') {
    const adminCount = await User.countDocuments({ role: 'admin' });
    const targetUser = await User.findById(req.params.id);
    
    if (targetUser.role === 'admin' && adminCount === 1) {
      return res.status(400).json({ error: 'Cannot remove last admin' });
    }
  }
  
  await User.updateOne({ id: req.params.id }, { role: newRole });
  res.json({ success: true });
});
```

## 🔍 Path Traversal

### Vulnerable Code - Path Traversal

```javascript
// VULNERABLE CODE - No path validation
app.get('/api/files/:filename', authenticate, (req, res) => {
  const filePath = path.join(__dirname, 'uploads', req.params.filename);
  res.sendFile(filePath); // Vulnerable to ../../../etc/passwd
});

// Attack: GET /api/files/../../../etc/passwd
```

### Secure Code - Path Traversal Prevention

```javascript
// SECURE CODE - Path validation
const path = require('path');

app.get('/api/files/:filename', authenticate, async (req, res) => {
  const filename = req.params.filename;
  
  // Validate filename
  if (!/^[a-zA-Z0-9._-]+$/.test(filename)) {
    return res.status(400).json({ error: 'Invalid filename' });
  }
  
  // Resolve path and check it's within allowed directory
  const uploadsDir = path.resolve(__dirname, 'uploads');
  const filePath = path.resolve(uploadsDir, filename);
  
  // Ensure file is within uploads directory
  if (!filePath.startsWith(uploadsDir)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  // Check file exists and user has access
  const file = await File.findOne({ filename, userId: req.user.id });
  if (!file) {
    return res.status(404).json({ error: 'File not found' });
  }
  
  res.sendFile(filePath);
});

// Alternative: Use whitelist
const allowedFiles = new Set();

app.post('/api/files/upload', authenticate, upload.single('file'), (req, res) => {
  const filename = req.file.filename;
  allowedFiles.add(filename); // Store in whitelist
  
  res.json({ filename });
});

app.get('/api/files/:filename', authenticate, (req, res) => {
  if (!allowedFiles.has(req.params.filename)) {
    return res.status(404).json({ error: 'File not found' });
  }
  
  const filePath = path.join(__dirname, 'uploads', req.params.filename);
  res.sendFile(filePath);
});
```

## 🔍 CORS Misconfiguration

### Vulnerable Code - CORS

```javascript
// VULNERABLE CODE - Allow all origins
app.use(cors({
  origin: '*' // Allows any origin!
}));

// VULNERABLE CODE - Credentials with wildcard
app.use(cors({
  origin: '*',
  credentials: true // Dangerous combination!
}));
```

### Secure Code - CORS Configuration

```javascript
// SECURE CODE - Restricted CORS
const allowedOrigins = [
  'https://example.com',
  'https://app.example.com'
];

app.use(cors({
  origin: (origin, callback) => {
    // Allow requests with no origin (mobile apps, Postman, etc.)
    if (!origin) return callback(null, true);
    
    if (allowedOrigins.indexOf(origin) === -1) {
      return callback(new Error('Not allowed by CORS'));
    }
    
    callback(null, true);
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  maxAge: 86400 // 24 hours
}));
```

## 🛡️ Access Control Best Practices

### 1. Role-Based Access Control (RBAC)

```javascript
// Define roles and permissions
const roles = {
  admin: ['read', 'write', 'delete', 'admin'],
  moderator: ['read', 'write'],
  user: ['read']
};

function hasPermission(user, permission) {
  const userPermissions = roles[user.role] || [];
  return userPermissions.includes(permission);
}

// Check permissions
app.delete('/api/posts/:id', authenticate, (req, res, next) => {
  if (!hasPermission(req.user, 'delete')) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  next();
}, deletePost);
```

### 2. Attribute-Based Access Control (ABAC)

```javascript
// More granular access control
function canAccessResource(user, resource, action) {
  // Ownership check
  if (resource.userId === user.id) {
    return true;
  }
  
  // Role check
  if (user.role === 'admin') {
    return true;
  }
  
  // Department check
  if (resource.department === user.department && action === 'read') {
    return true;
  }
  
  // Time-based access
  if (resource.sensitive && !isBusinessHours()) {
    return false;
  }
  
  return false;
}
```

### 3. Resource-Level Authorization

```javascript
// Check authorization at resource level
async function authorizeResourceAccess(user, resourceType, resourceId, action) {
  const resource = await getResource(resourceType, resourceId);
  
  if (!resource) {
    return { allowed: false, reason: 'Resource not found' };
  }
  
  // Check ownership
  if (resource.userId && resource.userId !== user.id) {
    // Check if user has permission via role
    if (!hasPermission(user, action)) {
      return { allowed: false, reason: 'Not authorized' };
    }
  }
  
  // Check additional conditions
  if (resource.requiresApproval && !resource.approved) {
    if (user.role !== 'admin') {
      return { allowed: false, reason: 'Resource not approved' };
    }
  }
  
  return { allowed: true };
}
```

## 📊 Access Control Testing

```javascript
// Test access control
async function testAccessControl() {
  const testCases = [
    {
      user: { id: 1, role: 'user' },
      resource: { id: 2, userId: 2 },
      action: 'read',
      expected: false // User can't access other user's resource
    },
    {
      user: { id: 1, role: 'user' },
      resource: { id: 1, userId: 1 },
      action: 'read',
      expected: true // User can access own resource
    },
    {
      user: { id: 1, role: 'admin' },
      resource: { id: 2, userId: 2 },
      action: 'delete',
      expected: true // Admin can delete any resource
    }
  ];
  
  for (const testCase of testCases) {
    const result = await authorizeResourceAccess(
      testCase.user,
      'user',
      testCase.resource.id,
      testCase.action
    );
    
    if (result.allowed !== testCase.expected) {
      console.error('Access control test failed:', testCase);
    }
  }
}
```

## 🎯 Best Practices

1. **Server-Side Authorization**: Never rely on client-side checks
2. **Default Deny**: Deny by default, allow explicitly
3. **Least Privilege**: Grant minimum necessary permissions
4. **Regular Audits**: Review access controls regularly
5. **Logging**: Log all authorization decisions
6. **Testing**: Test access control thoroughly
7. **Rate Limiting**: Implement rate limiting for sensitive operations

## 🎓 Learning Resources

- OWASP Access Control: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/05-Authorization_Testing/
- Access Control Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
- IDOR Prevention: https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html

---

**Next**: Learn about [Security Misconfiguration](./SECURITY-MISCONFIGURATION.md)

