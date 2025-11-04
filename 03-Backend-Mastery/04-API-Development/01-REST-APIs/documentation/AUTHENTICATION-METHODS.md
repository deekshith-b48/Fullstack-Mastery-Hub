# API Authentication Methods

## 📚 Overview

Different methods for authenticating API requests.

## 🔐 API Keys

```javascript
// Header
Authorization: ApiKey your-api-key

// Query parameter
GET /api/users?api_key=your-api-key
```

## 🔑 Bearer Token (JWT)

```javascript
// Header
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## 🔒 Basic Authentication

```javascript
// Header
Authorization: Basic base64(username:password)
```

## 🎯 OAuth 2.0

```javascript
// Access token
Authorization: Bearer access_token

// Refresh token
POST /oauth/token
{
  "grant_type": "refresh_token",
  "refresh_token": "refresh_token_value"
}
```

---

**Next**: Learn about [Authorization Systems](./AUTHORIZATION-SYSTEMS.md)

