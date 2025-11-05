# API Authorization

## 📚 Overview

API authorization ensures that only authorized clients and users can access API endpoints and perform specific actions. This involves validating API keys, tokens, and user permissions.

## 🎯 API Authorization Methods

### 1. API Key Authorization

```javascript
// API key validation
async function validateAPIKey(apiKey) {
  const keyRecord = await APIKey.findOne({
    key: apiKey,
    active: true,
    expiresAt: { $gt: Date.now() }
  });
  
  if (!keyRecord) {
    throw new Error('Invalid API key');
  }
  
  // Update usage
  keyRecord.lastUsed = Date.now();
  keyRecord.usageCount++;
  await keyRecord.save();
  
  return keyRecord;
}

// API key middleware
function requireAPIKey(req, res, next) {
  const apiKey = req.headers['x-api-key'];
  
  if (!apiKey) {
    return res.status(401).json({ error: 'API key required' });
  }
  
  validateAPIKey(apiKey)
    .then(keyRecord => {
      req.apiKey = keyRecord;
      next();
    })
    .catch(error => {
      res.status(401).json({ error: error.message });
    });
}
```

### 2. Token-Based Authorization

```javascript
// JWT token authorization
function requireAuth(req, res, next) {
  const token = extractToken(req);
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = verifyToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
}

// Scoped authorization
function requireScope(scope) {
  return (req, res, next) => {
    if (!req.user || !req.user.scopes) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    
    if (!req.user.scopes.includes(scope)) {
      return res.status(403).json({ error: 'Insufficient scope' });
    }
    
    next();
  };
}
```

## 🔍 Resource-Level Authorization

### Endpoint Authorization

```javascript
// Resource ownership check
async function checkResourceAccess(req, res, next) {
  const resourceId = req.params.id;
  const resource = await Resource.findById(resourceId);
  
  if (!resource) {
    return res.status(404).json({ error: 'Resource not found' });
  }
  
  // Check ownership or permissions
  if (resource.userId !== req.user.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  req.resource = resource;
  next();
}

// Usage
app.get('/api/resources/:id',
  requireAuth,
  checkResourceAccess,
  getResource
);
```

## 🔍 Rate Limiting by API Key

```javascript
// Rate limiting based on API key tier
async function checkRateLimit(req, res, next) {
  const apiKey = req.apiKey;
  
  const limits = {
    free: { requests: 100, window: 3600000 }, // 100/hour
    pro: { requests: 1000, window: 3600000 }, // 1000/hour
    enterprise: { requests: 10000, window: 3600000 } // 10000/hour
  };
  
  const limit = limits[apiKey.tier] || limits.free;
  
  const key = `ratelimit:${apiKey.id}`;
  const count = await redis.incr(key);
  
  if (count === 1) {
    await redis.expire(key, Math.floor(limit.window / 1000));
  }
  
  if (count > limit.requests) {
    return res.status(429).json({ 
      error: 'Rate limit exceeded',
      retryAfter: await redis.ttl(key)
    });
  }
  
  res.setHeader('X-RateLimit-Limit', limit.requests);
  res.setHeader('X-RateLimit-Remaining', limit.requests - count);
  
  next();
}
```

## 🛡️ Best Practices

1. **API Key Security**: Use secure key generation
2. **Token Validation**: Validate all tokens
3. **Scope Limitation**: Use OAuth2 scopes
4. **Rate Limiting**: Implement rate limits
5. **Logging**: Log all API access
6. **Monitoring**: Monitor API usage

---

**Next**: Learn about [OAuth2 Scopes](./OAUTH2-SCOPES.md)

