# SQL Injection Prevention

## 📚 Overview

SQL injection is a serious security vulnerability.

## 🛡️ Prevention Methods

### 1. Use Parameterized Queries

```javascript
// ❌ Vulnerable
const query = `SELECT * FROM users WHERE email = '${email}'`;

// ✅ Safe
const query = 'SELECT * FROM users WHERE email = ?';
db.query(query, [email]);
```

### 2. Use ORM

```javascript
// Sequelize
const user = await User.findOne({
  where: { email: email }
});

// TypeORM
const user = await userRepository.findOne({
  where: { email: email }
});
```

### 3. Input Sanitization

```javascript
const validator = require('validator');

const email = validator.escape(req.body.email);
const sanitizedEmail = validator.normalizeEmail(email);
```

---

**Next**: Learn about [CORS Configuration](./CORS-CONFIGURATION.md)

