# HTTPS Fundamentals

## 📚 Overview

HTTPS (Hypertext Transfer Protocol Secure) is the secure version of HTTP, encrypting data in transit between clients and servers. It uses SSL/TLS to provide confidentiality, integrity, and authentication.

## 🎯 What is HTTPS?

HTTPS encrypts HTTP traffic using SSL/TLS, preventing eavesdropping, tampering, and man-in-the-middle attacks. It's essential for protecting sensitive data like passwords, credit cards, and personal information.

## 🔍 HTTPS Benefits

### Security Benefits

1. **Encryption**: Data encrypted in transit
2. **Integrity**: Data cannot be tampered with
3. **Authentication**: Server identity verified
4. **Privacy**: Prevents traffic analysis

## 🔍 HTTPS Implementation

### Express.js HTTPS Setup

```javascript
const https = require('https');
const fs = require('fs');
const express = require('express');

const app = express();

const options = {
  key: fs.readFileSync('private-key.pem'),
  cert: fs.readFileSync('certificate.pem'),
  ca: fs.readFileSync('ca-certificate.pem') // If using CA-signed cert
};

const server = https.createServer(options, app);

server.listen(443, () => {
  console.log('HTTPS server running on port 443');
});
```

### Force HTTPS

```javascript
// Force HTTPS in production
app.use((req, res, next) => {
  if (process.env.NODE_ENV === 'production') {
    if (req.header('x-forwarded-proto') !== 'https') {
      return res.redirect(`https://${req.header('host')}${req.url}`);
    }
  }
  next();
});
```

## 🔍 SSL/TLS Configuration

### Secure TLS Configuration

```javascript
const tls = require('tls');

const secureOptions = {
  minVersion: 'TLSv1.2',
  maxVersion: 'TLSv1.3',
  ciphers: [
    'ECDHE-RSA-AES128-GCM-SHA256',
    'ECDHE-RSA-AES256-GCM-SHA384',
    '!aNULL',
    '!eNULL',
    '!EXPORT',
    '!DES',
    '!RC4',
    '!MD5',
    '!PSK'
  ].join(':'),
  honorCipherOrder: true
};
```

## 🔍 HSTS (HTTP Strict Transport Security)

### HSTS Implementation

```javascript
// HSTS header
app.use((req, res, next) => {
  if (req.secure || req.headers['x-forwarded-proto'] === 'https') {
    res.setHeader('Strict-Transport-Security', 
      'max-age=31536000; includeSubDomains; preload'
    );
  }
  next();
});
```

## 🛡️ Best Practices

1. **Always Use HTTPS**: Use HTTPS for all connections
2. **Strong Ciphers**: Use strong cipher suites
3. **Certificate Management**: Keep certificates updated
4. **HSTS**: Implement HSTS headers
5. **TLS 1.2+**: Use TLS 1.2 or higher
6. **Certificate Validation**: Validate certificates properly
7. **Monitoring**: Monitor certificate expiration

---

**Next**: Learn about [SSL/TLS Protocols](./SSL-TLS-PROTOCOLS.md)

