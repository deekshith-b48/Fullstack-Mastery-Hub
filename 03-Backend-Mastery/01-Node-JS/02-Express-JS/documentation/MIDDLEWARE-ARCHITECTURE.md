# Express Middleware Architecture

## 📚 Overview

Middleware functions execute during the request-response cycle and can modify request/response objects.

## 🔄 Middleware Flow

```
Request → Middleware 1 → Middleware 2 → Route Handler → Response
```

## 🎯 Types of Middleware

### Application-Level

```javascript
// Runs for every request
app.use((req, res, next) => {
  console.log('Request:', req.method, req.path);
  next();
});

// Specific path
app.use('/api', (req, res, next) => {
  req.apiRequest = true;
  next();
});
```

### Router-Level

```javascript
const router = express.Router();

router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});
```

### Error-Handling Middleware

```javascript
// Must have 4 parameters
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: err.message || 'Internal Server Error'
  });
});
```

### Built-in Middleware

```javascript
// Parse JSON bodies
app.use(express.json());

// Parse URL-encoded bodies
app.use(express.urlencoded({ extended: true }));

// Serve static files
app.use(express.static('public'));

// Trust proxy
app.set('trust proxy', true);
```

## 🔧 Custom Middleware Examples

### Logger Middleware

```javascript
function logger(req, res, next) {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] ${req.method} ${req.path}`);
  next();
}

app.use(logger);
```

### Authentication Middleware

```javascript
function authenticate(req, res, next) {
  const token = req.headers.authorization;
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    res.status(401).json({ error: 'Invalid token' });
  }
}

app.get('/protected', authenticate, (req, res) => {
  res.json({ user: req.user });
});
```

### Validation Middleware

```javascript
function validateUser(req, res, next) {
  const { email, password } = req.body;
  
  if (!email || !password) {
    return res.status(400).json({
      error: 'Email and password required'
    });
  }
  
  if (password.length < 8) {
    return res.status(400).json({
      error: 'Password must be at least 8 characters'
    });
  }
  
  next();
}

app.post('/users', validateUser, createUser);
```

### CORS Middleware

```javascript
function corsMiddleware(req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type,Authorization');
  
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  
  next();
}

app.use(corsMiddleware);
```

## 📦 Middleware Execution Order

```javascript
// Execution order matters
app.use(middleware1); // Runs first
app.use('/api', middleware2); // Runs for /api routes
app.use('/api/users', middleware3); // Runs for /api/users routes

app.get('/api/users', handler); // middleware1, middleware2, middleware3, handler
```

## 🎯 Conditional Middleware

```javascript
function conditionalMiddleware(req, res, next) {
  if (req.path.startsWith('/api')) {
    // Apply middleware
    req.apiRequest = true;
  }
  next();
}

app.use(conditionalMiddleware);
```

## 🔄 Chaining Middleware

```javascript
const middleware1 = (req, res, next) => {
  console.log('Middleware 1');
  next();
};

const middleware2 = (req, res, next) => {
  console.log('Middleware 2');
  next();
};

app.use(middleware1, middleware2);
```

---

**Next**: Learn about [Authentication Systems](./AUTHENTICATION-SYSTEMS.md)

