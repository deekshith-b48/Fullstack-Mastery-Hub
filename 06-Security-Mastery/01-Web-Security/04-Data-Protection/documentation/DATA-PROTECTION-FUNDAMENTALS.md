# Data Protection Fundamentals

## 📚 Overview

Data protection involves securing sensitive information from unauthorized access, modification, or disclosure. This includes encryption, access controls, data masking, and compliance with privacy regulations.

## 🎯 Data Protection Principles

### Core Principles

1. **Confidentiality**: Data accessible only to authorized users
2. **Integrity**: Data remains accurate and unmodified
3. **Availability**: Data accessible when needed
4. **Privacy**: Personal data handled according to regulations

## 🔍 Data Classification

### Classifying Data

```javascript
// Data classification levels
const dataClassification = {
  public: {
    level: 1,
    encryption: false,
    accessControl: 'minimal'
  },
  internal: {
    level: 2,
    encryption: 'at-rest',
    accessControl: 'role-based'
  },
  confidential: {
    level: 3,
    encryption: 'at-rest-and-in-transit',
    accessControl: 'strict'
  },
  restricted: {
    level: 4,
    encryption: 'strong',
    accessControl: 'very-strict'
  }
};

function classifyData(data) {
  if (data.includes('SSN') || data.includes('credit-card')) {
    return 'restricted';
  }
  if (data.includes('email') || data.includes('phone')) {
    return 'confidential';
  }
  return 'internal';
}
```

## 🔍 Data Encryption

### Encryption at Rest

```javascript
const crypto = require('crypto');

function encryptDataAtRest(data, key) {
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

function decryptDataAtRest(encryptedData, key) {
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
```

## 🔍 Access Controls

### Data Access Control

```javascript
// Control access to sensitive data
function canAccessData(user, data, classification) {
  const requiredLevel = dataClassification[classification].level;
  const userClearance = getUserClearance(user);
  
  if (userClearance < requiredLevel) {
    return false;
  }
  
  // Additional checks
  if (classification === 'restricted') {
    return user.role === 'admin' || isDataOwner(user, data);
  }
  
  return true;
}

// Usage
app.get('/api/data/:id', authenticate, async (req, res) => {
  const data = await Data.findById(req.params.id);
  const classification = classifyData(data);
  
  if (!canAccessData(req.user, data, classification)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  res.json(data);
});
```

## 🔍 Data Masking

### Masking Sensitive Data

```javascript
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

// Apply masking in responses
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

## 🔍 Data Retention

### Retention Policies

```javascript
// Implement data retention policies
async function enforceRetentionPolicy() {
  const retentionPeriods = {
    logs: 90 * 24 * 60 * 60 * 1000, // 90 days
    userData: 365 * 24 * 60 * 60 * 1000, // 1 year
    backups: 730 * 24 * 60 * 60 * 1000 // 2 years
  };
  
  for (const [type, period] of Object.entries(retentionPeriods)) {
    const cutoffDate = Date.now() - period;
    
    await Data.deleteMany({
      type: type,
      createdAt: { $lt: new Date(cutoffDate) }
    });
  }
}
```

## 🛡️ Best Practices

1. **Classify Data**: Categorize data by sensitivity
2. **Encrypt Sensitive Data**: Use strong encryption
3. **Access Controls**: Implement strict access controls
4. **Data Masking**: Mask data in responses
5. **Retention Policies**: Define and enforce retention
6. **Compliance**: Follow GDPR, HIPAA, PCI-DSS
7. **Monitoring**: Monitor data access

---

**Next**: Learn about [Encryption Techniques](./ENCRYPTION-TECHNIQUES.md)

