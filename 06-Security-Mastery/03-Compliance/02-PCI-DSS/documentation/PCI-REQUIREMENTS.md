# PCI-DSS Requirements

## 📚 Overview

PCI-DSS has 12 requirements organized into 6 categories. Understanding these requirements is essential for PCI-DSS compliance.

## 🎯 The 12 Requirements

### Build and Maintain Secure Network

**Requirement 1**: Install and maintain firewall
- Network firewall configuration
- Router configuration
- Firewall rule documentation

**Requirement 2**: Don't use vendor defaults
- Change default passwords
- Remove unnecessary services
- Secure system configurations

### Protect Cardholder Data

**Requirement 3**: Protect stored cardholder data
- Don't store sensitive data
- Encrypt stored data
- Use strong cryptography

**Requirement 4**: Encrypt transmission
- Use strong encryption
- Never send unencrypted PAN
- Use TLS 1.2+

### Maintain Vulnerability Management

**Requirement 5**: Use and update antivirus
- Deploy antivirus software
- Keep definitions updated
- Scan regularly

**Requirement 6**: Develop secure systems
- Secure coding practices
- Patch management
- Change control

### Implement Strong Access Control

**Requirement 7**: Restrict access by need
- Role-based access control
- Least privilege
- Access reviews

**Requirement 8**: Assign unique IDs
- Unique user IDs
- Strong authentication
- Password policies

**Requirement 9**: Restrict physical access
- Physical access controls
- Media protection
- Device disposal

### Monitor and Test Networks

**Requirement 10**: Track and monitor access
- Audit logging
- Log review
- Time synchronization

**Requirement 11**: Regularly test systems
- Vulnerability scans
- Penetration testing
- Intrusion detection

### Maintain Security Policy

**Requirement 12**: Maintain security policy
- Security policy
- Incident response
- Employee training

## 🔍 Implementation Examples

### Requirement 3: Protect Stored Data

```javascript
// Never store full PAN
async function processPayment(cardNumber) {
  const token = await tokenizeCard(cardNumber);
  
  // Store only what's allowed
  await Payment.create({
    token: token,
    last4: cardNumber.slice(-4),
    // PAN, CVV, PIN never stored
  });
}
```

### Requirement 4: Encrypt Transmission

```javascript
// Use TLS 1.2+
const tlsOptions = {
  minVersion: 'TLSv1.2',
  ciphers: 'ECDHE-RSA-AES256-GCM-SHA384'
};
```

## 🛡️ Best Practices

1. **Understand Requirements**: Know all 12 requirements
2. **Implement All**: Implement all requirements
3. **Documentation**: Document compliance
4. **Testing**: Regular testing
5. **Monitoring**: Continuous monitoring
6. **Updates**: Keep systems updated
7. **Training**: Train staff

---

**Next**: Learn about [Cardholder Data Environment](./CARDHOLDER-DATA-ENVIRONMENT.md)

