# OAuth2 and OpenID Connect

## 📚 Overview

OAuth2 and OpenID Connect are industry-standard protocols for authentication and authorization. OAuth2 provides authorization for third-party access, while OpenID Connect extends OAuth2 to provide authentication. Understanding these protocols is essential for modern application security.

## 🎯 What is OAuth2?

OAuth2 is an authorization framework that allows third-party applications to obtain limited access to user resources. It enables users to grant access to their data without sharing credentials.

### OAuth2 Roles

1. **Resource Owner**: The user who owns the data
2. **Client**: Application requesting access
3. **Authorization Server**: Issues access tokens
4. **Resource Server**: Hosts protected resources

### OAuth2 Flows

- **Authorization Code**: Most secure, for web applications
- **Implicit**: Less secure, for single-page applications
- **Client Credentials**: For server-to-server communication
- **Resource Owner Password**: Not recommended, legacy use
- **Device Code**: For devices with limited input

## 🔍 Authorization Code Flow

### OAuth2 Server Implementation

```javascript
// OAuth2 Authorization Server
const express = require('express');
const crypto = require('crypto');

// Store authorization codes temporarily
const authorizationCodes = new Map();

// Client registration
const clients = {
  'client123': {
    clientId: 'client123',
    clientSecret: 'secret456',
    redirectUris: ['https://client.example.com/callback'],
    scopes: ['read', 'write']
  }
};

// Step 1: Authorization request
app.get('/oauth/authorize', authenticate, (req, res) => {
  const { client_id, redirect_uri, scope, state, response_type } = req.query;
  
  // Validate client
  const client = clients[client_id];
  if (!client) {
    return res.status(400).json({ error: 'invalid_client' });
  }
  
  // Validate redirect URI
  if (!client.redirectUris.includes(redirect_uri)) {
    return res.status(400).json({ error: 'invalid_redirect_uri' });
  }
  
  // Validate response type
  if (response_type !== 'code') {
    return res.status(400).json({ error: 'unsupported_response_type' });
  }
  
  // Store authorization request
  const authRequest = {
    clientId: client_id,
    redirectUri: redirect_uri,
    scope: scope,
    state: state,
    userId: req.user.id
  };
  
  // Show consent screen
  res.render('oauth-consent', {
    client: client,
    scopes: scope.split(' '),
    state: state
  });
});

// Step 2: User consent
app.post('/oauth/authorize', authenticate, (req, res) => {
  const { client_id, redirect_uri, scope, state, approved } = req.body;
  
  if (!approved) {
    return res.redirect(`${redirect_uri}?error=access_denied&state=${state}`);
  }
  
  // Generate authorization code
  const code = crypto.randomBytes(32).toString('hex');
  
  // Store authorization code (expires in 10 minutes)
  authorizationCodes.set(code, {
    clientId: client_id,
    redirectUri: redirect_uri,
    scope: scope,
    userId: req.user.id,
    expiresAt: Date.now() + 600000
  });
  
  // Redirect with authorization code
  res.redirect(`${redirect_uri}?code=${code}&state=${state}`);
});

// Step 3: Token exchange
app.post('/oauth/token', async (req, res) => {
  const { grant_type, code, redirect_uri, client_id, client_secret } = req.body;
  
  if (grant_type !== 'authorization_code') {
    return res.status(400).json({ error: 'unsupported_grant_type' });
  }
  
  // Validate client credentials
  const client = clients[client_id];
  if (!client || client.clientSecret !== client_secret) {
    return res.status(401).json({ error: 'invalid_client' });
  }
  
  // Validate authorization code
  const authCode = authorizationCodes.get(code);
  if (!authCode) {
    return res.status(400).json({ error: 'invalid_grant' });
  }
  
  // Check expiration
  if (Date.now() > authCode.expiresAt) {
    authorizationCodes.delete(code);
    return res.status(400).json({ error: 'invalid_grant' });
  }
  
  // Validate redirect URI
  if (redirect_uri !== authCode.redirectUri) {
    return res.status(400).json({ error: 'invalid_grant' });
  }
  
  // Delete authorization code (one-time use)
  authorizationCodes.delete(code);
  
  // Generate access token
  const accessToken = generateAccessToken({
    userId: authCode.userId,
    clientId: client_id,
    scope: authCode.scope
  });
  
  // Generate refresh token
  const refreshToken = generateRefreshToken({
    userId: authCode.userId,
    clientId: client_id
  });
  
  res.json({
    access_token: accessToken,
    token_type: 'Bearer',
    expires_in: 3600,
    refresh_token: refreshToken,
    scope: authCode.scope
  });
});
```

