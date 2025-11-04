# Express.js Fundamentals

## 📚 Overview

Express is a minimal and flexible Node.js web application framework.

## 🚀 Installation

```bash
npm install express
```

## 🎯 Basic Setup

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Basic route
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

## 🛣️ Routing

### Basic Routes

```javascript
// GET request
app.get('/users', (req, res) => {
  res.json({ users: [] });
});

// POST request
app.post('/users', (req, res) => {
  res.status(201).json({ message: 'User created' });
});

// PUT request
app.put('/users/:id', (req, res) => {
  res.json({ message: 'User updated' });
});

// DELETE request
app.delete('/users/:id', (req, res) => {
  res.json({ message: 'User deleted' });
});
```

### Route Parameters

```javascript
// Route parameters
app.get('/users/:id', (req, res) => {
  const userId = req.params.id;
  res.json({ userId });
});

// Multiple parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  const { userId, postId } = req.params;
  res.json({ userId, postId });
});
```

### Query Parameters

```javascript
app.get('/search', (req, res) => {
  const { q, page, limit } = req.query;
  res.json({ q, page, limit });
});
```

### Route Handlers

```javascript
// Multiple handlers
app.get('/users',
  (req, res, next) => {
    console.log('Middleware 1');
    next();
  },
  (req, res, next) => {
    console.log('Middleware 2');
    next();
  },
  (req, res) => {
    res.json({ users: [] });
  }
);
```

## 📝 Request Object

```javascript
app.get('/example', (req, res) => {
  // Properties
  req.params;      // Route parameters
  req.query;       // Query string
  req.body;        // Request body (needs body-parser)
  req.headers;     // Request headers
  req.cookies;      // Cookies (needs cookie-parser)
  req.ip;          // Client IP
  req.path;        // Request path
  req.method;      // HTTP method
});
```

## 📤 Response Object

```javascript
app.get('/example', (req, res) => {
  // Send response
  res.send('Text');
  res.json({ data: 'value' });
  res.sendFile('/path/to/file.html');
  
  // Status codes
  res.status(404).send('Not Found');
  res.status(201).json({ created: true });
  
  // Headers
  res.set('Content-Type', 'application/json');
  res.setHeader('X-Custom', 'value');
  
  // Cookies
  res.cookie('name', 'value', { maxAge: 3600000 });
  res.clearCookie('name');
  
  // Redirect
  res.redirect('/new-path');
});
```

## 🧩 Middleware

### Application-Level Middleware

```javascript
// Runs for all routes
app.use((req, res, next) => {
  console.log('Request:', req.method, req.path);
  next();
});

// Specific path
app.use('/api', (req, res, next) => {
  console.log('API request');
  next();
});
```

### Router-Level Middleware

```javascript
const router = express.Router();

router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});

router.get('/users', (req, res) => {
  res.json({ users: [] });
});

app.use('/api', router);
```

### Error Handling Middleware

```javascript
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong' });
});
```

### Built-in Middleware

```javascript
// JSON parser
app.use(express.json());

// URL encoded
app.use(express.urlencoded({ extended: true }));

// Static files
app.use(express.static('public'));

// CORS
const cors = require('cors');
app.use(cors());
```

### Third-Party Middleware

```javascript
// Logger
const morgan = require('morgan');
app.use(morgan('combined'));

// Helmet (security)
const helmet = require('helmet');
app.use(helmet());

// Body parser
const bodyParser = require('body-parser');
app.use(bodyParser.json());
```

## 📦 Project Structure

```
my-app/
├── routes/
│   ├── users.js
│   └── posts.js
├── controllers/
│   ├── userController.js
│   └── postController.js
├── models/
│   ├── User.js
│   └── Post.js
├── middleware/
│   ├── auth.js
│   └── validation.js
├── config/
│   └── database.js
├── app.js
└── server.js
```

---

**Next**: Learn about [Routing Mastery](./ROUTING-MASTERY.md)

