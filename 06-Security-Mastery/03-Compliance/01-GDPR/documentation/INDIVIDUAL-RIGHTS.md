# GDPR Individual Rights

## 📚 Overview

GDPR grants individuals several rights over their personal data. Organizations must implement mechanisms to support these rights.

## 🎯 Individual Rights

### 1. Right to Access (Article 15)

Individuals can request access to their data:
```javascript
app.get('/api/user/data-export', authenticate, async (req, res) => {
  const user = await User.findById(req.user.id);
  
  const exportData = {
    personalData: {
      email: user.email,
      name: user.name,
      phone: user.phone,
      address: user.address
    },
    processingPurposes: await getProcessingPurposes(user.id),
    dataCategories: await getDataCategories(user.id),
    recipients: await getDataRecipients(user.id),
    retentionPeriod: await getRetentionPeriod(user.id),
    rights: getAvailableRights()
  };
  
  res.json(exportData);
});
```

### 2. Right to Rectification (Article 16)

Individuals can correct inaccurate data:
```javascript
app.put('/api/user/data', authenticate, async (req, res) => {
  const userId = req.user.id;
  const updates = req.body;
  
  // Validate updates
  const validated = validateUserData(updates);
  
  // Update data
  await User.updateOne({ id: userId }, validated);
  
  // Log update
  await logDataUpdate(userId, validated);
  
  res.json({ success: true });
});
```

### 3. Right to Erasure (Article 17)

Individuals can request data deletion:
```javascript
app.delete('/api/user/data', authenticate, async (req, res) => {
  const userId = req.user.id;
  
  // Delete all user data
  await User.deleteOne({ id: userId });
  await Consent.deleteMany({ userId: userId });
  await ActivityLog.deleteMany({ userId: userId });
  
  // Log deletion
  await logSecurityEvent({
    type: 'gdpr_erasure',
    userId: userId,
    timestamp: Date.now()
  });
  
  res.json({ success: true });
});
```

### 4. Right to Restrict Processing (Article 18)

Individuals can limit data processing:
```javascript
app.post('/api/user/restrict-processing', authenticate, async (req, res) => {
  const userId = req.user.id;
  const restrictions = req.body.restrictions;
  
  await ProcessingRestriction.create({
    userId: userId,
    restrictions: restrictions,
    timestamp: Date.now()
  });
  
  res.json({ success: true });
});
```

### 5. Right to Data Portability (Article 20)

Individuals can receive data in portable format:
```javascript
app.get('/api/user/data-portable', authenticate, async (req, res) => {
  const userData = await exportUserData(req.user.id);
  
  // Return in machine-readable format (JSON)
  res.setHeader('Content-Type', 'application/json');
  res.json(userData);
});
```

### 6. Right to Object (Article 21)

Individuals can object to processing:
```javascript
app.post('/api/user/object-processing', authenticate, async (req, res) => {
  const userId = req.user.id;
  const purpose = req.body.purpose;
  
  await ProcessingObjection.create({
    userId: userId,
    purpose: purpose,
    timestamp: Date.now()
  });
  
  // Stop processing for this purpose
  await stopProcessing(userId, purpose);
  
  res.json({ success: true });
});
```

## 🔍 Rights Implementation

### Automated Rights Handling

```javascript
class GDPRRightsHandler {
  async handleRightRequest(userId, right, data) {
    switch (right) {
      case 'access':
        return await this.handleAccess(userId);
      case 'rectification':
        return await this.handleRectification(userId, data);
      case 'erasure':
        return await this.handleErasure(userId);
      case 'portability':
        return await this.handlePortability(userId);
      case 'object':
        return await this.handleObjection(userId, data);
      default:
        throw new Error('Unknown right');
    }
  }
}
```

## 🛡️ Best Practices

1. **Implement All Rights**: Support all GDPR rights
2. **Response Time**: Respond within 30 days
3. **Verification**: Verify identity before processing
4. **Documentation**: Document all requests
5. **Automation**: Automate where possible
6. **Communication**: Communicate clearly with users
7. **Testing**: Test rights implementation

---

**Next**: Learn about [Data Processing Requirements](./DATA-PROCESSING-REQUIREMENTS.md)

