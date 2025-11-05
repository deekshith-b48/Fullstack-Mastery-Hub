# JWT Tokens Security

## 📚 Overview

JSON Web Tokens (JWT) are a popular method for securely transmitting information between parties. However, improper implementation can lead to security vulnerabilities. This guide covers secure JWT implementation, common vulnerabilities, and best practices.

## 🎯 What is JWT?

JWT is a compact, URL-safe token format that consists of three parts: header, payload, and signature. JWTs are commonly used for authentication and authorization in web applications.

### JWT Structure

```
header.payload.signature
```

### JWT Components

1. **Header**: Algorithm and token type
2. **Payload**: Claims (user data, expiration, etc.)
3. **Signature**: Verifies token integrity

## 🔍 JWT Creation

### Basic JWT Implementation

```javascript
// JWT creation
const jwt = require('jsonwebtoken');
const crypto = require('crypto');

// Generate JWT
function generateToken(user) {
  const payload = {
    userId: user.id,
    email: user.email,
    role: user.role,
    iat: Math.floor(Date.now() / 1000), // Issued at
    exp: Math.floor(Date.now() / 1000) + 3600 // Expires in 1 hour
  };
  
  return jwt.sign(payload, process.env.JWT_SECRET, {
    algorithm: 'HS256',
    issuer: 'myapp',
    audience: 'myapp-users'
  });
}

// Verify JWT
function verifyToken(token) {
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET, {
      algorithms: ['HS256'],
      issuer: 'myapp',
      audience: 'myapp-users'
    });
    
    return decoded;
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      throw new Error('Token expired');
    }
    if (error.name === 'JsonWebTokenError') {
      throw new Error('Invalid token');
    }
    throw error;
  }
}
```

## 🔍 Secure JWT Implementation

### RSA Signing (Recommended)

```javascript
// Use RSA for signing (more secure than HMAC)
const fs = require('fs');

const privateKey = fs.readFileSync('private.pem', 'utf8');
const publicKey = fs.readFileSync('public.pem', 'utf8');

function generateToken(user) {
  const payload = {
    userId: user.id,
    email: user.email,
    role: user.role
  };
  
  return jwt.sign(payload, privateKey, {
    algorithm: 'RS256', // RSA with SHA-256
    expiresIn: '1h',
    issuer: 'myapp',
    audience: 'myapp-users'
  });
}

function verifyToken(token) {
  return jwt.verify(token, publicKey, {
    algorithms: ['RS256'],
    issuer: 'myapp',
    audience: 'myapp-users'
  });
}
```

### Token Refresh

```javascript
// JWT refresh token implementation
function generateTokenPair(user) {
  // Short-lived access token
  const accessToken = jwt.sign(
    { userId: user.id, type: 'access' },
    process.env.JWT_SECRET,
    { expiresIn: '15m' }
  );
  
  // Long-lived refresh token
  const refreshToken = jwt.sign(
    { userId: user.id, type: 'refresh', tokenId: crypto.randomBytes(16).toString('hex') },
    process.env.JWT_REFRESH_SECRET,
    { expiresIn: '7d' }
  );
  
  // Store refresh token
  RefreshToken.create({
    userId: user.id,
    token: refreshToken,
    expiresAt: Date.now() + (7 * 24 * 60 * 60 * 1000)
  });
  
  return { accessToken, refreshToken };
}

// Refresh access token
app.post('/api/refresh', async (req, res) => {
  const { refreshToken } = req.body;
  
  try {
    // Verify refresh token
    const decoded = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);
    
    if (decoded.type !== 'refresh') {
      throw new Error('Invalid token type');
    }
    
    // Check if token exists in database
    const storedToken = await RefreshToken.findOne({
      token: refreshToken,
      userId: decoded.userId,
      revoked: false,
      expiresAt: { $gt: Date.now() }
    });
    
    if (!storedToken) {
      throw new Error('Invalid refresh token');
    }
    
    // Generate new access token
    const user = await User.findById(decoded.userId);
    const accessToken = generateToken(user);
    
    res.json({ accessToken });
  } catch (error) {
    res.status(401).json({ error: 'Invalid refresh token' });
  }
});
```

## 🔍 JWT Vulnerabilities

### Algorithm Confusion Attack

```javascript
// VULNERABLE CODE - Algorithm confusion
function verifyToken(token) {
  // If algorithm is not specified, jwt.verify might accept 'none' algorithm
  return jwt.verify(token, process.env.JWT_SECRET);
  // Attacker can create token with algorithm: 'none' and no signature
}

// SECURE CODE - Specify allowed algorithms
function verifyToken(token) {
  return jwt.verify(token, process.env.JWT_SECRET, {
    algorithms: ['HS256', 'RS256'] // Explicitly specify allowed algorithms
  });
}
```

### Weak Secret

```javascript
// VULNERABLE CODE - Weak secret
const weakSecret = 'secret123'; // Too weak!

// SECURE CODE - Strong secret
const strongSecret = crypto.randomBytes(64).toString('hex');
// Store in environment variable
process.env.JWT_SECRET = strongSecret;
```

### Token Expiration

```javascript
// VULNERABLE CODE - No expiration
function generateToken(user) {
  return jwt.sign({ userId: user.id }, secret); // Never expires!
}

// SECURE CODE - Short expiration
function generateToken(user) {
  return jwt.sign(
    { userId: user.id },
    secret,
    { expiresIn: '15m' } // Short expiration
  );
}
```

## 🔍 JWT Security Best Practices

### 1. Token Storage