## 🔍 Client Implementation

```javascript
// OAuth2 Client Implementation
const express = require('express');
const axios = require('axios');

const CLIENT_ID = 'client123';
const CLIENT_SECRET = 'secret456';
const REDIRECT_URI = 'https://client.example.com/callback';
const AUTHORIZATION_SERVER = 'https://auth.example.com';

// Step 1: Redirect user to authorization server
app.get('/login', (req, res) => {
  const state = crypto.randomBytes(16).toString('hex');
  
  // Store state in session
  req.session.oauthState = state;
  
  const authUrl = new URL(`${AUTHORIZATION_SERVER}/oauth/authorize`);
  authUrl.searchParams.set('client_id', CLIENT_ID);
  authUrl.searchParams.set('redirect_uri', REDIRECT_URI);
  authUrl.searchParams.set('response_type', 'code');
  authUrl.searchParams.set('scope', 'read write');
  authUrl.searchParams.set('state', state);
  
  res.redirect(authUrl.toString());
});

// Step 2: Handle callback
app.get('/callback', async (req, res) => {
  const { code, state, error } = req.query;
  
  // Validate state
  if (state !== req.session.oauthState) {
    return res.status(400).json({ error: 'Invalid state' });
  }
  
  if (error) {
    return res.status(400).json({ error });
  }
  
  // Exchange code for token
  try {
    const response = await axios.post(`${AUTHORIZATION_SERVER}/oauth/token`, {
      grant_type: 'authorization_code',
      code: code,
      redirect_uri: REDIRECT_URI,
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET
    }, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    });
    
    const { access_token, refresh_token, expires_in } = response.data;
    
    // Store tokens securely
    req.session.accessToken = accessToken;
    req.session.refreshToken = refreshToken;
    req.session.tokenExpiry = Date.now() + (expires_in * 1000);
    
    res.redirect('/dashboard');
  } catch (error) {
    res.status(400).json({ error: 'Token exchange failed' });
  }
});

// Step 3: Use access token
app.get('/api/user', async (req, res) => {
  const accessToken = req.session.accessToken;
  
  if (!accessToken) {
    return res.status(401).json({ error: 'Not authenticated' });
  }
  
  // Check if token expired
  if (Date.now() > req.session.tokenExpiry) {
    // Refresh token
    const newToken = await refreshAccessToken(req.session.refreshToken);
    req.session.accessToken = newToken.access_token;
    req.session.tokenExpiry = Date.now() + (newToken.expires_in * 1000);
  }
  
  // Use token to access protected resource
  const response = await axios.get(`${RESOURCE_SERVER}/api/user`, {
    headers: {
      'Authorization': `Bearer ${req.session.accessToken}`
    }
  });
  
  res.json(response.data);
});
```

## 🔍 OpenID Connect

### OpenID Connect Implementation

```javascript
// OpenID Connect extends OAuth2 with authentication
// ID Token contains user identity information

// Generate ID Token
function generateIDToken(user, clientId, nonce) {
  const payload = {
    iss: 'https://auth.example.com', // Issuer
    sub: user.id, // Subject (user ID)
    aud: clientId, // Audience
    exp: Math.floor(Date.now() / 1000) + 3600, // Expiration
    iat: Math.floor(Date.now() / 1000), // Issued at
    nonce: nonce, // Nonce for replay protection
    email: user.email,
    email_verified: user.emailVerified,
    name: user.name
  };
  
  return jwt.sign(payload, process.env.ID_TOKEN_SECRET, {
    algorithm: 'RS256'
  });
}

// Token endpoint with ID Token
app.post('/oauth/token', async (req, res) => {
  // ... existing token exchange logic ...
  
  // Generate ID Token for OpenID Connect
  const idToken = generateIDToken(user, client_id, req.session.nonce);
  
  res.json({
    access_token: accessToken,
    token_type: 'Bearer',
    expires_in: 3600,
    refresh_token: refreshToken,
    id_token: idToken, // OpenID Connect addition
    scope: authCode.scope
  });
});

// UserInfo endpoint
app.get('/oauth/userinfo', authenticateToken, async (req, res) => {
  const user = await User.findById(req.token.userId);
  
  res.json({
    sub: user.id,
    email: user.email,
    email_verified: user.emailVerified,
    name: user.name,
    picture: user.picture
  });
});
```

