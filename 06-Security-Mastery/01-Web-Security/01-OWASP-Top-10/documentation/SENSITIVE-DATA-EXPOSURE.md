# Sensitive Data Exposure

## 📚 Overview

Sensitive data exposure occurs when applications fail to adequately protect sensitive information such as credit card numbers, authentication credentials, personal information, and other confidential data. This vulnerability can lead to identity theft, financial fraud, and privacy violations.

## 🎯 What is Sensitive Data Exposure?

Sensitive data exposure happens when applications don't properly protect sensitive information from unauthorized access. This can occur through various vectors including insecure transmission, weak encryption, improper storage, or accidental disclosure.

### Types of Sensitive Data

1. **Personal Identifiable Information (PII)**: Names, addresses, SSNs
2. **Authentication Credentials**: Passwords, API keys, tokens
3. **Financial Information**: Credit cards, bank accounts
4. **Health Information**: Medical records, PHI
5. **Intellectual Property**: Trade secrets, proprietary data
6. **Business Data**: Customer lists, financial records

## 🔍 Insecure Transmission

### Vulnerable Transmission

```javascript
// VULNERABLE CODE - HTTP transmission
app.post('/api/users', (req, res) => {
  // Sending sensitive data over HTTP
  const userData = {
    email: req.body.email,
    password: req.body.password,
    creditCard: req.body.creditCard
  };
  // Data sent in plain text!
  res.json(userData);
});
```

### Secure Transmission

```javascript
// SECURE CODE - HTTPS only
const express = require('express');
const helmet = require('helmet');
const app = express();

// Force HTTPS
app.use(helmet({
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  forceHTTPS: true
}));

// Ensure all connections use HTTPS
app.use((req, res, next) => {
  if (req.header('x-forwarded-proto') !== 'https' && process.env.NODE_ENV === 'production') {
    res.redirect(`https://${req.header('host')}${req.url}`);
  } else {
    next();
  }
});
```

## 🔍 Weak Encryption

### Vulnerable Encryption

```javascript
// VULNERABLE CODE - Weak encryption (DES, RC4)
const crypto = require('crypto');
function encryptData(data) {
  const cipher = crypto.createCipher('des', 'weak-key'); // Weak!
  return cipher.update(data, 'utf8', 'hex') + cipher.final('hex');
}

// VULNERABLE CODE - No encryption
function storeCreditCard(cardNumber) {
  db.users.update({ id: userId }, { creditCard: cardNumber }); // Plain text!
}
```

### Secure Encryption

```javascript
// SECURE CODE - Strong encryption (AES-256-GCM)
const crypto = require('crypto');

