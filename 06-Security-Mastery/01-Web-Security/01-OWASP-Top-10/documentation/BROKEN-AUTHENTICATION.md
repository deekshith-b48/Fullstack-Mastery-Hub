# Broken Authentication

## 📚 Overview

Broken authentication vulnerabilities occur when authentication mechanisms are implemented incorrectly, allowing attackers to compromise passwords, keys, session tokens, or exploit implementation flaws to assume other users' identities.

## 🎯 What is Broken Authentication?

Broken authentication is a critical security flaw that allows attackers to bypass authentication controls or take over user accounts. This vulnerability often results from poor implementation of authentication systems.

### Common Authentication Flaws

1. **Weak Password Policies**: Easily guessable passwords
2. **Credential Stuffing**: Using breached credentials
3. **Session Fixation**: Attackers fixate session IDs
4. **Weak Session Management**: Predictable or insecure session tokens
5. **Missing Multi-Factor Authentication**: Single-factor authentication
6. **Insecure Password Storage**: Plain text or weak hashing
7. **Brute Force Vulnerabilities**: No rate limiting
8. **Insecure Password Recovery**: Weak recovery mechanisms

## 🔍 Weak Password Policies

### Vulnerable Password Policies

```javascript
// VULNERABLE CODE - No password requirements
function validatePassword(password) {
  return password.length > 0; // Too weak!
}

// VULNERABLE CODE - Weak requirements
function validatePassword(password) {
  return password.length >= 6; // Too short, no complexity
}
```

### Secure Password Policies

```javascript
// SECURE CODE - Strong password requirements
function validatePassword(password) {
  const minLength = 12;
  const hasUpperCase = /[A-Z]/.test(password);
  const hasLowerCase = /[a-z]/.test(password);
  const hasNumbers = /\d/.test(password);
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
  const commonPasswords = ['password', '123456', 'qwerty', 'admin'];
  
  if (password.length < minLength) {
    throw new Error(`Password must be at least ${minLength} characters`);
  }
  
  if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChar) {
    throw new Error('Password must contain uppercase, lowercase, numbers, and special characters');
  }
  
  if (commonPasswords.includes(password.toLowerCase())) {
    throw new Error('Password is too common');
  }
  
  // Check against password breach database
  if (isBreachedPassword(password)) {
    throw new Error('Password has been found in data breaches');
  }
  
  return true;
}
```

## 🔍 Insecure Password Storage

### Vulnerable Password Storage

```javascript
// VULNERABLE CODE - Plain text storage
function storePassword(userId, password) {
  db.users.update({ id: userId }, { password: password }); // NEVER DO THIS!
}

// VULNERABLE CODE - Weak hashing (MD5, SHA1)
const crypto = require('crypto');
function hashPassword(password) {
  return crypto.createHash('md5').update(password).digest('hex'); // Weak!
}
```

### Secure Password Storage

```javascript
// SECURE CODE - Strong hashing with bcrypt
const bcrypt = require('bcrypt');

async function hashPassword(password) {
  const saltRounds = 12; // Cost factor
  const hashedPassword = await bcrypt.hash(password, saltRounds);
  return hashedPassword;
}

async function verifyPassword(password, hashedPassword) {
  return await bcrypt.compare(password, hashedPassword);
}

// SECURE CODE - Using Argon2 (even better)
const argon2 = require('argon2');

async function hashPassword(password) {
  return await argon2.hash(password, {
    type: argon2.argon2id,
    memoryCost: 65536, // 64 MB
    timeCost: 3,
    parallelism: 4
  });
}
```

## 🔍 Session Management Vulnerabilities

### Vulnerable Session Management

```javascript
// VULNERABLE CODE - Predictable session IDs
function generateSessionId() {
  return Math.random().toString(36).substring(7); // Predictable!
}

// VULNERABLE CODE - Session stored in client
function createSession(userId) {
  const session = {
    userId: userId,
    timestamp: Date.now()
  };
  return Buffer.from(JSON.stringify(session)).toString('base64'); // Insecure!
}
```

### Secure Session Management

```javascript
// SECURE CODE - Cryptographically secure session IDs
const crypto = require('crypto');

function generateSessionId() {
  return crypto.randomBytes(32).toString('hex');
}

// SECURE CODE - Server-side session storage
const sessions = new Map();

function createSession(userId) {
  const sessionId = generateSessionId();
  const session = {
    userId: userId,
    createdAt: Date.now(),
    lastActivity: Date.now(),
    ipAddress: req.ip,
    userAgent: req.headers['user-agent']
  };
  
  sessions.set(sessionId, session);
  
  // Set secure cookie
  res.cookie('sessionId', sessionId, {
    httpOnly: true, // Prevents JavaScript access
    secure: true, // HTTPS only
    sameSite: 'strict', // CSRF protection
    maxAge: 3600000 // 1 hour
  });
  
  return sessionId;
}

function validateSession(sessionId) {
  const session = sessions.get(sessionId);
  
  if (!session) {
    return null;
  }
  
  // Check expiration
  if (Date.now() - session.lastActivity > 3600000) {
    sessions.delete(sessionId);
    return null;
  }
  
  // Update last activity
  session.lastActivity = Date.now();
  
  return session;
}
```