## 🔍 Token Validation

```javascript
// Validate access token
function validateAccessToken(token) {
  try {
    const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    
    // Check expiration
    if (decoded.exp < Date.now() / 1000) {
      throw new Error('Token expired');
    }
    
    // Check issuer
    if (decoded.iss !== 'https://auth.example.com') {
      throw new Error('Invalid issuer');
    }
    
    return decoded;
  } catch (error) {
    throw new Error('Invalid token');
  }
}

// Resource server middleware
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = validateAccessToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(403).json({ error: 'Invalid token' });
  }
}
```

## 🔍 Refresh Token Flow

```javascript
// Refresh access token
app.post('/oauth/token', async (req, res) => {
  const { grant_type, refresh_token } = req.body;
  
  if (grant_type !== 'refresh_token') {
    return res.status(400).json({ error: 'unsupported_grant_type' });
  }
  
  // Validate refresh token
  const refreshTokenData = await RefreshToken.findOne({
    token: refreshToken,
    expiresAt: { $gt: Date.now() },
    revoked: false
  });
  
  if (!refreshTokenData) {
    return res.status(400).json({ error: 'invalid_grant' });
  }
  
  // Revoke old refresh token
  refreshTokenData.revoked = true;
  await refreshTokenData.save();
  
  // Generate new tokens
  const accessToken = generateAccessToken({
    userId: refreshTokenData.userId,
    clientId: refreshTokenData.clientId,
    scope: refreshTokenData.scope
  });
  
  const newRefreshToken = generateRefreshToken({
    userId: refreshTokenData.userId,
    clientId: refreshTokenData.clientId
  });
  
  res.json({
    access_token: accessToken,
    token_type: 'Bearer',
    expires_in: 3600,
    refresh_token: newRefreshToken
  });
});
```

## 🛡️ OAuth2 Security Best Practices

### 1. State Parameter

- Always use state parameter
- Validate state on callback
- Use cryptographically random state

### 2. PKCE (Proof Key for Code Exchange)

```javascript
// PKCE for public clients
const crypto = require('crypto');

function generateCodeVerifier() {
  return crypto.randomBytes(32).toString('base64url');
}

function generateCodeChallenge(verifier) {
  return crypto.createHash('sha256').update(verifier).digest('base64url');
}

// Include in authorization request
const codeVerifier = generateCodeVerifier();
const codeChallenge = generateCodeChallenge(codeVerifier);

authUrl.searchParams.set('code_challenge', codeChallenge);
authUrl.searchParams.set('code_challenge_method', 'S256');
```

### 3. Token Storage

- Store tokens securely
- Use HTTP-only cookies when possible
- Never expose tokens in URLs
- Implement token rotation

### 4. Scope Validation

- Request minimum necessary scopes
- Validate scopes on resource server
- Implement scope-based authorization

## 🎯 Best Practices

1. **Use Authorization Code Flow**: Most secure flow
2. **Implement PKCE**: For public clients
3. **Validate State**: Prevent CSRF attacks
4. **Secure Token Storage**: Store tokens securely
5. **Token Expiration**: Use short-lived access tokens
6. **Scope Limitation**: Request minimum scopes
7. **HTTPS Only**: Always use HTTPS

## 🎓 Learning Resources

- OAuth2: https://oauth.net/2/
- OpenID Connect: https://openid.net/connect/
- OAuth2 Security: https://tools.ietf.org/html/rfc6819
- PKCE: https://tools.ietf.org/html/rfc7636

---

**Next**: Learn about [JWT Tokens Security](./JWT-TOKENS-SECURITY.md)

