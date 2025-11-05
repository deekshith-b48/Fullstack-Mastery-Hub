# SSL/TLS Configuration

## 📚 Overview

Proper SSL/TLS configuration is critical for secure communications. This includes selecting strong cipher suites, disabling weak protocols, and configuring certificates correctly.

## 🎯 TLS Configuration Principles

### Security Principles

1. **Use TLS 1.2+**: Disable older versions
2. **Strong Ciphers**: Use modern cipher suites
3. **Perfect Forward Secrecy**: Use ECDHE
4. **Certificate Validation**: Validate certificates
5. **Disable Weak**: Disable weak protocols/ciphers

## 🔍 Node.js TLS Configuration

### Secure TLS Setup

```javascript
const https = require('https');
const tls = require('tls');

const tlsOptions = {
  minVersion: 'TLSv1.2',
  maxVersion: 'TLSv1.3',
  ciphers: [
    'ECDHE-RSA-AES128-GCM-SHA256',
    'ECDHE-RSA-AES256-GCM-SHA384',
    'ECDHE-ECDSA-AES128-GCM-SHA256',
    'ECDHE-ECDSA-AES256-GCM-SHA384',
    '!aNULL',
    '!eNULL',
    '!EXPORT',
    '!DES',
    '!RC4',
    '!MD5',
    '!PSK'
  ].join(':'),
  honorCipherOrder: true,
  secureProtocol: 'TLSv1_2_method'
};

const server = https.createServer(tlsOptions, app);
```

## 🔍 Cipher Suite Selection

### Recommended Cipher Suites

```javascript
const recommendedCiphers = [
  // TLS 1.3 ciphers (automatic)
  // TLS 1.2 ciphers
  'ECDHE-ECDSA-AES128-GCM-SHA256',
  'ECDHE-RSA-AES128-GCM-SHA256',
  'ECDHE-ECDSA-AES256-GCM-SHA384',
  'ECDHE-RSA-AES256-GCM-SHA384',
  'ECDHE-ECDSA-CHACHA20-POLY1305',
  'ECDHE-RSA-CHACHA20-POLY1305'
].join(':');
```

### Disable Weak Ciphers

```javascript
const disabledCiphers = [
  '!aNULL',      // No anonymous authentication
  '!eNULL',      // No null encryption
  '!EXPORT',     // No export ciphers
  '!DES',        // No DES
  '!RC4',        // No RC4
  '!MD5',        // No MD5
  '!PSK',        // No pre-shared keys
  '!SRP',        // No SRP
  '!CAMELLIA'    // No Camellia (if not needed)
].join(':');
```

## 🔍 Protocol Version Control

### Disable Old Protocols

```javascript
const tlsOptions = {
  minVersion: 'TLSv1.2',  // Minimum TLS 1.2
  maxVersion: 'TLSv1.3',  // Maximum TLS 1.3
  secureProtocol: 'TLSv1_2_method'
};

// Explicitly disable SSL
const disabledProtocols = [
  'SSLv2',
  'SSLv3',
  'TLSv1',
  'TLSv1.1'
];
```

## 🔍 Certificate Validation

### Strict Certificate Validation

```javascript
const tls = require('tls');

function validateCertificate(cert) {
  // Check expiration
  const now = new Date();
  if (now < cert.validFrom || now > cert.validTo) {
    throw new Error('Certificate expired or not yet valid');
  }
  
  // Verify certificate chain
  // Check issuer
  // Verify signature
  // Check revocation
}

// TLS options with validation
const options = {
  rejectUnauthorized: true,  // Reject invalid certificates
  checkServerIdentity: (servername, cert) => {
    // Custom server identity check
    if (servername !== cert.subject.CN) {
      throw new Error('Certificate name mismatch');
    }
  }
};
```

## 🛡️ Best Practices

1. **TLS 1.2+**: Use TLS 1.2 or higher
2. **Strong Ciphers**: Use modern cipher suites
3. **PFS**: Enable Perfect Forward Secrecy
4. **Disable Weak**: Disable weak protocols/ciphers
5. **Certificate Validation**: Always validate certificates
6. **Regular Updates**: Keep TLS libraries updated
7. **Testing**: Test TLS configuration

---

**Next**: Learn about [Mixed Content Prevention](./MIXED-CONTENT-PREVENTION.md)

