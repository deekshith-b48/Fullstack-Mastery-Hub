# JWT Tokens

## 📚 Overview

JWT (JSON Web Tokens) are a compact way to securely transmit information.

## 🎯 Token Structure

```
Header.Payload.Signature
```

```json
{
  "header": {
    "alg": "HS256",
    "typ": "JWT"
  },
  "payload": {
    "userId": 123,
    "exp": 1640995200
  }
}
```

## 🔐 Implementation

```javascript
const jwt = require('jsonwebtoken');

// Generate token
const token = jwt.sign(
  { userId: 123 },
  process.env.JWT_SECRET,
  { expiresIn: '7d' }
);

// Verify token
const decoded = jwt.verify(token, process.env.JWT_SECRET);
```

---

**Next**: Learn about [OAuth2 & OpenID](./OAUTH2-OPENID.md)

