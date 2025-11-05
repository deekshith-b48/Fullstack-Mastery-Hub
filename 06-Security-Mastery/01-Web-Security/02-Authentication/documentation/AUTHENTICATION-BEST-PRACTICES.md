# Authentication Best Practices

## 📚 Overview

This guide consolidates best practices for implementing secure authentication systems. Following these practices helps protect against common vulnerabilities and ensures robust security.

## 🎯 Core Principles

### 1. Defense in Depth

Implement multiple layers of security:
- Strong password policies
- Multi-factor authentication
- Rate limiting
- Account lockout
- Session management

### 2. Never Trust User Input

Always validate and sanitize:
```javascript
function validateLoginInput(username, password) {
  // Validate username format
  if (!/^[a-zA-Z0-9_]{3,20}$/.test(username)) {
    throw new Error('Invalid username format');
  }
  
  // Validate password
  if (password.length < 12) {
    throw new Error('Password too short');
  }
  
  return { username, password };
}
```

### 3. Secure Password Storage

```javascript
// Always use strong hashing
const bcrypt = require('bcrypt');

async function hashPassword(password) {
  return await bcrypt.hash(password, 12); // Cost factor 12
}

// Never store plain text passwords
// Never use weak algorithms (MD5, SHA1)
```

## 🔍 Password Security

### Strong Password Requirements

- Minimum 12 characters
- Mix of uppercase, lowercase, numbers, special characters
- Check against common passwords
- Check against breached passwords
- Prevent password reuse

### Password Hashing

- Use bcrypt, Argon2, or scrypt
- Cost factor of 10-12 for bcrypt
- Never use MD5, SHA1, or plain text
- Use salt automatically (bcrypt does this)

## 🔍 Multi-Factor Authentication

### When to Require MFA

- Admin accounts
- Financial transactions
- Sensitive data access
- Remote access
- Privilege escalation

### MFA Implementation

- Support TOTP (Google Authenticator)
- Provide backup codes
- Support SMS as alternative
- Allow recovery process

## 🔍 Session Management

### Secure Sessions

```javascript
// Secure session configuration
app.use(session({
  secret: process.env.SESSION_SECRET,
  name: 'sessionId',
  cookie: {
    httpOnly: true,
    secure: true,
    sameSite: 'strict',
    maxAge: 3600000 // 1 hour
  },
  resave: false,
  saveUninitialized: false
}));
```

### Session Security

- Regenerate session ID after login
- Implement absolute timeout (1 hour)
- Implement inactivity timeout (15 minutes)
- Validate IP address and user agent
- Destroy sessions on logout

## 🔍 Rate Limiting

### Implementation

```javascript
const rateLimit = require('express-rate-limit');

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts
  message: 'Too many login attempts, please try again later',
  standardHeaders: true,
  legacyHeaders: false
});

app.post('/api/login', loginLimiter, async (req, res) => {
  // Login logic
});
```

### Account Lockout

- Lock after 5 failed attempts
- Lock for 15-30 minutes
- Send notification email
- Log security event

## 🔍 Error Handling

### Generic Error Messages

```javascript
// Don't reveal if user exists
app.post('/api/login', async (req, res) => {
  const user = await User.findOne({ email: req.body.email });
  const isValid = user && await bcrypt.compare(req.body.password, user.password);
  
  if (!isValid) {
    // Generic error message
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Log detailed error server-side
  logger.error('Login failed', { email: req.body.email, ip: req.ip });
});
```

## 🔍 Logging and Monitoring

### Security Events to Log

- Login attempts (success/failure)
- Password changes
- MFA enrollment/verification
- Account lockouts
- Session creation/destruction
- Privilege changes

### Monitoring

```javascript
// Monitor for suspicious patterns
async function monitorAuthentication() {
  // Multiple failed logins from same IP
  const failedLogins = await SecurityLog.countDocuments({
    type: 'login_failure',
    ipAddress: req.ip,
    timestamp: { $gte: Date.now() - 3600000 }
  });
  
  if (failedLogins >= 10) {
    await sendSecurityAlert({
      type: 'brute_force_attempt',
      ipAddress: req.ip,
      count: failedLogins
    });
  }
}
```

## 🛡️ Security Checklist

- [ ] Strong password requirements enforced
- [ ] Passwords hashed with bcrypt/Argon2
- [ ] MFA available and required for sensitive accounts
- [ ] Rate limiting implemented
- [ ] Account lockout after failed attempts
- [ ] Secure session management
- [ ] Session regeneration after login
- [ ] Proper error handling (no information leakage)
- [ ] Comprehensive logging
- [ ] Security monitoring and alerting

## 🎯 Best Practices Summary

1. **Strong Passwords**: Enforce complexity, check breaches
2. **Secure Storage**: Use strong hashing algorithms
3. **Multi-Factor**: Require MFA for sensitive accounts
4. **Rate Limiting**: Prevent brute force attacks
5. **Session Security**: Secure session management
6. **Error Handling**: Generic error messages
7. **Logging**: Comprehensive security logging
8. **Monitoring**: Active security monitoring

---

**Authentication section complete!** Next: [Authorization Fundamentals](./../03-Authorization/documentation/AUTHORIZATION-FUNDAMENTALS.md)

