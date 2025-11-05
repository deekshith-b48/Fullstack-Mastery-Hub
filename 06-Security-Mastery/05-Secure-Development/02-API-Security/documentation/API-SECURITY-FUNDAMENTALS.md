# API Security Fundamentals

## 📚 Overview

API security protects APIs from attacks and unauthorized access. It includes authentication, authorization, input validation, and rate limiting.

## 🎯 API Security Principles

### Core Principles

1. **Authentication**: Verify API clients
2. **Authorization**: Control API access
3. **Input Validation**: Validate API inputs
4. **Rate Limiting**: Prevent abuse
5. **Encryption**: Encrypt API traffic

## 🔍 API Authentication

### API Key Authentication

```javascript
// API key authentication
async function authenticateAPIKey(apiKey) {
  const key = await APIKey.findOne({
    key: apiKey,
    active: true,
    expiresAt: { $gt: Date.now() }
  });
  
  if (!key) {
    throw new Error('Invalid API key');
  }
  
  // Update usage
  key.lastUsed = Date.now();
  key.usageCount++;
  await key.save();
  
  return key;
}
```

## 🔍 API Authorization

### OAuth2 Authorization

```javascript
// OAuth2 API authorization
function requireOAuth2Scope(scope) {
  return (req, res, next) => {
    const tokenScopes = req.user.scopes || [];
    
    if (!tokenScopes.includes(scope)) {
      return res.status(403).json({
        error: 'Insufficient scope',
        required: scope
      });
    }
    
    next();
  };
}
```

## 🔍 Rate Limiting

### API Rate Limiting

```javascript
// API rate limiting
const rateLimit = require('express-rate-limit');

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests
  keyGenerator: (req) => req.apiKey?.id || req.ip,
  message: 'Too many requests'
});

app.use('/api/', apiLimiter);
```

## 🛡️ Best Practices

1. **Authentication**: Strong authentication
2. **Authorization**: Proper authorization
3. **Validation**: Validate all inputs
4. **Rate Limiting**: Implement rate limits
5. **Encryption**: Use HTTPS
6. **Monitoring**: Monitor API usage
7. **Documentation**: Document API security

---

**Next**: Learn about [REST API Security](./REST-API-SECURITY.md)

