# Data Masking

## 📚 Overview

Data masking obscures sensitive information while preserving data format and usability. It's used to protect data in non-production environments, logs, and API responses.

## 🎯 Data Masking Techniques

### 1. Character Masking

Replace characters with masks:
```javascript
function maskCharacters(data, visibleChars = 4) {
  if (!data || data.length <= visibleChars) return '****';
  return '*'.repeat(data.length - visibleChars) + data.slice(-visibleChars);
}
```

### 2. Partial Masking

Show only parts of data:
```javascript
function maskSSN(ssn) {
  if (!ssn) return '***-**-****';
  return `***-**-${ssn.slice(-4)}`;
}

function maskEmail(email) {
  const [local, domain] = email.split('@');
  if (local.length <= 2) return `${local[0]}***@${domain}`;
  return `${local[0]}***${local.slice(-1)}@${domain}`;
}

function maskCreditCard(cardNumber) {
  if (!cardNumber || cardNumber.length < 4) return '****-****-****-****';
  return `****-****-****-${cardNumber.slice(-4)}`;
}
```

## 🔍 Context-Aware Masking

### Conditional Masking

```javascript
function maskData(data, user, context) {
  // Admin can see full data
  if (user.role === 'admin') {
    return data;
  }
  
  // Owner can see their own data
  if (data.userId === user.id) {
    return data;
  }
  
  // Apply masking based on data type
  if (data.ssn) {
    data.ssn = maskSSN(data.ssn);
  }
  if (data.email) {
    data.email = maskEmail(data.email);
  }
  if (data.creditCard) {
    data.creditCard = maskCreditCard(data.creditCard);
  }
  
  return data;
}
```

## 🔍 Log Masking

### Mask Sensitive Data in Logs

```javascript
function sanitizeLogData(data) {
  const sensitiveFields = ['password', 'ssn', 'creditCard', 'apiKey'];
  const sanitized = { ...data };
  
  for (const field of sensitiveFields) {
    if (sanitized[field]) {
      sanitized[field] = '[REDACTED]';
    }
  }
  
  return sanitized;
}

// Usage in logging
logger.info('User login', sanitizeLogData({
  username: 'user',
  password: 'secret123', // Will be redacted
  ipAddress: '192.168.1.1'
}));
```

## 🛡️ Best Practices

1. **Consistent Masking**: Use consistent patterns
2. **Preserve Format**: Maintain data format
3. **Context-Aware**: Mask based on user permissions
4. **Log Masking**: Always mask in logs
5. **API Responses**: Mask in API responses
6. **Testing**: Test masking thoroughly
7. **Documentation**: Document masking rules

---

**Next**: Learn about [Tokenization](./TOKENIZATION.md)

