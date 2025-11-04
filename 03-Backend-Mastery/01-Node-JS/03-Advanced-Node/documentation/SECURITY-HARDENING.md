# Node.js Security Hardening

## 📚 Overview

Security hardening protects Node.js applications from vulnerabilities.

## 🛡️ Security Measures

### 1. Keep Dependencies Updated

```bash
# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Update packages
npm update
```

### 2. Use Environment Variables

```javascript
// Never hardcode secrets
const JWT_SECRET = process.env.JWT_SECRET;
const DB_PASSWORD = process.env.DB_PASSWORD;

// Use dotenv
require('dotenv').config();
```

### 3. Input Validation

```javascript
const validator = require('validator');

function validateInput(input) {
  if (!validator.isEmail(input.email)) {
    throw new Error('Invalid email');
  }
  if (!validator.isLength(input.password, { min: 8 })) {
    throw new Error('Password too short');
  }
}
```

### 4. Helmet.js

```javascript
const helmet = require('helmet');
app.use(helmet());
```

### 5. Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
});

app.use('/api/', limiter);
```

### 6. CORS Configuration

```javascript
const cors = require('cors');

app.use(cors({
  origin: process.env.ALLOWED_ORIGINS.split(','),
  credentials: true
}));
```

---

**Next**: Learn about [Caching Strategies](./CACHING-STRATEGIES.md)

