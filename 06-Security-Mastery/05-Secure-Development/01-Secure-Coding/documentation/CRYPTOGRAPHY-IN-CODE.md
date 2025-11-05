# Cryptography in Code

## 📚 Overview

Proper cryptographic implementation is critical for security. Using strong algorithms and correct implementation prevents cryptographic vulnerabilities.

## 🎯 Cryptographic Principles

### Principles

1. **Strong Algorithms**: Use proven algorithms
2. **Key Management**: Secure key management
3. **Random Generation**: Use secure random
4. **No Custom Crypto**: Don't invent crypto

## 🔍 Secure Cryptography

### Implementation

```javascript
// Secure cryptographic operations
const crypto = require('crypto');

class SecureCrypto {
  // Hash passwords
  async hashPassword(password) {
    return await bcrypt.hash(password, 12);
  }
  
  // Encrypt data
  encryptData(data, key) {
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
  
  // Generate secure random
  generateSecureRandom(length) {
    return crypto.randomBytes(length);
  }
  
  // Generate secure token
  generateSecureToken() {
    return crypto.randomBytes(32).toString('hex');
  }
}
```

## 🔍 Key Management

### Secure Key Management

```javascript
// Secure key management
class KeyManager {
  constructor() {
    this.keys = new Map();
  }
  
  generateKey() {
    return crypto.randomBytes(32); // 256 bits
  }
  
  storeKey(keyId, key) {
    // Encrypt key before storage
    const encrypted = this.encryptKey(key);
    this.keys.set(keyId, encrypted);
  }
  
  retrieveKey(keyId) {
    const encrypted = this.keys.get(keyId);
    return this.decryptKey(encrypted);
  }
}
```

## 🛡️ Best Practices

1. **Strong Algorithms**: Use AES-256, SHA-256+
2. **No Weak Crypto**: Avoid MD5, SHA1, DES
3. **Key Management**: Secure key storage
4. **Random Generation**: Use crypto.randomBytes
5. **No Hardcoded Keys**: Never hardcode keys
6. **Library Use**: Use proven libraries
7. **Regular Updates**: Keep libraries updated

---

**Next**: Learn about [Secure Coding Best Practices](./SECURE-CODING-BEST-PRACTICES.md)

