# API Security Best Practices

## 📚 Overview

Comprehensive security practices for API development.

## 🛡️ Best Practices

### 1. Use HTTPS

```javascript
// Always use HTTPS in production
app.use((req, res, next) => {
  if (req.header('x-forwarded-proto') !== 'https') {
    res.redirect(`https://${req.header('host')}${req.url}`);
  } else {
    next();
  }
});
```

### 2. Validate Input

```javascript
const { body, validationResult } = require('express-validator');

app.post('/users',
  body('email').isEmail(),
  body('password').isLength({ min: 8 }),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process request
  }
);
```

### 3. Use Security Headers

```javascript
const helmet = require('helmet');
app.use(helmet());
```

### 4. Log Security Events

```javascript
app.use((req, res, next) => {
  if (req.statusCode === 401 || req.statusCode === 403) {
    logger.warn('Security event', {
      ip: req.ip,
      path: req.path,
      status: res.statusCode
    });
  }
  next();
});
```

---

**Next**: Learn about [Input Validation](./INPUT-VALIDATION.md)