## 🔍 Brute Force Vulnerabilities

### Vulnerable Login

```javascript
// VULNERABLE CODE - No rate limiting
async function login(username, password) {
  const user = await User.findOne({ username });
  if (!user) {
    return { success: false, message: 'Invalid credentials' };
  }
  
  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) {
    return { success: false, message: 'Invalid credentials' };
  }
  
  return { success: true, user };
}
```

### Secure Login with Rate Limiting

```javascript
// SECURE CODE - Rate limiting and account lockout
const rateLimiter = new Map();
const maxAttempts = 5;
const lockoutDuration = 900000; // 15 minutes

async function login(username, password, ipAddress) {
  // Check rate limiting
  const key = `${username}:${ipAddress}`;
  const attempts = rateLimiter.get(key) || { count: 0, lockedUntil: null };
  
  if (attempts.lockedUntil && Date.now() < attempts.lockedUntil) {
    const remaining = Math.ceil((attempts.lockedUntil - Date.now()) / 1000 / 60);
    throw new Error(`Account locked. Try again in ${remaining} minutes.`);
  }
  
  // Check if account is locked in database
  const user = await User.findOne({ username });
  if (!user) {
    // Still increment attempts to prevent username enumeration
    incrementFailedAttempts(key);
    throw new Error('Invalid credentials');
  }
  
  if (user.lockedUntil && Date.now() < user.lockedUntil) {
    const remaining = Math.ceil((user.lockedUntil - Date.now()) / 1000 / 60);
    throw new Error(`Account locked. Try again in ${remaining} minutes.`);
  }
  
  // Verify password
  const isValid = await bcrypt.compare(password, user.password);
  
  if (!isValid) {
    attempts.count++;
    
    if (attempts.count >= maxAttempts) {
      attempts.lockedUntil = Date.now() + lockoutDuration;
      await User.updateOne(
        { username },
        { lockedUntil: attempts.lockedUntil }
      );
    }
    
    rateLimiter.set(key, attempts);
    throw new Error('Invalid credentials');
  }
  
  // Successful login - reset attempts
  rateLimiter.delete(key);
  await User.updateOne({ username }, { lockedUntil: null, failedAttempts: 0 });
  
  // Create session
  const sessionId = createSession(user.id);
  
  // Log successful login
  await logSecurityEvent({
    type: 'login_success',
    userId: user.id,
    ipAddress,
    timestamp: Date.now()
  });
  
  return { success: true, sessionId, user };
}

function incrementFailedAttempts(key) {
  const attempts = rateLimiter.get(key) || { count: 0 };
  attempts.count++;
  rateLimiter.set(key, attempts);
}
```

## 🔍 Missing Multi-Factor Authentication

### Basic Authentication

```javascript
// VULNERABLE CODE - Single factor only
async function login(username, password) {
  const user = await User.findOne({ username });
  const isValid = await bcrypt.compare(password, user.password);
  if (isValid) {
    return createSession(user.id); // No MFA!
  }
}
```

### Multi-Factor Authentication

```javascript
// SECURE CODE - Multi-factor authentication
const speakeasy = require('speakeasy');

async function login(username, password, totpCode) {
  const user = await User.findOne({ username });
  const isValid = await bcrypt.compare(password, user.password);
  
  if (!isValid) {
    throw new Error('Invalid credentials');
  }
  
  // Check if MFA is enabled
  if (user.mfaEnabled) {
    if (!totpCode) {
      // Return MFA required flag
      return { mfaRequired: true, tempToken: generateTempToken(user.id) };
    }
    
    // Verify TOTP code
    const verified = speakeasy.totp.verify({
      secret: user.mfaSecret,
      encoding: 'base32',
      token: totpCode,
      window: 2 // Allow 2 time steps tolerance
    });
    
    if (!verified) {
      throw new Error('Invalid MFA code');
    }
  }
  
  // Create session
  return createSession(user.id);
}

// Setup MFA
function setupMFA(userId) {
  const secret = speakeasy.generateSecret({
    name: `App Name (${userId})`,
    issuer: 'Your Company'
  });
  
  // Store secret temporarily (user needs to verify)
  return {
    secret: secret.base32,
    qrCode: secret.otpauth_url
  };
}
```

