# OAuth2 & OpenID Connect

## 📚 Overview

OAuth2 is an authorization framework, OpenID Connect adds authentication.

## 🔄 OAuth2 Flow

```
1. Client requests authorization
2. User authorizes
3. Client receives authorization code
4. Client exchanges code for access token
5. Client uses access token to access resources
```

## 🎯 Grant Types

### Authorization Code

```javascript
// Authorization URL
https://auth-server.com/authorize?
  response_type=code&
  client_id=CLIENT_ID&
  redirect_uri=CALLBACK_URL

// Exchange code for token
POST /oauth/token
{
  "grant_type": "authorization_code",
  "code": "authorization_code",
  "client_id": "CLIENT_ID",
  "client_secret": "CLIENT_SECRET"
}
```

### Client Credentials

```javascript
POST /oauth/token
{
  "grant_type": "client_credentials",
  "client_id": "CLIENT_ID",
  "client_secret": "CLIENT_SECRET"
}
```

---

**Next**: Learn about [API Security Best Practices](./API-SECURITY-BEST-PRACTICES.md)

