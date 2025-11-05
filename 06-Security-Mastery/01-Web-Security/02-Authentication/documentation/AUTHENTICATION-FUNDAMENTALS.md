# Authentication Fundamentals

## 📚 Overview

Authentication is the process of verifying the identity of a user, system, or entity. It's a fundamental security mechanism that ensures only authorized users can access protected resources. Understanding authentication principles is essential for building secure applications.

## 🎯 What is Authentication?

Authentication answers the question: "Who are you?" It's the process of confirming that a user is who they claim to be. This is different from authorization, which determines what a user can do.

### Authentication Factors

1. **Something You Know**: Password, PIN, security question
2. **Something You Have**: Token, smart card, phone
3. **Something You Are**: Biometric (fingerprint, face, voice)

### Authentication Types

- **Single-Factor Authentication (SFA)**: One factor (usually password)
- **Multi-Factor Authentication (MFA)**: Two or more factors
- **Two-Factor Authentication (2FA)**: Specifically two factors
- **Passwordless Authentication**: No password required

## 🔍 Authentication Methods

### Password-Based Authentication

```javascript
// Basic password authentication
const bcrypt = require('bcrypt');

async function authenticateUser(username, password) {
  // Step 1: Find user
  const user = await User.findOne({ username });
  if (!user) {
    throw new Error('Invalid credentials');
  }
  
  // Step 2: Verify password
  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) {
    throw new Error('Invalid credentials');
  }
  
  // Step 3: Create session
  const session = await createSession(user.id);
  
  return { user, session };
}
```

### Token-Based Authentication

```javascript
// JWT token authentication
const jwt = require('jsonwebtoken');

function generateToken(user) {
  const payload = {
    userId: user.id,
    email: user.email,
    role: user.role
  };
  
  return jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: '1h',
    issuer: 'myapp',
    audience: 'myapp-users'
  });
}

function verifyToken(token) {
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET, {
      issuer: 'myapp',
      audience: 'myapp-users'
    });
    return decoded;
  } catch (error) {
    throw new Error('Invalid token');
  }
}

// Middleware
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = verifyToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(403).json({ error: 'Invalid token' });
  }
}
```

### Session-Based Authentication

```javascript
// Session-based authentication
const express = require('express');
const session = require('express-session');
const RedisStore = require('connect-redis')(session);

app.use(session({
  store: new RedisStore({
    client: redisClient,
    prefix: 'session:'
  }),
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  name: 'sessionId', // Don't use default 'connect.sid'
  cookie: {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    maxAge: 3600000 // 1 hour
  }
}));

app.post('/api/login', async (req, res) => {
  const user = await authenticateUser(req.body.username, req.body.password);
  
  // Store user ID in session
  req.session.userId = user.id;
  req.session.createdAt = Date.now();
  
  res.json({ success: true });
});

app.get('/api/profile', requireAuth, (req, res) => {
  // User is authenticated via session
  res.json({ userId: req.session.userId });
});
```

## 🔍 Authentication Flow

### Registration Flow

```javascript
// User registration
app.post('/api/register', async (req, res) => {
  const { username, email, password } = req.body;
  
  // Step 1: Validate input
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'Missing required fields' });
  }
  
  if (!isValidEmail(email)) {
    return res.status(400).json({ error: 'Invalid email' });
  }
  
  if (!isStrongPassword(password)) {
    return res.status(400).json({ error: 'Weak password' });
  }
  
  // Step 2: Check if user exists
  const existingUser = await User.findOne({
    $or: [{ username }, { email }]
  });
  
  if (existingUser) {
    return res.status(409).json({ error: 'User already exists' });
  }
  
  // Step 3: Hash password
  const hashedPassword = await bcrypt.hash(password, 12);
  
  // Step 4: Create user
  const user = await User.create({
    username,
    email,
    password: hashedPassword,
    emailVerified: false
  });
  
  // Step 5: Send verification email
  await sendVerificationEmail(user.email, user.verificationToken);
  
  // Step 6: Log security event
  await logSecurityEvent({
    type: 'user_registered',
    userId: user.id,
    ipAddress: req.ip,
    timestamp: Date.now()
  });
  
  res.status(201).json({ 
    success: true,
    message: 'User registered. Please verify your email.'
  });
});
```

