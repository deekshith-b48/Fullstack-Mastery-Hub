# Data Protection Regulations

## 📚 Overview

Data protection regulations govern how organizations collect, store, process, and protect personal data. Compliance with these regulations is mandatory and requires implementing specific security and privacy measures.

## 🎯 Major Regulations

### 1. GDPR (General Data Protection Regulation)

EU regulation protecting personal data:
- **Scope**: EU residents' data
- **Key Requirements**: Consent, right to access, right to erasure
- **Penalties**: Up to 4% of global revenue

### 2. CCPA (California Consumer Privacy Act)

California state law:
- **Scope**: California residents' data
- **Key Requirements**: Disclosure, opt-out rights
- **Penalties**: $2,500-$7,500 per violation

### 3. HIPAA (Health Insurance Portability and Accountability Act)

US healthcare data protection:
- **Scope**: Protected Health Information (PHI)
- **Key Requirements**: Administrative, physical, technical safeguards
- **Penalties**: $100-$50,000 per violation

### 4. PCI-DSS (Payment Card Industry Data Security Standard)

Payment card data protection:
- **Scope**: Credit card data
- **Key Requirements**: Encryption, access controls, monitoring
- **Penalties**: Fines and loss of processing ability

## 🔍 GDPR Compliance

### Key GDPR Requirements

```javascript
// Right to access (Article 15)
app.get('/api/user/data', authenticate, async (req, res) => {
  const user = await User.findById(req.user.id);
  const exportData = {
    personalData: {
      email: user.email,
      name: user.name,
      createdAt: user.createdAt
    },
    purposes: await getDataPurposes(user.id),
    recipients: await getDataRecipients(user.id)
  };
  
  res.json(exportData);
});

// Right to erasure (Article 17)
app.delete('/api/user/data', authenticate, async (req, res) => {
  const userId = req.user.id;
  
  // Delete all user data
  await User.deleteOne({ id: userId });
  await Consent.deleteMany({ userId: userId });
  await ActivityLog.deleteMany({ userId: userId });
  
  res.json({ success: true });
});

// Data portability (Article 20)
app.get('/api/user/data-export', authenticate, async (req, res) => {
  const userData = await exportUserData(req.user.id);
  res.json(userData);
});
```

## 🔍 CCPA Compliance

### CCPA Requirements

```javascript
// Disclosure of data collection
app.get('/api/privacy/disclosure', (req, res) => {
  res.json({
    categoriesCollected: ['email', 'name', 'phone'],
    purposes: ['service delivery', 'marketing'],
    thirdParties: ['analytics', 'payment processors'],
    optOut: '/api/privacy/opt-out'
  });
});

// Opt-out mechanism
app.post('/api/privacy/opt-out', authenticate, async (req, res) => {
  await Consent.updateOne(
    { userId: req.user.id, purpose: 'marketing' },
    { granted: false }
  );
  
  res.json({ success: true });
});
```

## 🔍 HIPAA Compliance

### HIPAA Security Safeguards

```javascript
// Administrative safeguards
// - Security officer designation
// - Workforce training
// - Access management

// Physical safeguards
// - Facility access controls
// - Workstation security
// - Media controls

// Technical safeguards
function enforceHIPAACompliance(data) {
  // Encryption
  const encrypted = encryptPHI(data);
  
  // Access controls
  if (!hasPHIAccess(user)) {
    throw new Error('Unauthorized PHI access');
  }
  
  // Audit logging
  logPHIAccess(user, data, 'read');
  
  return encrypted;
}
```

## 🔍 PCI-DSS Compliance

### PCI-DSS Requirements

```javascript
// Never store full card numbers
async function processPayment(cardNumber) {
  // Tokenize immediately
  const token = await tokenizeCreditCard(cardNumber);
  
  // Store only token and last 4 digits
  await Payment.create({
    cardToken: token,
    last4: cardNumber.slice(-4)
    // Never store full card number
  });
  
  // Process payment
  await paymentGateway.charge(cardNumber);
}
```

## 🛡️ Compliance Best Practices

1. **Data Mapping**: Map all data collection
2. **Privacy Policies**: Clear privacy policies
3. **User Rights**: Implement user rights
4. **Consent Management**: Manage user consent
5. **Security Measures**: Implement required security
6. **Documentation**: Document compliance efforts
7. **Regular Audits**: Regular compliance audits

---

**Data Protection section complete!** Next: Network Security sections

