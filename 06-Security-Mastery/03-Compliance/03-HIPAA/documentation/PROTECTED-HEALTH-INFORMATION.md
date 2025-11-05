# Protected Health Information (PHI)

## 📚 Overview

Protected Health Information (PHI) is individually identifiable health information. Protecting PHI is central to HIPAA compliance.

## 🎯 PHI Definition

### What is PHI?

PHI is health information that:
- Identifies an individual, OR
- Could be used to identify an individual

### PHI Identifiers

18 identifiers include:
- Names
- Dates (birth, admission, discharge)
- Phone numbers
- Addresses
- Social Security Numbers
- Medical record numbers
- Health plan numbers
- Account numbers
- License numbers
- Vehicle identifiers
- Device identifiers
- Web URLs
- IP addresses
- Biometric identifiers
- Full face photos
- Unique identifying numbers

## 🔍 PHI Protection

### Secure PHI Handling

```javascript
// Protect PHI throughout lifecycle
class PHIProtection {
  // Collection
  async collectPHI(patientData) {
    // Encrypt immediately
    const encrypted = this.encryptPHI(patientData);
    return encrypted;
  }
  
  // Storage
  async storePHI(encryptedPHI) {
    // Store encrypted
    // Access controls
    // Audit logging
    await PatientRecord.create({
      encryptedData: encryptedPHI,
      accessControls: this.getAccessControls(),
      auditLogging: true
    });
  }
  
  // Transmission
  async transmitPHI(patientId, recipient) {
    // Encrypt transmission
    // Use secure channel (TLS 1.2+)
    // Verify recipient
    const encrypted = await this.encryptForTransmission(patientId);
    await this.sendSecurely(recipient, encrypted);
  }
  
  // Disposal
  async disposePHI(patientId) {
    // Secure deletion
    // Verify deletion
    await this.secureDelete(patientId);
  }
}
```

## 🔍 PHI Access Control

### Access Management

```javascript
// Control PHI access
function canAccessPHI(user, patientId) {
  // Check user authentication
  if (!user.authenticated) {
    return false;
  }
  
  // Check user role
  if (!hasHealthcareRole(user)) {
    return false;
  }
  
  // Check need-to-know
  if (!needsAccessForTreatment(user, patientId)) {
    return false;
  }
  
  // Check patient consent (if required)
  if (requiresConsent(patientId) && !hasConsent(user, patientId)) {
    return false;
  }
  
  return true;
}
```

## 🔍 PHI Encryption

### Encryption Requirements

```javascript
// Encrypt PHI at rest
function encryptPHIAtRest(data) {
  return encrypt(data, {
    algorithm: 'AES-256-GCM',
    keyManagement: 'HSM',
    keyRotation: 'quarterly'
  });
}

// Encrypt PHI in transit
function encryptPHIInTransit(data) {
  return encrypt(data, {
    protocol: 'TLS 1.2+',
    cipher: 'AES-256-GCM',
    certificateValidation: true
  });
}
```

## 🛡️ Best Practices

1. **Identify PHI**: Identify all PHI
2. **Encrypt**: Encrypt all PHI
3. **Access Control**: Strict access controls
4. **Audit Logging**: Log all PHI access
5. **Training**: Train workforce
6. **Monitoring**: Monitor PHI access
7. **Incident Response**: Have breach response plan

---

**Next**: Learn about [HIPAA Compliance Checklist](./HIPAA-COMPLIANCE-CHECKLIST.md)