### Login Flow

```javascript
// Secure login flow
app.post('/api/login', rateLimit({ windowMs: 15 * 60 * 1000, max: 5 }), async (req, res) => {
  const { username, password, rememberMe } = req.body;
  const ipAddress = req.ip;
  const userAgent = req.headers['user-agent'];
  
  try {
    // Step 1: Find user
    const user = await User.findOne({ username });
    
    // Step 2: Verify password (same message for user not found)
    const isValid = user && await bcrypt.compare(password, user.password);
    
    if (!isValid) {
      // Log failed attempt
      await logSecurityEvent({
        type: 'login_failure',
        username,
        ipAddress,
        userAgent,
        timestamp: Date.now()
      });
      
      // Increment failed attempts
      await incrementFailedAttempts(username, ipAddress);
      
      return res.status(401).json({ error: 'Invalid credentials' });
    }
  
    // Step 3: Check if account is locked
    if (user.lockedUntil && Date.now() < user.lockedUntil) {
      return res.status(423).json({ 
        error: 'Account is locked. Please try again later.' 
      });
    }
  
    // Step 4: Check if email is verified
    if (!user.emailVerified) {
      return res.status(403).json({ 
        error: 'Please verify your email before logging in.' 
      });
    }
  
    // Step 5: Check if MFA is required
    if (user.mfaEnabled) {
      const tempToken = generateTempToken(user.id);
      return res.json({ 
        mfaRequired: true, 
        tempToken 
      });
    }
  
    // Step 6: Create session
    const session = await createSession(user.id, {
      ipAddress,
      userAgent,
      rememberMe
    });
  
    // Step 7: Reset failed attempts
    await resetFailedAttempts(username);
  
    // Step 8: Log successful login
    await logSecurityEvent({
      type: 'login_success',
      userId: user.id,
      ipAddress,
      userAgent,
      timestamp: Date.now()
    });
  
    // Step 9: Send notification (if new device/location)
    if (isNewDevice(user.id, ipAddress)) {
      await sendSecurityNotification(user.email, {
        type: 'new_device_login',
        ipAddress,
        userAgent,
        timestamp: Date.now()
      });
    }
  
    res.json({
      success: true,
      sessionId: session.id,
      user: {
        id: user.id,
        username: user.username,
        email: user.email
      }
    });
  } catch (error) {
    logger.error('Login error', { error, username, ipAddress });
    res.status(500).json({ error: 'An error occurred' });
  }
});
```

## 🔍 Account Lockout

### Implementing Account Lockout

```javascript
// Account lockout mechanism
async function incrementFailedAttempts(username, ipAddress) {
  const key = `failed_attempts:${username}`;
  const attempts = await redis.incr(key);
  await redis.expire(key, 900); // 15 minutes
  
  if (attempts >= 5) {
    // Lock account for 15 minutes
    const lockoutDuration = 15 * 60 * 1000; // 15 minutes
    const lockedUntil = Date.now() + lockoutDuration;
    
    await User.updateOne(
      { username },
      { lockedUntil }
    );
    
    // Send lockout notification
    const user = await User.findOne({ username });
    if (user) {
      await sendEmail(user.email, {
        subject: 'Account Locked',
        body: 'Your account has been locked due to multiple failed login attempts.'
      });
    }
    
    // Log security event
    await logSecurityEvent({
      type: 'account_locked',
      username,
      ipAddress,
      attempts,
      timestamp: Date.now()
    });
  }
  
  return attempts;
}

async function resetFailedAttempts(username) {
  const key = `failed_attempts:${username}`;
  await redis.del(key);
  
  await User.updateOne(
    { username },
    { lockedUntil: null, failedAttempts: 0 }
  );
}
```