```javascript
// SECURE CODE - HTTP-only cookies
app.post('/api/login', async (req, res) => {
  const token = generateToken(user);
  
  res.cookie('accessToken', token, {
    httpOnly: true, // Prevents JavaScript access
    secure: true, // HTTPS only
    sameSite: 'strict', // CSRF protection
    maxAge: 900000 // 15 minutes
  });
  
  res.json({ success: true });
});

// VULNERABLE CODE - Local storage
// localStorage.setItem('token', token); // Vulnerable to XSS!
```

### 2. Token Rotation

```javascript
// Token rotation on refresh
async function refreshToken(oldRefreshToken) {
  // Verify old token
  const decoded = jwt.verify(oldRefreshToken, process.env.JWT_REFRESH_SECRET);
  
  // Revoke old token
  await RefreshToken.updateOne(
    { token: oldRefreshToken },
    { revoked: true }
  );
  
  // Generate new token pair
  const user = await User.findById(decoded.userId);
  return generateTokenPair(user);
}
```

### 3. Token Blacklisting

```javascript
// Blacklist revoked tokens
const blacklistedTokens = new Set();

function blacklistToken(token) {
  const decoded = jwt.decode(token);
  if (decoded && decoded.exp) {
    // Store until expiration
    blacklistedTokens.add(token);
    
    // Remove after expiration
    setTimeout(() => {
      blacklistedTokens.delete(token);
    }, (decoded.exp - Math.floor(Date.now() / 1000)) * 1000);
  }
}

function isTokenBlacklisted(token) {
  return blacklistedTokens.has(token);
}

// Middleware to check blacklist
function authenticateToken(req, res, next) {
  const token = extractToken(req);
  
  if (isTokenBlacklisted(token)) {
    return res.status(401).json({ error: 'Token revoked' });
  }
  
  // Verify token
  try {
    const decoded = verifyToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
}
```

### 4. Token Claims

```javascript
// Secure token payload
function generateToken(user) {
  const payload = {
    // Minimal claims
    sub: user.id, // Subject (user ID)
    iat: Math.floor(Date.now() / 1000), // Issued at
    exp: Math.floor(Date.now() / 1000) + 3600, // Expiration
    iss: 'myapp', // Issuer
    aud: 'myapp-users', // Audience
    
    // Don't include sensitive data
    // password: user.password, // NEVER!
    // secret: user.secret, // NEVER!
    
    // Only include necessary claims
    role: user.role,
    email: user.email
  };
  
  return jwt.sign(payload, secret, { algorithm: 'HS256' });
}
```

## 🔍 JWT Validation

### Comprehensive Token Validation

```javascript
function validateToken(token) {
  // Step 1: Check if token exists
  if (!token) {
    throw new Error('No token provided');
  }
  
  // Step 2: Check if token is blacklisted
  if (isTokenBlacklisted(token)) {
    throw new Error('Token revoked');
  }
  
  // Step 3: Decode token (without verification)
  const decoded = jwt.decode(token);
  if (!decoded) {
    throw new Error('Invalid token format');
  }
  
  // Step 4: Check expiration
  if (decoded.exp && decoded.exp < Math.floor(Date.now() / 1000)) {
    throw new Error('Token expired');
  }
  
  // Step 5: Verify signature
  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET, {
      algorithms: ['HS256'],
      issuer: 'myapp',
      audience: 'myapp-users'
    });
    
    // Step 6: Check additional claims
    if (verified.type && verified.type !== 'access') {
      throw new Error('Invalid token type');
    }
    
    return verified;
  } catch (error) {
    throw new Error('Token verification failed');
  }
}
```

## 🔍 JWT in Different Environments

### Stateless Authentication

```javascript
// Stateless JWT authentication
function authenticateToken(req, res, next) {
  const token = extractToken(req);
  
  try {
    const decoded = validateToken(token);
    
    // No database lookup needed (stateless)
    req.user = {
      id: decoded.userId,
      email: decoded.email,
      role: decoded.role
    };
    
    next();
  } catch (error) {
    res.status(401).json({ error: error.message });
  }
}
```

### Stateful Authentication with JWT

```javascript
// JWT with database validation
async function authenticateToken(req, res, next) {
  const token = extractToken(req);
  
  try {
    const decoded = validateToken(token);
    
    // Verify user still exists
    const user = await User.findById(decoded.userId);
    if (!user || !user.active) {
      throw new Error('User not found or inactive');
    }
    
    // Check if user changed password (invalidate old tokens)
    if (user.passwordChangedAt && decoded.iat < user.passwordChangedAt / 1000) {
      throw new Error('Token invalidated');
    }
    
    req.user = user;
    next();
  } catch (error) {
    res.status(401).json({ error: error.message });
  }
}
```

## 🛡️ JWT Security Checklist

- [ ] Use strong secrets (minimum 256 bits)
- [ ] Specify allowed algorithms explicitly
- [ ] Set appropriate expiration times
- [ ] Store tokens securely (HTTP-only cookies)
- [ ] Implement token rotation
- [ ] Validate all token claims
- [ ] Implement token blacklisting
- [ ] Use HTTPS for token transmission
- [ ] Monitor token usage
- [ ] Log security events

## 🎯 Best Practices

1. **Strong Secrets**: Use cryptographically random secrets
2. **Algorithm Specification**: Always specify allowed algorithms
3. **Short Expiration**: Use short-lived access tokens
4. **Secure Storage**: Store tokens in HTTP-only cookies
5. **Token Rotation**: Rotate tokens on refresh
6. **Claim Validation**: Validate all token claims
7. **Monitoring**: Monitor token usage and anomalies

## 🎓 Learning Resources

- JWT Specification: https://tools.ietf.org/html/rfc7519
- JWT Best Practices: https://tools.ietf.org/html/rfc8725
- JWT Security: https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html

---

**Next**: Learn about [Session Management](./SESSION-MANAGEMENT.md)

