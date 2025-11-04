# Express Security Best Practices

## 📚 Overview

Security is crucial for protecting Express applications and user data.

## 🛡️ Security Headers (Helmet)

```javascript
const helmet = require('helmet');
app.use(helmet());

// Custom configuration
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
    },
  },
}));
```

## 🔒 Input Validation

```javascript
const { body, validationResult } = require('express-validator');

app.post('/users',
  [
    body('email').isEmail().normalizeEmail(),
    body('password').isLength({ min: 8 }).matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
    body('age').isInt({ min: 0, max: 120 })
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process
  }
);
```

## 🚫 SQL Injection Prevention

```javascript
// ❌ Vulnerable
app.get('/users', (req, res) => {
  const query = `SELECT * FROM users WHERE name = '${req.query.name}'`;
  // SQL injection possible
});

// ✅ Safe - Use parameterized queries
app.get('/users', async (req, res) => {
  const users = await User.findAll({
    where: { name: req.query.name }
  });
  res.json({ users });
});
```

## 🔐 XSS Prevention

```javascript
// Sanitize user input
const expressSanitizer = require('express-sanitizer');
app.use(expressSanitizer());

app.post('/posts', (req, res) => {
  const content = req.sanitize(req.body.content);
  // Save sanitized content
});
```

## 🍪 Secure Cookies

```javascript
app.use(session({
  secret: process.env.SESSION_SECRET,
  cookie: {
    secure: true,        // HTTPS only
    httpOnly: true,      // No JavaScript access
    sameSite: 'strict',  // CSRF protection
    maxAge: 24 * 60 * 60 * 1000
  }
}));
```

## 🔑 Environment Variables

```javascript
// Use environment variables
require('dotenv').config();

const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET;
const DB_PASSWORD = process.env.DB_PASSWORD;

// Never commit .env file
```

## 🚦 Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // Limit each IP to 100 requests per windowMs
});

app.use('/api/', limiter);
```

## 🔒 HTTPS

```javascript
// Force HTTPS
app.use((req, res, next) => {
  if (req.header('x-forwarded-proto') !== 'https') {
    res.redirect(`https://${req.header('host')}${req.url}`);
  } else {
    next();
  }
});
```

---

**Next**: Learn about [Advanced Node.js](./../03-Advanced-Node/documentation/NODE-CLUSTERING.md)

