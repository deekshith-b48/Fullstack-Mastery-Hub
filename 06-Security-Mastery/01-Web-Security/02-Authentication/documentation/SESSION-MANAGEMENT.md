# Session Management

## 📚 Overview

Session management is critical for maintaining user authentication state securely. Proper session management prevents session hijacking, fixation attacks, and unauthorized access. This guide covers secure session implementation, common vulnerabilities, and best practices.

## 🎯 What is Session Management?

Session management involves creating, maintaining, and destroying user sessions securely. Sessions allow applications to maintain user state across multiple requests without requiring users to authenticate each time.

### Session Lifecycle

1. **Creation**: Session created after successful authentication
2. **Maintenance**: Session validated on each request
3. **Expiration**: Session expires after inactivity or timeout
4. **Destruction**: Session destroyed on logout or expiration

## 🔍 Session Creation

### Secure Session Creation

```javascript
// Secure session creation
const crypto = require('crypto');
const sessions = new Map();

function createSession(userId, ipAddress, userAgent) {
  // Generate cryptographically secure session ID
  const sessionId = crypto.randomBytes(32).toString('hex');
  
  // Create session object
  const session = {
    sessionId: sessionId,
    userId: userId,
    createdAt: Date.now(),
    lastActivity: Date.now(),
    ipAddress: ipAddress,
    userAgent: userAgent,
    expiresAt: Date.now() + (60 * 60 * 1000) // 1 hour
  };
  
  // Store session
  sessions.set(sessionId, session);
  
  // Set secure cookie
  res.cookie('sessionId', sessionId, {
    httpOnly: true, // Prevents JavaScript access
    secure: true, // HTTPS only
    sameSite: 'strict', // CSRF protection
    maxAge: 3600000, // 1 hour
    path: '/'
  });
  
  return sessionId;
}
```

### Session with Redis

```javascript
// Redis-based session storage
const redis = require('redis');
const client = redis.createClient();

async function createSession(userId, ipAddress, userAgent) {
  const sessionId = crypto.randomBytes(32).toString('hex');
  
  const session = {
    userId: userId,
    createdAt: Date.now(),
    lastActivity: Date.now(),
    ipAddress: ipAddress,
    userAgent: userAgent
  };
  
  // Store in Redis with expiration
  await client.setex(
    `session:${sessionId}`,
    3600, // 1 hour in seconds
    JSON.stringify(session)
  );
  
  return sessionId;
}

async function getSession(sessionId) {
  const sessionData = await client.get(`session:${sessionId}`);
  
  if (!sessionData) {
    return null;
  }
  
  const session = JSON.parse(sessionData);
  
  // Update last activity
  session.lastActivity = Date.now();
  await client.setex(
    `session:${sessionId}`,
    3600,
    JSON.stringify(session)
  );
  
  return session;
}
```

## 🔍 Session Validation

### Session Validation Middleware

```javascript
// Session validation middleware
async function validateSession(req, res, next) {
  const sessionId = req.cookies.sessionId;
  
  if (!sessionId) {
    return res.status(401).json({ error: 'No session' });
  }
  
  // Get session
  const session = await getSession(sessionId);
  
  if (!session) {
    return res.status(401).json({ error: 'Invalid session' });
  }
  
  // Check expiration
  if (Date.now() > session.expiresAt) {
    await destroySession(sessionId);
    return res.status(401).json({ error: 'Session expired' });
  }
  
  // Check inactivity timeout (15 minutes)
  const inactivityTimeout = 15 * 60 * 1000;
  if (Date.now() - session.lastActivity > inactivityTimeout) {
    await destroySession(sessionId);
    return res.status(401).json({ error: 'Session expired due to inactivity' });
  }
  
  // Security checks
  // Check IP address change
  if (session.ipAddress !== req.ip) {
    // Log suspicious activity
    await logSecurityEvent({
      type: 'session_ip_change',
      sessionId: sessionId,
      oldIP: session.ipAddress,
      newIP: req.ip,
      timestamp: Date.now()
    });
    
    // Optionally invalidate session
    // await destroySession(sessionId);
    // return res.status(401).json({ error: 'Session invalidated' });
  }
  
  // Check user agent change
  if (session.userAgent !== req.headers['user-agent']) {
    await logSecurityEvent({
      type: 'session_user_agent_change',
      sessionId: sessionId,
      timestamp: Date.now()
    });
  }
  
  // Update last activity
  session.lastActivity = Date.now();
  await updateSession(sessionId, session);
  
  // Attach session to request
  req.session = session;
  req.user = await User.findById(session.userId);
  
  next();
}
```