function encryptSensitiveData(data, key) {
  const algorithm = 'aes-256-gcm';
  const iv = crypto.randomBytes(16);
  
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  
  let encrypted = cipher.update(data, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  
  const authTag = cipher.getAuthTag();
  
  return {
    encrypted: encrypted,
    iv: iv.toString('hex'),
    authTag: authTag.toString('hex')
  };
}

function decryptSensitiveData(encryptedData, key) {
  const algorithm = 'aes-256-gcm';
  
  const decipher = crypto.createDecipheriv(
    algorithm,
    key,
    Buffer.from(encryptedData.iv, 'hex')
  );
  
  decipher.setAuthTag(Buffer.from(encryptedData.authTag, 'hex'));
  
  let decrypted = decipher.update(encryptedData.encrypted, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  
  return decrypted;
}

// Key management
function getEncryptionKey() {
  // Use environment variable or key management service
  const key = process.env.ENCRYPTION_KEY;
  if (!key || key.length !== 64) {
    throw new Error('Invalid encryption key');
  }
  return Buffer.from(key, 'hex');
}
```

## 🔍 Insecure Storage

### Vulnerable Storage

```javascript
// VULNERABLE CODE - Plain text storage
function storeUserData(userData) {
  db.users.insert({
    email: userData.email,
    ssn: userData.ssn, // Plain text!
    creditCard: userData.creditCard, // Plain text!
    password: userData.password // Plain text!
  });
}

// VULNERABLE CODE - Base64 encoding (not encryption!)
function storeCreditCard(cardNumber) {
  const encoded = Buffer.from(cardNumber).toString('base64');
  db.users.update({ id: userId }, { creditCard: encoded }); // Not secure!
}
```

### Secure Storage

```javascript
// SECURE CODE - Encrypted storage
async function storeUserData(userData) {
  const encryptionKey = getEncryptionKey();
  
  // Encrypt sensitive fields
  const encryptedSSN = encryptSensitiveData(userData.ssn, encryptionKey);
  const encryptedCreditCard = encryptSensitiveData(userData.creditCard, encryptionKey);
  
  // Hash password (never encrypt passwords)
  const hashedPassword = await hashPassword(userData.password);
  
  db.users.insert({
    email: userData.email,
    ssn: encryptedSSN,
    creditCard: encryptedCreditCard,
    password: hashedPassword
  });
}

// SECURE CODE - Tokenization (better for credit cards)
async function storeCreditCard(cardNumber) {
  // Send to tokenization service
  const token = await tokenizationService.tokenize(cardNumber);
  
  // Store only token
  db.users.update({ id: userId }, { creditCardToken: token });
  
  // Original card number never stored
}
```

## 🔍 Data Masking

### Implement Data Masking

```javascript
// Mask sensitive data in responses
function maskSSN(ssn) {
  if (!ssn || ssn.length < 4) return '***-**-****';
  return `***-**-${ssn.slice(-4)}`;
}

function maskCreditCard(cardNumber) {
  if (!cardNumber || cardNumber.length < 4) return '****-****-****-****';
  return `****-****-****-${cardNumber.slice(-4)}`;
}

function maskEmail(email) {
  const [local, domain] = email.split('@');
  if (local.length <= 2) return `${local[0]}***@${domain}`;
  return `${local[0]}***${local.slice(-1)}@${domain}`;
}

// Apply masking in API responses
app.get('/api/user/profile', authenticate, (req, res) => {
  const user = getUserData(req.user.id);
  
  res.json({
    id: user.id,
    email: maskEmail(user.email),
    ssn: maskSSN(user.ssn),
    creditCard: maskCreditCard(user.creditCard)
  });
});
```

## 🔍 API Key and Token Exposure

### Vulnerable API Key Handling

```javascript
// VULNERABLE CODE - API key in code
const apiKey = 'sk_live_1234567890abcdef'; // Hardcoded!
fetch('https://api.example.com/data', {
  headers: { 'Authorization': `Bearer ${apiKey}` }
});

// VULNERABLE CODE - API key in client-side
// public/index.html
<script>
  const apiKey = 'sk_live_1234567890abcdef'; // Exposed in browser!
</script>
```

### Secure API Key Management

```javascript
// SECURE CODE - Environment variables
const apiKey = process.env.API_KEY;
if (!apiKey) {
  throw new Error('API_KEY environment variable not set');
}

// SECURE CODE - Key management service (AWS KMS, HashiCorp Vault)
const AWS = require('aws-sdk');
const kms = new AWS.KMS();

async function getApiKey() {
  const encryptedKey = process.env.ENCRYPTED_API_KEY;
  const result = await kms.decrypt({
    CiphertextBlob: Buffer.from(encryptedKey, 'base64')
  }).promise();
  
  return result.Plaintext.toString();
}

// SECURE CODE - Server-side proxy for client requests
app.post('/api/proxy', authenticate, async (req, res) => {
  const apiKey = await getApiKey();
  const response = await fetch(req.body.url, {
    headers: {
      'Authorization': `Bearer ${apiKey}`
    }
  });
  res.json(await response.json());
});
```

## 🔍 Logging Sensitive Data

### Vulnerable Logging

```javascript
// VULNERABLE CODE - Logging sensitive data
console.log('User login:', {
  username: req.body.username,
  password: req.body.password, // Never log passwords!
  creditCard: req.body.creditCard, // Never log credit cards!
  ssn: req.body.ssn // Never log SSNs!
});

// VULNERABLE CODE - Error messages expose data
try {
  processPayment(creditCard);
} catch (error) {
  console.error('Payment failed:', error.message); // May expose card details
  res.status(500).json({ error: error.message }); // Exposed to client!
}
```

### Secure Logging

```javascript
// SECURE CODE - Sanitize logs
function sanitizeForLogging(data) {
  const sensitiveFields = ['password', 'creditCard', 'ssn', 'apiKey', 'token'];
  const sanitized = { ...data };
  
  for (const field of sensitiveFields) {
    if (sanitized[field]) {
      sanitized[field] = '[REDACTED]';
    }
  }
  
  return sanitized;
}

// Log sanitized data
logger.info('User login attempt', sanitizeForLogging({
  username: req.body.username,
  password: req.body.password, // Will be redacted
  ipAddress: req.ip
}));

// SECURE CODE - Error handling without data exposure
try {
  processPayment(creditCard);
} catch (error) {
  // Log detailed error server-side
  logger.error('Payment processing failed', {
    error: error.message,
    stack: error.stack,
    userId: req.user.id,
    // Don't log credit card details
  });
  
  // Send generic error to client
  res.status(500).json({
    error: 'Payment processing failed. Please try again.'
  });
}
```

## 🔍 Data at Rest Protection

### Database Encryption

```javascript
// SECURE CODE - Database-level encryption
// PostgreSQL with encryption
const { Client } = require('pg');

const client = new Client({
  host: 'localhost',
  database: 'encrypted_db',
  ssl: {
    rejectUnauthorized: false,
    ca: fs.readFileSync('ca-certificate.crt')
  }
});

// Use encrypted columns
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  ssn BYTEA, -- Encrypted column
  credit_card BYTEA -- Encrypted column
);

// Application-level encryption before storage
async function storeEncryptedData(userId, data) {
  const key = await getEncryptionKey();
  const encrypted = encryptSensitiveData(data, key);
  
  await db.query(
    'INSERT INTO users (id, ssn, credit_card) VALUES ($1, $2, $3)',
    [userId, encrypted.ssn, encrypted.creditCard]
  );
}
```

## 🔍 Data in Transit Protection

### TLS Configuration

```javascript
// SECURE CODE - Strong TLS configuration
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('private-key.pem'),
  cert: fs.readFileSync('certificate.pem'),
  ciphers: [
    'ECDHE-RSA-AES128-GCM-SHA256',
    'ECDHE-RSA-AES256-GCM-SHA384',
    '!aNULL',
    '!eNULL',
    '!EXPORT',
    '!DES',
    '!RC4',
    '!MD5',
    '!PSK',
    '!SRP',
    '!CAMELLIA'
  ].join(':'),
  honorCipherOrder: true,
  minVersion: 'TLSv1.2'
};

