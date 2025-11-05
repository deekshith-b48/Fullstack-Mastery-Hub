# Authorization Servers

## 📚 Overview

Authorization servers are specialized systems that handle authentication and authorization for applications. They centralize access control logic, token issuance, and user management, following OAuth2 and OpenID Connect standards.

## 🎯 Authorization Server Components

### Core Components

1. **Authentication Endpoint**: User login
2. **Authorization Endpoint**: OAuth2 authorization
3. **Token Endpoint**: Token issuance
4. **UserInfo Endpoint**: User information
5. **Token Introspection**: Token validation
6. **Revocation Endpoint**: Token revocation

## 🔍 Authorization Server Implementation

### Basic Server Structure

```javascript
const express = require('express');
const app = express();

// Authorization endpoint
app.get('/oauth/authorize', authenticate, (req, res) => {
  const { client_id, redirect_uri, scope, state, response_type } = req.query;
  
  // Validate client
  const client = validateClient(client_id, redirect_uri);
  
  // Show consent screen
  res.render('consent', {
    client: client,
    scopes: scope.split(' '),
    state: state
  });
});

// Token endpoint
app.post('/oauth/token', async (req, res) => {
  const { grant_type, code, client_id, client_secret } = req.body;
  
  // Validate client credentials
  const client = await validateClientCredentials(client_id, client_secret);
  
  // Handle different grant types
  switch (grant_type) {
    case 'authorization_code':
      return handleAuthorizationCode(req, res);
    case 'refresh_token':
      return handleRefreshToken(req, res);
    case 'client_credentials':
      return handleClientCredentials(req, res);
    default:
      return res.status(400).json({ error: 'unsupported_grant_type' });
  }
});
```

## 🔍 Token Management

### Token Storage and Validation

```javascript
// Token storage
const tokens = new Map();

async function issueToken(user, client, scopes) {
  const accessToken = generateAccessToken({
    userId: user.id,
    clientId: client.id,
    scopes: scopes
  });
  
  const refreshToken = generateRefreshToken({
    userId: user.id,
    clientId: client.id
  });
  
  // Store tokens
  await Token.create({
    accessToken: accessToken,
    refreshToken: refreshToken,
    userId: user.id,
    clientId: client.id,
    scopes: scopes,
    expiresAt: Date.now() + 3600000
  });
  
  return { accessToken, refreshToken };
}

// Token introspection
app.post('/oauth/introspect', async (req, res) => {
  const { token } = req.body;
  
  const tokenRecord = await Token.findOne({ accessToken: token });
  
  if (!tokenRecord || tokenRecord.expiresAt < Date.now()) {
    return res.json({ active: false });
  }
  
  res.json({
    active: true,
    client_id: tokenRecord.clientId,
    user_id: tokenRecord.userId,
    scope: tokenRecord.scopes.join(' '),
    exp: Math.floor(tokenRecord.expiresAt / 1000)
  });
}
```

## 🔍 Client Management

### Client Registration

```javascript
// Register OAuth2 client
async function registerClient(clientData) {
  const clientId = generateClientId();
  const clientSecret = generateClientSecret();
  
  const client = await Client.create({
    clientId: clientId,
    clientSecret: await bcrypt.hash(clientSecret, 10),
    name: clientData.name,
    redirectUris: clientData.redirectUris,
    allowedScopes: clientData.scopes,
    type: clientData.type // 'public' or 'confidential'
  });
  
  return {
    client_id: clientId,
    client_secret: clientSecret // Only shown once
  };
}
```

## 🔍 User Management Integration

### User Authentication

```javascript
// Authenticate user for authorization server
app.post('/oauth/login', async (req, res) => {
  const { username, password } = req.body;
  
  const user = await User.findOne({ username });
  const isValid = user && await bcrypt.compare(password, user.password);
  
  if (!isValid) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Create session
  req.session.userId = user.id;
  
  res.json({ success: true });
});
```

## 🛡️ Security Best Practices

1. **Secure Storage**: Encrypt tokens and secrets
2. **Token Expiration**: Use short-lived tokens
3. **HTTPS Only**: Always use HTTPS
4. **Rate Limiting**: Limit token requests
5. **Audit Logging**: Log all operations
6. **Monitoring**: Monitor for anomalies

---

**Next**: Learn about [Authorization Best Practices](./AUTHORIZATION-BEST-PRACTICES.md)

