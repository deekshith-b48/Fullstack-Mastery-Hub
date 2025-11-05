# PCI-DSS Fundamentals

## 📚 Overview

Payment Card Industry Data Security Standard (PCI-DSS) protects cardholder data. Compliance is mandatory for organizations that process, store, or transmit cardholder data.

## 🎯 What is PCI-DSS?

PCI-DSS is a set of security standards designed to ensure that all companies that accept, process, store, or transmit credit card information maintain a secure environment.

## 🔍 PCI-DSS Requirements

### 12 Requirements

1. Install and maintain firewall
2. Don't use vendor defaults
3. Protect stored cardholder data
4. Encrypt transmission
5. Use and update antivirus
6. Develop secure systems
7. Restrict access by need
8. Assign unique IDs
9. Restrict physical access
10. Track and monitor access
11. Regularly test systems
12. Maintain security policy

## 🔍 Cardholder Data Environment (CDE)

### CDE Definition

CDE includes:
- Any system that processes cardholder data
- Any system that stores cardholder data
- Any system that transmits cardholder data
- Network components connected to above

## 🔍 Data Protection

### Protect Cardholder Data

```javascript
// Never store full card numbers
async function processPayment(cardNumber) {
  // Tokenize immediately
  const token = await tokenizeCard(cardNumber);
  
  // Store only token and last 4 digits
  await Payment.create({
    cardToken: token,
    last4: cardNumber.slice(-4)
    // Never store full PAN
  });
  
  // Process payment
  await paymentGateway.charge(cardNumber);
}
```

## 🔍 Encryption Requirements

### Encrypt Transmission

```javascript
// Use TLS 1.2+ for transmission
const httpsOptions = {
  minVersion: 'TLSv1.2',
  ciphers: [
    'ECDHE-RSA-AES256-GCM-SHA384',
    'ECDHE-RSA-AES128-GCM-SHA256'
  ].join(':')
};
```

## 🛡️ Best Practices

1. **Minimize Data**: Don't store card data
2. **Tokenization**: Use tokenization
3. **Encryption**: Encrypt all cardholder data
4. **Access Control**: Restrict access
5. **Monitoring**: Monitor access
6. **Testing**: Regular security testing
7. **Compliance**: Maintain compliance

---

**Next**: Learn about [PCI Requirements](./PCI-REQUIREMENTS.md)

