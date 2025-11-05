# GDPR Data Processing Requirements

## 📚 Overview

GDPR requires organizations to meet specific requirements when processing personal data. This includes lawful basis, documentation, security measures, and privacy impact assessments.

## 🎯 Legal Basis for Processing

### Lawful Bases

1. **Consent**: Individual has given consent
2. **Contract**: Necessary for contract performance
3. **Legal Obligation**: Required by law
4. **Vital Interests**: Protect vital interests
5. **Public Task**: Public authority task
6. **Legitimate Interests**: Legitimate business interests

## 🔍 Consent Requirements

### Valid Consent

```javascript
// GDPR-compliant consent
async function obtainConsent(userId, purpose) {
  const consent = {
    userId: userId,
    purpose: purpose,
    granted: true,
    explicit: true, // Must be explicit
    informed: true, // Must be informed
    freelyGiven: true, // Must be freely given
    specific: true, // Must be specific
    unambiguous: true, // Must be unambiguous
    timestamp: Date.now(),
    ipAddress: req.ip,
    userAgent: req.headers['user-agent'],
    canWithdraw: true // Can be withdrawn
  };
  
  await Consent.create(consent);
  return consent;
}
```

## 🔍 Processing Records

### Record Keeping

```javascript
// Maintain processing records
async function recordProcessing(processing) {
  await ProcessingRecord.create({
    controller: processing.controller,
    processor: processing.processor,
    purpose: processing.purpose,
    dataCategories: processing.dataCategories,
    dataSubjects: processing.dataSubjects,
    recipients: processing.recipients,
    transfers: processing.transfers,
    retentionPeriod: processing.retentionPeriod,
    securityMeasures: processing.securityMeasures
  });
}
```

## 🔍 Privacy Impact Assessment (PIA)

### Conduct PIA

```javascript
// Privacy Impact Assessment
async function conductPIA(processing) {
  const pia = {
    description: processing.description,
    necessity: assessNecessity(processing),
    proportionality: assessProportionality(processing),
    risks: identifyRisks(processing),
    measures: identifyMeasures(processing),
    conclusion: assessConclusion(processing)
  };
  
  await PIA.create(pia);
  return pia;
}
```

## 🔍 Data Protection Officer (DPO)

### DPO Requirements

Organizations need DPO if:
- Public authority
- Large-scale processing
- Special categories of data
- Systematic monitoring

## 🛡️ Best Practices

1. **Legal Basis**: Establish legal basis for processing
2. **Consent**: Obtain valid consent when needed
3. **Records**: Maintain processing records
4. **PIA**: Conduct privacy impact assessments
5. **Security**: Implement security measures
6. **Documentation**: Document compliance efforts
7. **Regular Review**: Review processing regularly

---

**Next**: Learn about [GDPR Compliance Checklist](./GDPR-COMPLIANCE-CHECKLIST.md)

