# Biometric Authentication

## 📚 Overview

Biometric authentication uses unique biological characteristics to verify user identity. This includes fingerprints, facial recognition, voice patterns, and other physiological or behavioral traits. While convenient, biometric authentication requires careful implementation to ensure security and privacy.

## 🎯 What is Biometric Authentication?

Biometric authentication identifies users based on their unique physical or behavioral characteristics. Unlike passwords, biometrics cannot be easily forgotten or lost, but they also cannot be changed if compromised.

### Biometric Types

1. **Fingerprint**: Most common, high accuracy
2. **Face Recognition**: Convenient, improving accuracy
3. **Voice Recognition**: Phone-based authentication
4. **Iris/Retina**: High accuracy, less common
5. **Behavioral**: Typing patterns, mouse movements

## 🔍 Biometric Implementation Considerations

### Security Principles

```javascript
// Biometric data should never be stored as raw data
// Store only biometric templates (hashed/encrypted representations)

// VULNERABLE CODE - Storing raw biometric data
function storeBiometric(userId, fingerprintData) {
  db.users.update({ id: userId }, { 
    fingerprint: fingerprintData // NEVER store raw biometrics!
  });
}

// SECURE CODE - Store only templates
const crypto = require('crypto');

function storeBiometricTemplate(userId, biometricData) {
  // Extract features and create template
  const template = extractBiometricFeatures(biometricData);
  
  // Encrypt template
  const encryptedTemplate = encryptTemplate(template);
  
  // Store encrypted template
  db.users.update({ id: userId }, { 
    biometricTemplate: encryptedTemplate,
    biometricType: 'fingerprint'
  });
}
```

### Template Matching

```javascript
// Biometric verification process
async function verifyBiometric(userId, biometricData) {
  // Get stored template
  const user = await User.findById(userId);
  const storedTemplate = decryptTemplate(user.biometricTemplate);
  
  // Extract features from new sample
  const sampleTemplate = extractBiometricFeatures(biometricData);
  
  // Compare templates (fuzzy matching with threshold)
  const similarity = compareTemplates(storedTemplate, sampleTemplate);
  const threshold = 0.85; // 85% similarity required
  
  if (similarity >= threshold) {
    // Log successful authentication
    await logSecurityEvent({
      type: 'biometric_auth_success',
      userId: userId,
      biometricType: user.biometricType,
      timestamp: Date.now()
    });
    
    return true;
  }
  
  // Log failed attempt
  await logSecurityEvent({
    type: 'biometric_auth_failure',
    userId: userId,
    timestamp: Date.now()
  });
  
  return false;
}
```

## 🔍 Multi-Factor with Biometrics

### Biometric + Password

```javascript
// Biometric as one factor in MFA
app.post('/api/login', async (req, res) => {
  const { username, password, biometricData } = req.body;
  
  // Step 1: Verify password
  const user = await User.findOne({ username });
  const passwordValid = await bcrypt.compare(password, user.password);
  
  if (!passwordValid) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Step 2: Verify biometric (if enabled)
  if (user.biometricEnabled) {
    const biometricValid = await verifyBiometric(user.id, biometricData);
    
    if (!biometricValid) {
      return res.status(401).json({ error: 'Biometric verification failed' });
    }
  }
  
  // Create session
  const session = await createSession(user.id);
  res.json({ success: true, sessionId: session.id });
});
```

## 🔍 Privacy and Compliance

### GDPR Considerations

```javascript
// Biometric data is sensitive personal data under GDPR
// Requires explicit consent and special protection

async function enrollBiometric(userId, biometricData, consent) {
  // Verify consent
  if (!consent || !consent.biometricData) {
    throw new Error('Biometric consent required');
  }
  
  // Store consent record
  await Consent.create({
    userId: userId,
    type: 'biometric_data',
    granted: true,
    timestamp: Date.now()
  });
  
  // Encrypt and store template
  await storeBiometricTemplate(userId, biometricData);
}

// Right to deletion (GDPR)
async function deleteBiometricData(userId) {
  await User.updateOne(
    { id: userId },
    { 
      biometricTemplate: null,
      biometricEnabled: false
    }
  );
  
  // Log deletion
  await logSecurityEvent({
    type: 'biometric_data_deleted',
    userId: userId,
    timestamp: Date.now()
  });
}
```

## 🛡️ Best Practices

1. **Never Store Raw Data**: Only store encrypted templates
2. **Use Thresholds**: Implement appropriate similarity thresholds
3. **Fallback Mechanisms**: Provide alternative authentication methods
4. **Privacy Compliance**: Ensure GDPR/privacy compliance
5. **Rate Limiting**: Limit biometric attempts
6. **Monitoring**: Log all biometric authentication events
7. **Multi-Factor**: Use biometrics as part of MFA

---

**Next**: Learn about [Passwordless Authentication](./PASSWORDLESS-AUTH.md)