## 🔍 Insecure Password Recovery

### Vulnerable Password Recovery

```javascript
// VULNERABLE CODE - Security questions
function resetPassword(username, securityAnswer) {
  const user = User.findOne({ username });
  if (user.securityAnswer === securityAnswer) {
    // Reset password - too weak!
    return generateResetToken(user.id);
  }
}

// VULNERABLE CODE - Email with reset link, no expiration
function sendPasswordReset(username) {
  const token = generateToken();
  const resetLink = `https://example.com/reset?token=${token}`;
  sendEmail(username, resetLink); // No expiration, no one-time use!
}
```

### Secure Password Recovery

```javascript
// SECURE CODE - Secure password reset
const crypto = require('crypto');

async function requestPasswordReset(username) {
  const user = await User.findOne({ username });
  if (!user) {
    // Don't reveal if user exists
    return { success: true, message: 'If the user exists, a reset email will be sent' };
  }
  
  // Generate secure token
  const resetToken = crypto.randomBytes(32).toString('hex');
  const resetHash = await bcrypt.hash(resetToken, 10);
  
  // Store reset token with expiration
  await User.updateOne(
    { username },
    {
      resetToken: resetHash,
      resetTokenExpiry: Date.now() + 3600000, // 1 hour
      resetTokenUsed: false
    }
  );
  
  // Send email with reset link
  const resetLink = `https://example.com/reset?token=${resetToken}`;
  await sendEmail(user.email, {
    subject: 'Password Reset Request',
    body: `Click here to reset your password: ${resetLink}\n\nThis link expires in 1 hour.`
  });
  
  return { success: true };
}

async function resetPassword(token, newPassword) {
  // Find user with valid reset token
  const users = await User.find({ resetTokenExpiry: { $gt: Date.now() } });
  
  for (const user of users) {
    if (user.resetTokenUsed) continue;
    
    const isValid = await bcrypt.compare(token, user.resetToken);
    if (isValid) {
      // Validate new password
      validatePassword(newPassword);
      
      // Update password
      const hashedPassword = await hashPassword(newPassword);
      await User.updateOne(
        { id: user.id },
        {
          password: hashedPassword,
          resetToken: null,
          resetTokenExpiry: null,
          resetTokenUsed: true,
          passwordChangedAt: Date.now()
        }
      );
      
      // Invalidate all sessions
      await invalidateUserSessions(user.id);
      
      return { success: true };
    }
  }
  
  throw new Error('Invalid or expired reset token');
}
```

## 🛡️ Authentication Best Practices

### 1. Strong Password Requirements

- Minimum 12 characters
- Mix of uppercase, lowercase, numbers, special characters
- Check against common passwords
- Check against breached password databases

### 2. Secure Password Storage

- Use bcrypt, Argon2, or scrypt
- Never store passwords in plain text
- Use salt with appropriate cost factor
- Consider password hashing hardware

### 3. Session Security

- Use cryptographically secure session IDs
- Store sessions server-side
- Set secure cookie flags (HttpOnly, Secure, SameSite)
- Implement session timeout
- Rotate session IDs on login

### 4. Rate Limiting

- Limit login attempts per IP
- Limit login attempts per account
- Implement account lockout
- Use CAPTCHA after multiple failures

### 5. Multi-Factor Authentication

- Require MFA for sensitive accounts
- Support TOTP, SMS, email verification
- Provide backup codes
- Allow MFA recovery process

## 📊 Security Monitoring

```javascript
// Monitor authentication events
async function logSecurityEvent(event) {
  await SecurityLog.create({
    type: event.type,
    userId: event.userId,
    ipAddress: event.ipAddress,
    userAgent: event.userAgent,
    timestamp: Date.now(),
    success: event.success,
    details: event.details
  });
  
  // Alert on suspicious activity
  if (event.type === 'failed_login' && event.failedAttempts >= 3) {
    await sendSecurityAlert({
      userId: event.userId,
      message: 'Multiple failed login attempts detected',
      severity: 'high'
    });
  }
}
```

## 🎯 Best Practices

1. **Strong Passwords**: Enforce complex password policies
2. **Secure Storage**: Use strong hashing algorithms
3. **Session Management**: Secure session handling
4. **Rate Limiting**: Prevent brute force attacks
5. **MFA**: Require multi-factor authentication
6. **Monitoring**: Log and monitor authentication events
7. **Recovery**: Secure password recovery mechanisms

## 🎓 Learning Resources

- OWASP Authentication: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/03-Authentication_Testing/
- Password Storage: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- Session Management: https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html

---

**Next**: Learn about [Sensitive Data Exposure](./SENSITIVE-DATA-EXPOSURE.md)