## 🔍 Remember Me Functionality

```javascript
// Secure "Remember Me" implementation
function generateRememberMeToken(userId) {
  const token = crypto.randomBytes(32).toString('hex');
  const hashedToken = crypto.createHash('sha256').update(token).digest('hex');
  
  // Store in database with expiration
  RememberMeToken.create({
    userId,
    token: hashedToken,
    expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days
  });
  
  return token;
}

app.post('/api/login', async (req, res) => {
  // ... authentication logic ...
  
  if (req.body.rememberMe) {
    const rememberToken = generateRememberMeToken(user.id);
    
    res.cookie('rememberToken', rememberToken, {
      httpOnly: true,
      secure: true,
      sameSite: 'strict',
      maxAge: 30 * 24 * 60 * 60 * 1000 // 30 days
    });
  }
  
  // ... rest of login logic ...
});

// Check remember me token
async function checkRememberMeToken(token) {
  const hashedToken = crypto.createHash('sha256').update(token).digest('hex');
  const rememberToken = await RememberMeToken.findOne({
    token: hashedToken,
    expiresAt: { $gt: new Date() }
  });
  
  if (!rememberToken) {
    return null;
  }
  
  // Delete token after use (one-time use)
  await RememberMeToken.deleteOne({ _id: rememberToken._id });
  
  // Generate new token
  const newToken = generateRememberMeToken(rememberToken.userId);
  
  return {
    userId: rememberToken.userId,
    newToken: newToken
  };
}
```

## 🛡️ Authentication Best Practices

### 1. Password Security

- Enforce strong password policies
- Use secure password hashing (bcrypt, Argon2)
- Never store passwords in plain text
- Implement password complexity requirements

### 2. Session Security

- Use secure session storage
- Implement session timeout
- Rotate session IDs
- Use secure cookie flags

### 3. Rate Limiting

- Limit login attempts per IP
- Limit login attempts per account
- Implement progressive delays
- Use CAPTCHA after multiple failures

### 4. Logging and Monitoring

- Log all authentication attempts
- Monitor for suspicious patterns
- Alert on brute force attacks
- Track failed login attempts

## 📊 Authentication Metrics

```javascript
// Track authentication metrics
async function getAuthenticationMetrics() {
  const metrics = {
    totalLogins: await SecurityLog.countDocuments({ 
      eventType: 'login_success',
      timestamp: { $gte: startOfDay() }
    }),
    
    failedLogins: await SecurityLog.countDocuments({
      eventType: 'login_failure',
      timestamp: { $gte: startOfDay() }
    }),
    
    uniqueUsers: await SecurityLog.distinct('userId', {
      eventType: 'login_success',
      timestamp: { $gte: startOfDay() }
    }).length,
    
    topIPAddresses: await SecurityLog.aggregate([
      { $match: { eventType: 'login_failure', timestamp: { $gte: startOfDay() } } },
      { $group: { _id: '$ipAddress', count: { $sum: 1 } } },
      { $sort: { count: -1 } },
      { $limit: 10 }
    ])
  };
  
  return metrics;
}
```

## 🎯 Best Practices

1. **Strong Passwords**: Enforce complex password requirements
2. **Secure Storage**: Use strong hashing algorithms
3. **Session Management**: Secure session handling
4. **Rate Limiting**: Prevent brute force attacks
5. **Multi-Factor**: Require MFA for sensitive accounts
6. **Logging**: Log all authentication events
7. **Monitoring**: Monitor for suspicious activity

## 🎓 Learning Resources

- OWASP Authentication: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
- Password Storage: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- Session Management: https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html

---

**Next**: Learn about [Password Security](./PASSWORD-SECURITY.md)

