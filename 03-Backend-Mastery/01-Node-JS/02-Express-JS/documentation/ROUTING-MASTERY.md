# Express Routing Mastery

## 📚 Overview

Express routing maps HTTP requests to handlers based on URL patterns and HTTP methods.

## 🛣️ Route Methods

```javascript
app.get('/users', handler);
app.post('/users', handler);
app.put('/users/:id', handler);
app.delete('/users/:id', handler);
app.patch('/users/:id', handler);

// All methods
app.all('/users', handler);

// Route chaining
app.route('/users')
  .get(getUsers)
  .post(createUser)
  .put(updateUser)
  .delete(deleteUser);
```

## 🎯 Route Paths

### String Patterns

```javascript
// Exact match
app.get('/users', handler);

// Wildcard
app.get('/users/*', handler);

// Optional parameters
app.get('/users/:id?', handler);
```

### Regular Expressions

```javascript
// Match specific pattern
app.get(/^\/users\/(\d+)$/, (req, res) => {
  const userId = req.params[0];
  res.json({ userId });
});

// Case insensitive
app.get(/\/users/i, handler);
```

### Route Parameters

```javascript
// Single parameter
app.get('/users/:id', (req, res) => {
  const { id } = req.params;
  res.json({ userId: id });
});

// Multiple parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  const { userId, postId } = req.params;
  res.json({ userId, postId });
});

// Parameter constraints
app.get('/users/:id(\\d+)', (req, res) => {
  // Only matches numeric IDs
  res.json({ userId: req.params.id });
});
```

## 📦 Router Module

### Create Router

```javascript
// routes/users.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.json({ users: [] });
});

router.get('/:id', (req, res) => {
  res.json({ user: { id: req.params.id } });
});

module.exports = router;
```

### Use Router

```javascript
// app.js
const userRoutes = require('./routes/users');

app.use('/users', userRoutes);
// Now accessible at /users and /users/:id
```

### Nested Routers

```javascript
// routes/posts.js
const express = require('express');
const router = express.Router();
const commentsRouter = require('./comments');

router.use('/:postId/comments', commentsRouter);

module.exports = router;
```

## 🔄 Route Order

```javascript
// Order matters!
// ❌ This will never execute
app.get('/users/:id', (req, res) => {
  res.json({ user: req.params.id });
});

app.get('/users/new', (req, res) => {
  res.json({ page: 'new user' });
});

// ✅ Specific routes first
app.get('/users/new', (req, res) => {
  res.json({ page: 'new user' });
});

app.get('/users/:id', (req, res) => {
  res.json({ user: req.params.id });
});
```

## 🎯 Route Handlers

### Multiple Handlers

```javascript
function authenticate(req, res, next) {
  // Check authentication
  if (req.headers.authorization) {
    next();
  } else {
    res.status(401).json({ error: 'Unauthorized' });
  }
}

function validate(req, res, next) {
  // Validate input
  if (req.body.email) {
    next();
  } else {
    res.status(400).json({ error: 'Email required' });
  }
}

app.post('/users',
  authenticate,
  validate,
  (req, res) => {
    res.json({ created: true });
  }
);
```

### Async Handlers

```javascript
// Wrap async handler
app.get('/users', async (req, res, next) => {
  try {
    const users = await User.findAll();
    res.json({ users });
  } catch (err) {
    next(err); // Pass to error handler
  }
});

// Or use wrapper
function asyncHandler(fn) {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
}

app.get('/users', asyncHandler(async (req, res) => {
  const users = await User.findAll();
  res.json({ users });
}));
```

---

**Next**: Learn about [Middleware Architecture](./MIDDLEWARE-ARCHITECTURE.md)