## 🔍 Session Fixation Prevention

### Session Regeneration

```javascript
// Regenerate session ID after login
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  
  // Authenticate user
  const user = await authenticateUser(username, password);
  
  // Regenerate session ID (prevent session fixation)
  if (req.session) {
    await destroySession(req.session.sessionId);
  }
  
  // Create new session
  const sessionId = await createSession(
    user.id,
    req.ip,
    req.headers['user-agent']
  );
  
  res.json({ success: true, sessionId });
});

// Regenerate session ID periodically
async function regenerateSession(oldSessionId) {
  const oldSession = await getSession(oldSessionId);
  
  if (!oldSession) {
    return null;
  }
  
  // Create new session
  const newSessionId = crypto.randomBytes(32).toString('hex');
  const newSession = {
    ...oldSession,
    sessionId: newSessionId,
    lastActivity: Date.now()
  };
  
  // Store new session
  await client.setex(
    `session:${newSessionId}`,
    3600,
    JSON.stringify(newSession)
  );
  
  // Destroy old session
  await destroySession(oldSessionId);
  
  return newSessionId;
}
```

## 🔍 Session Expiration

### Absolute Timeout

```javascript
// Absolute session timeout (1 hour)
async function checkSessionExpiration(sessionId) {
  const session = await getSession(sessionId);
  
  if (!session) {
    return false;
  }
  
  const maxAge = 60 * 60 * 1000; // 1 hour
  if (Date.now() - session.createdAt > maxAge) {
    await destroySession(sessionId);
    return false;
  }
  
  return true;
}
```

### Inactivity Timeout

```javascript
// Inactivity timeout (15 minutes)
async function checkInactivityTimeout(sessionId) {
  const session = await getSession(sessionId);
  
  if (!session) {
    return false;
  }
  
  const inactivityTimeout = 15 * 60 * 1000; // 15 minutes
  if (Date.now() - session.lastActivity > inactivityTimeout) {
    await destroySession(sessionId);
    return false;
  }
  
  return true;
}
```

## 🔍 Session Destruction

### Secure Logout

```javascript
// Secure logout
app.post('/api/logout', validateSession, async (req, res) => {
  const sessionId = req.cookies.sessionId;
  
  // Destroy session
  await destroySession(sessionId);
  
  // Clear cookie
  res.clearCookie('sessionId', {
    httpOnly: true,
    secure: true,
    sameSite: 'strict',
    path: '/'
  });
  
  // Log logout event
  await logSecurityEvent({
    type: 'logout',
    userId: req.user.id,
    sessionId: sessionId,
    timestamp: Date.now()
  });
  
  res.json({ success: true });
});

async function destroySession(sessionId) {
  // Delete from storage
  await client.del(`session:${sessionId}`);
  
  // Optionally: Invalidate all user sessions
  // await invalidateUserSessions(userId);
}
```

### Invalidate All Sessions

