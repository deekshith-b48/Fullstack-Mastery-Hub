# RESTful API Design

## 📚 REST Principles

REST (Representational State Transfer) is an architectural style for designing web services.

## 🎯 RESTful Conventions

### HTTP Methods

```javascript
// GET - Retrieve resources
app.get('/users', getUsers);
app.get('/users/:id', getUser);

// POST - Create resources
app.post('/users', createUser);

// PUT - Update entire resource
app.put('/users/:id', updateUser);

// PATCH - Partial update
app.patch('/users/:id', patchUser);

// DELETE - Delete resource
app.delete('/users/:id', deleteUser);
```

### Status Codes

```javascript
// Success
res.status(200).json(data); // OK
res.status(201).json(data); // Created
res.status(204).send();     // No Content

// Client errors
res.status(400).json({ error: 'Bad Request' });
res.status(401).json({ error: 'Unauthorized' });
res.status(403).json({ error: 'Forbidden' });
res.status(404).json({ error: 'Not Found' });
res.status(422).json({ error: 'Unprocessable Entity' });

// Server errors
res.status(500).json({ error: 'Internal Server Error' });
res.status(503).json({ error: 'Service Unavailable' });
```

### Resource Naming

```javascript
// ✅ Good - Nouns, plural
GET    /users
GET    /users/123
POST   /users
PUT    /users/123
DELETE /users/123

// ❌ Bad - Verbs, singular
GET    /getUser
POST   /createUser
DELETE /deleteUser
```

## 📝 API Response Format

```javascript
// Success response
{
  "status": "success",
  "data": {
    "id": 1,
    "name": "John",
    "email": "john@example.com"
  }
}

// Error response
{
  "status": "error",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": {
      "field": "email",
      "constraint": "required"
    }
  }
}

// List response
{
  "status": "success",
  "data": [
    { "id": 1, "name": "John" },
    { "id": 2, "name": "Jane" }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 100,
    "totalPages": 10
  }
}
```

## 🔍 Query Parameters

```javascript
// Pagination
app.get('/users', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  
  // Fetch users with pagination
  const users = await User.findAll({ limit, offset });
  res.json({ users, page, limit });
});

// Filtering
app.get('/users', (req, res) => {
  const { status, role } = req.query;
  const where = {};
  
  if (status) where.status = status;
  if (role) where.role = role;
  
  const users = await User.findAll({ where });
  res.json({ users });
});

// Sorting
app.get('/users', (req, res) => {
  const sortBy = req.query.sortBy || 'createdAt';
  const order = req.query.order || 'DESC';
  
  const users = await User.findAll({
    order: [[sortBy, order]]
  });
  res.json({ users });
});
```

## 📦 Versioning

```javascript
// URL versioning
app.use('/api/v1/users', v1UserRoutes);
app.use('/api/v2/users', v2UserRoutes);

// Header versioning
app.use('/api/users', (req, res, next) => {
  const version = req.headers['api-version'] || 'v1';
  if (version === 'v2') {
    return v2Handler(req, res, next);
  }
  v1Handler(req, res, next);
});
```

---

**Next**: Learn about [Error Handling](./ERROR-HANDLING-EXPRESS.md)

