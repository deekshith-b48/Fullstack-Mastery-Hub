# HIPAA Privacy Rule

## 📚 Overview

HIPAA Privacy Rule establishes national standards for protecting individuals' medical records and other PHI. It gives patients rights over their health information.

## 🎯 Privacy Rule Requirements

### Patient Rights

1. **Right to Access**: Access their PHI
2. **Right to Amend**: Request amendments
3. **Right to Accounting**: Request disclosure accounting
4. **Right to Restrict**: Request restrictions
5. **Right to Confidential Communication**

## 🔍 Permitted Uses and Disclosures

### Permitted Without Authorization

- Treatment
- Payment
- Healthcare operations
- Required by law
- Public health activities

### Requires Authorization

- Marketing
- Research (with conditions)
- Sale of PHI
- Psychotherapy notes

## 🔍 Minimum Necessary

### Minimum Necessary Rule

```javascript
// Access only minimum necessary PHI
function accessPHI(user, purpose, patientId) {
  const userRole = getUserRole(user);
  
  // Determine minimum necessary based on role
  const allowedData = {
    physician: ['full_record'],
    nurse: ['current_treatment', 'medications'],
    billing: ['billing_info', 'insurance'],
    receptionist: ['name', 'appointment_info']
  };
  
  const allowed = allowedData[userRole] || [];
  
  return getPHI(patientId, allowed);
}
```

## 🔍 Business Associate Agreements

### BAA Requirements

```javascript
// Business Associate Agreement
const baaRequirements = {
  permittedUses: 'specified',
  safeguards: 'required',
  reporting: 'breach_reporting',
  compliance: 'hipaa_compliance',
  termination: 'data_return'
};
```

## 🛡️ Best Practices

1. **Patient Rights**: Support all patient rights
2. **Minimum Necessary**: Access only necessary PHI
3. **Authorization**: Obtain when required
4. **BAAs**: Have BAAs with business associates
5. **Training**: Train workforce
6. **Documentation**: Document compliance
7. **Monitoring**: Monitor compliance

---

**Next**: Learn about [HIPAA Security Rule](./HIPAA-SECURITY-RULE.md)