const server = https.createServer(options, app);
```

## 🛡️ Data Protection Best Practices

### 1. Encryption

- Use strong encryption algorithms (AES-256)
- Use authenticated encryption (GCM mode)
- Implement proper key management
- Rotate encryption keys regularly

### 2. Data Minimization

```javascript
// Only collect necessary data
function collectUserData(formData) {
  return {
    email: formData.email, // Required
    name: formData.name, // Required
    // Don't collect SSN unless absolutely necessary
    // Don't collect credit card unless processing payment
  };
}
```

### 3. Access Control

```javascript
// Implement access control for sensitive data
function canAccessSSN(user, targetUserId) {
  // Only allow access to own data or admin
  return user.id === targetUserId || user.role === 'admin';
}

app.get('/api/user/:id/ssn', authenticate, (req, res) => {
  if (!canAccessSSN(req.user, req.params.id)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  const user = getUserData(req.params.id);
  res.json({ ssn: maskSSN(user.ssn) }); // Still mask even if authorized
});
```

### 4. Data Retention

```javascript
// Implement data retention policies
async function cleanupOldData() {
  const retentionPeriod = 90 * 24 * 60 * 60 * 1000; // 90 days
  const cutoffDate = Date.now() - retentionPeriod;
  
  await db.query(
    'DELETE FROM logs WHERE created_at < $1',
    [new Date(cutoffDate)]
  );
  
  // Archive instead of delete for compliance
  await archiveOldRecords(cutoffDate);
}
```

## 📊 Compliance Considerations

### GDPR Requirements

```javascript
// Right to data portability
app.get('/api/user/data-export', authenticate, async (req, res) => {
  const userData = await getUserAllData(req.user.id);
  res.json(userData);
});

// Right to erasure
app.delete('/api/user/data', authenticate, async (req, res) => {
  await deleteUserData(req.user.id);
  res.json({ success: true });
});
```

### PCI-DSS Requirements

```javascript
// Never store full credit card numbers
// Only store last 4 digits and token
function processPayment(cardNumber) {
  const last4 = cardNumber.slice(-4);
  const token = tokenizationService.tokenize(cardNumber);
  
  // Store only token and last 4
  db.payments.insert({
    token: token,
    last4: last4,
    // Never store full card number
  });
}
```

## 🎯 Best Practices

1. **Encrypt Sensitive Data**: Use strong encryption for data at rest
2. **Secure Transmission**: Always use HTTPS/TLS
3. **Data Masking**: Mask sensitive data in responses
4. **Access Control**: Restrict access to sensitive data
5. **Secure Logging**: Never log sensitive information
6. **Data Minimization**: Only collect necessary data
7. **Compliance**: Follow GDPR, PCI-DSS, HIPAA requirements

## 🎓 Learning Resources

- OWASP Data Protection: https://owasp.org/www-community/vulnerabilities/Insecure_Storage_of_Sensitive_Information
- Encryption Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html
- PCI-DSS: https://www.pcisecuritystandards.org/

---

**Next**: Learn about [XML External Entities](./XML-EXTERNAL-ENTITIES.md)

