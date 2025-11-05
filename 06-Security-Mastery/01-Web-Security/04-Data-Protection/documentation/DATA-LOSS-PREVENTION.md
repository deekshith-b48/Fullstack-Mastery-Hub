# Data Loss Prevention (DLP)

## 📚 Overview

Data Loss Prevention (DLP) is a strategy to prevent sensitive data from being accessed, used, or transmitted inappropriately. It involves monitoring, detecting, and blocking unauthorized data transfers.

## 🎯 DLP Strategies

### 1. Data Discovery

Identify sensitive data:
```javascript
function discoverSensitiveData(data) {
  const patterns = {
    ssn: /\b\d{3}-\d{2}-\d{4}\b/,
    creditCard: /\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b/,
    email: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/
  };
  
  const found = {};
  for (const [type, pattern] of Object.entries(patterns)) {
    if (pattern.test(data)) {
      found[type] = true;
    }
  }
  
  return found;
}
```

### 2. Data Classification

Classify data by sensitivity:
```javascript
function classifyData(data) {
  if (discoverSensitiveData(data).ssn || discoverSensitiveData(data).creditCard) {
    return 'restricted';
  }
  if (discoverSensitiveData(data).email) {
    return 'confidential';
  }
  return 'internal';
}
```

## 🔍 DLP Policies

### Policy Enforcement

```javascript
class DLPPolicy {
  constructor() {
    this.policies = [];
  }
  
  addPolicy(name, condition, action) {
    this.policies.push({ name, condition, action });
  }
  
  evaluate(data, context) {
    for (const policy of this.policies) {
      if (policy.condition(data, context)) {
        return policy.action;
      }
    }
    return 'allow';
  }
}

// Usage
const dlp = new DLPPolicy();

// Policy: Block credit card in email
dlp.addPolicy('no-credit-card-email',
  (data, context) => 
    context.channel === 'email' && 
    discoverSensitiveData(data).creditCard,
  'block'
);

// Policy: Warn on SSN in documents
dlp.addPolicy('warn-ssn',
  (data, context) => discoverSensitiveData(data).ssn,
  'warn'
);
```

## 🔍 DLP Monitoring

### Monitor Data Transfers

```javascript
// Monitor file uploads
app.post('/api/upload', authenticate, async (req, res) => {
  const fileContent = req.file.buffer.toString();
  
  // Check for sensitive data
  const sensitiveData = discoverSensitiveData(fileContent);
  
  if (Object.keys(sensitiveData).length > 0) {
    // Log DLP violation
    await logDLPViolation({
      userId: req.user.id,
      type: 'file_upload',
      sensitiveData: Object.keys(sensitiveData),
      timestamp: Date.now()
    });
    
    // Block upload if restricted
    if (classifyData(fileContent) === 'restricted') {
      return res.status(403).json({ 
        error: 'Upload blocked: Contains restricted data' 
      });
    }
  }
  
  // Allow upload
  res.json({ success: true });
});
```

## 🔍 Email DLP

### Email Content Scanning

```javascript
// Scan email before sending
async function scanEmail(content, attachments) {
  const violations = [];
  
  // Scan email body
  const bodySensitive = discoverSensitiveData(content);
  if (Object.keys(bodySensitive).length > 0) {
    violations.push({
      type: 'email_body',
      sensitiveData: bodySensitive
    });
  }
  
  // Scan attachments
  for (const attachment of attachments) {
    const attachmentSensitive = discoverSensitiveData(attachment.content);
    if (Object.keys(attachmentSensitive).length > 0) {
      violations.push({
        type: 'attachment',
        filename: attachment.name,
        sensitiveData: attachmentSensitive
      });
    }
  }
  
  return violations;
}
```

## 🛡️ Best Practices

1. **Data Discovery**: Identify sensitive data
2. **Policy Definition**: Define clear DLP policies
3. **Monitoring**: Monitor data transfers
4. **Blocking**: Block unauthorized transfers
5. **Logging**: Log all DLP violations
6. **User Education**: Train users on data handling
7. **Regular Audits**: Review DLP effectiveness

---

**Next**: Learn about [Privacy by Design](./PRIVACY-BY-DESIGN.md)

