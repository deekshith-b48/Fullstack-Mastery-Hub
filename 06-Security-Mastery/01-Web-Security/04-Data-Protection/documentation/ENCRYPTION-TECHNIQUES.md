# Encryption Techniques

## 📚 Overview

Encryption is the process of converting plaintext data into ciphertext to protect it from unauthorized access. This guide covers various encryption techniques, algorithms, and best practices for securing data.

## 🎯 Encryption Types

### Symmetric Encryption

Same key for encryption and decryption:
```javascript
const crypto = require('crypto');

function encryptSymmetric(data, key) {
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
```

### Asymmetric Encryption

Public/private key pair:
```javascript
const { publicEncrypt, privateDecrypt } = require('crypto');

function encryptAsymmetric(data, publicKey) {
  return publicEncrypt(publicKey, Buffer.from(data)).toString('base64');
}

function decryptAsymmetric(encryptedData, privateKey) {
  return privateDecrypt(privateKey, Buffer.from(encryptedData, 'base64')).toString('utf8');
}
```

## 🔍 Encryption Algorithms

### AES (Advanced Encryption Standard)

```javascript
// AES-256-GCM (recommended)
function encryptAES(data, key) {
  const algorithm = 'aes-256-gcm';
  const iv = crypto.randomBytes(16);
  
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  let encrypted = cipher.update(data, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  const authTag = cipher.getAuthTag();
  
  return {
    encrypted,
    iv: iv.toString('hex'),
    authTag: authTag.toString('hex')
  };
}
```

### RSA Encryption

```javascript
// RSA for key exchange
const { generateKeyPairSync } = require('crypto');

function generateRSAKeyPair() {
  return generateKeyPairSync('rsa', {
    modulusLength: 2048,
    publicKeyEncoding: {
      type: 'spki',
      format: 'pem'
    },
    privateKeyEncoding: {
      type: 'pkcs8',
      format: 'pem'
    }
  });
}
```

## 🔍 Key Management

### Secure Key Generation

```javascript
// Generate secure encryption keys
function generateEncryptionKey() {
  return crypto.randomBytes(32); // 256 bits for AES-256
}

// Key derivation
const { pbkdf2Sync } = require('crypto');

function deriveKey(password, salt) {
  return pbkdf2Sync(password, salt, 100000, 32, 'sha256');
}
```

### Key Storage

```javascript
// Store keys securely (use key management service)
const AWS = require('aws-sdk');
const kms = new AWS.KMS();

async function encryptWithKMS(data) {
  const result = await kms.encrypt({
    KeyId: process.env.KMS_KEY_ID,
    Plaintext: data
  }).promise();
  
  return result.CiphertextBlob.toString('base64');
}
```

## 🔍 Encryption Best Practices

### 1. Use Strong Algorithms

- AES-256-GCM for symmetric encryption
- RSA-2048 or ECC for asymmetric encryption
- Avoid deprecated algorithms (DES, RC4)

### 2. Proper IV Management

```javascript
// Always use random IVs
function encryptWithIV(data, key) {
  const iv = crypto.randomBytes(16); // Never reuse IVs
  // ... encryption logic
}
```

### 3. Authenticated Encryption

```javascript
// Use GCM mode for authentication
// GCM provides both encryption and authentication
const algorithm = 'aes-256-gcm'; // Authenticated encryption
```

## 🛡️ Best Practices

1. **Strong Algorithms**: Use AES-256, RSA-2048+
2. **Random IVs**: Never reuse initialization vectors
3. **Key Management**: Use secure key storage
4. **Authenticated Encryption**: Use GCM or CCM modes
5. **Key Rotation**: Rotate keys periodically
6. **Secure Storage**: Protect encryption keys
7. **Performance**: Consider encryption overhead

---

**Next**: Learn about [Hashing Algorithms](./HASHING-ALGORITHMS.md)