```javascript
// Invalidate all user sessions (e.g., after password change)
async function invalidateUserSessions(userId) {
  // Get all user sessions
  const keys = await client.keys(`session:*`);
  
  for (const key of keys) {
    const sessionData = await client.get(key);
    if (sessionData) {
      const session = JSON.parse(sessionData);
      if (session.userId === userId) {
        await client.del(key);
      }
    }
  }
  
  // Log event
  await logSecurityEvent({
    type: 'all_sessions_invalidated',
    userId: userId,
    timestamp: Date.now()
  });
}
```

## 🔍 Session Security

### Secure Cookie Configuration

```javascript
// Secure session cookie configuration
app.use(session({
  name: 'sessionId', // Don't use default 'connect.sid'
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true, // Prevents JavaScript access
    secure: process.env.NODE_ENV === 'production', // HTTPS only in production
    sameSite: 'strict', // CSRF protection
    maxAge: 3600000, // 1 hour
    path: '/',
    domain: process.env.COOKIE_DOMAIN // Specify domain
  },
  store: new RedisStore({
    client: redisClient,
    prefix: 'session:',
    ttl: 3600 // 1 hour
  })
}));
```

### Session Hijacking Prevention

```javascript
// Session hijacking prevention
function validateSessionSecurity(session, req) {
  const securityChecks = {
    ipAddressMatch: session.ipAddress === req.ip,
    userAgentMatch: session.userAgent === req.headers['user-agent'],
    notExpired: Date.now() < session.expiresAt,
    notInactive: Date.now() - session.lastActivity < (15 * 60 * 1000)
  };
  
  // If multiple checks fail, likely hijacking attempt
  const failedChecks = Object.values(securityChecks).filter(v => !v).length;
  
  if (failedChecks >= 2) {
    // Log suspicious activity
    logSecurityEvent({
      type: 'suspicious_session_activity',
      sessionId: session.sessionId,
      checks: securityChecks,
      timestamp: Date.now()
    });
    
    // Invalidate session
    destroySession(session.sessionId);
    return false;
  }
  
  return true;
}
```

## 🔍 Concurrent Sessions

### Limit Concurrent Sessions

```javascript
// Limit number of concurrent sessions per user
const MAX_CONCURRENT_SESSIONS = 5;

async function createSession(userId, ipAddress, userAgent) {
  // Get user's active sessions
  const activeSessions = await getUserActiveSessions(userId);
  
  // If at limit, remove oldest session
  if (activeSessions.length >= MAX_CONCURRENT_SESSIONS) {
    const oldestSession = activeSessions.sort((a, b) => 
      a.lastActivity - b.lastActivity
    )[0];
    await destroySession(oldestSession.sessionId);
  }
  
  // Create new session
  return await createSession(userId, ipAddress, userAgent);
}
```

## 🛡️ Session Management Best Practices

### 1. Session ID Generation

- Use cryptographically secure random generators
- Minimum 128 bits (32 hex characters)
- Never use predictable session IDs
- Regenerate after privilege changes

### 2. Session Storage

- Store sessions server-side
- Use secure storage (Redis, database)
- Encrypt sensitive session data
- Implement proper expiration

### 3. Session Security

- Use HTTP-only cookies
- Use secure flag (HTTPS)
- Use SameSite attribute
- Validate session on each request

### 4. Session Monitoring

- Log session creation
- Log session destruction
- Monitor for suspicious patterns
- Alert on session anomalies

## 🎯 Best Practices

1. **Secure Session IDs**: Use cryptographically secure IDs
2. **Session Regeneration**: Regenerate after login
3. **Proper Expiration**: Implement timeouts
4. **Secure Storage**: Store sessions server-side
5. **Security Validation**: Validate IP, user agent
6. **Monitoring**: Monitor session activity
7. **Secure Destruction**: Properly destroy sessions

## 🎓 Learning Resources

- Session Management: https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html
- OWASP Session Management: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/
- Session Fixation: https://owasp.org/www-community/attacks/Session_fixation

---

**Authentication section progressing well!** Next sections: Authorization, Data Protection, Network Security, Compliance, Security Testing, and Secure Development.

