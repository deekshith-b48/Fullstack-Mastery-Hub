# API Authentication

## 📚 Overview

API authentication verifies the identity of API clients. It's essential for protecting APIs from unauthorized access.

## 🎯 Authentication Methods

### Methods

1. **API Keys**: Simple key-based auth
2. **OAuth2**: Token-based auth
3. **JWT**: JSON Web Tokens
4. **Basic Auth**: HTTP Basic (less secure)

## 🔍 API Key Authentication

### API Key Implementation

```javascript
// API key authentication
async function authenticateAPIKey(req, res, next) {
  const apiKey = req.headers['x-api-key'];
  
  if (!apiKey) {
    return res.status(401).json({ error: 'API key required' });
  }
  
  const key = await APIKey.findOne({
    key: apiKey,
    active: true
  });
  
  if (!key) {
    return res.status(401).json({ error: 'Invalid API key' });
  }
  
  req.apiKey = key;
  next();
}
```

## 🔍 OAuth2 Authentication

### OAuth2 Implementation

```javascript
// OAuth2 authentication
const oauth2 = require('simple-oauth2');

const client = oauth2.create({
  client: {
    id: process.env.OAUTH_CLIENT_ID,
    secret: process.env.OAUTH_CLIENT_SECRET
  },
  auth: {
    tokenHost: 'https://oauth.example.com'
  }
});

async function authenticateOAuth2(req, res, next) {
  const token = extractToken(req);
  
  try {
    const accessToken = client.createToken(token);
    const valid = await accessToken.verify();
    
    if (!valid) {
      return res.status(401).json({ error: 'Invalid token' });
    }
    
    req.user = accessToken.token.user;
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Authentication failed' });
  }
}
```

## 🔍 JWT Authentication

### JWT Implementation

```javascript
// JWT authentication
const jwt = require('jsonwebtoken');

function authenticateJWT(req, res, next) {
  const token = extractToken(req);
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(401).json({ error: 'Invalid token' });
    }
    
    req.user = decoded;
    next();
  });
}
```

## 🛡️ Best Practices

1. **Strong Methods**: Use OAuth2 or JWT
2. **HTTPS**: Always use HTTPS
3. **Token Expiration**: Set token expiration
4. **Refresh Tokens**: Use refresh tokens
5. **Secure Storage**: Secure token storage
6. **Monitoring**: Monitor authentication
7. **Documentation**: Document auth methods

---

**Next**: Learn about [API Authorization](./API-AUTHORIZATION.md)

