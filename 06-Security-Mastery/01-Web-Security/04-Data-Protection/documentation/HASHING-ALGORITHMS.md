# Hashing Algorithms

## 📚 Overview

Hashing algorithms convert data of arbitrary size into fixed-size hash values. They're used for password storage, data integrity verification, and digital signatures. This guide covers secure hashing practices.

## 🎯 Hashing vs Encryption

### Key Differences

- **Hashing**: One-way, deterministic, fixed output size
- **Encryption**: Reversible, requires key, variable output size

## 🔍 Password Hashing

### bcrypt (Recommended)

```javascript
const bcrypt = require('bcrypt');

async function hashPassword(password) {
  const saltRounds = 12; // Cost factor
  return await bcrypt.hash(password, saltRounds);
}

async function verifyPassword(password, hash) {
  return await bcrypt.compare(password, hash);
}
```

### Argon2 (Better)

```javascript
const argon2 = require('argon2');

async function hashPassword(password) {
  return await argon2.hash(password, {
    type: argon2.argon2id,
    memoryCost: 65536, // 64 MB
    timeCost: 3,
    parallelism: 4
  });
}

async function verifyPassword(hash, password) {
  return await argon2.verify(hash, password);
}
```

## 🔍 Data Integrity Hashing

### SHA-256 for Integrity

```javascript
const crypto = require('crypto');

function hashData(data) {
  return crypto.createHash('sha256').update(data).digest('hex');
}

function verifyDataIntegrity(data, expectedHash) {
  const hash = hashData(data);
  return crypto.timingSafeEqual(
    Buffer.from(hash, 'hex'),
    Buffer.from(expectedHash, 'hex')
  );
}
```

### HMAC for Authentication

```javascript
function createHMAC(data, secret) {
  return crypto.createHmac('sha256', secret)
    .update(data)
    .digest('hex');
}

function verifyHMAC(data, secret, expectedHMAC) {
  const hmac = createHMAC(data, secret);
  return crypto.timingSafeEqual(
    Buffer.from(hmac, 'hex'),
    Buffer.from(expectedHMAC, 'hex')
  );
}
```

## 🔍 Hash Algorithms Comparison

### Algorithm Selection

| Algorithm | Use Case | Security |
|-----------|----------|----------|
| bcrypt | Passwords | High |
| Argon2 | Passwords | Highest |
| SHA-256 | Data integrity | High |
| SHA-512 | Data integrity | Very High |
| MD5 | ❌ Deprecated | Weak |
| SHA1 | ❌ Deprecated | Weak |

## 🛡️ Best Practices

1. **Password Hashing**: Use bcrypt or Argon2
2. **Salt**: Always use random salts (bcrypt/Argon2 do this)
3. **Cost Factor**: Use appropriate cost factors (10-12)
4. **Timing-Safe Comparison**: Use timing-safe functions
5. **Avoid MD5/SHA1**: Never use for security
6. **HMAC**: Use for message authentication
7. **Regular Updates**: Keep libraries updated

---

**Next**: Learn about [Data Masking](./DATA-MASKING.md)

