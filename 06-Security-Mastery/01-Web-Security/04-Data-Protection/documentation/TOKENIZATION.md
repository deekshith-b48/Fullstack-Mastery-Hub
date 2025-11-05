# Tokenization

## 📚 Overview

Tokenization replaces sensitive data with non-sensitive tokens that have no exploitable value. The original data is stored securely and can be retrieved using the token. This is commonly used for payment card data.

## 🎯 How Tokenization Works

### Tokenization Process

1. **Sensitive Data** → Tokenization Service
2. **Token Generated** → Returned to application
3. **Original Data** → Stored securely in vault
4. **Token Used** → For operations instead of real data

## 🔍 Tokenization Implementation

### Basic Tokenization

```javascript
const crypto = require('crypto');

class TokenizationService {
  constructor() {
    this.vault = new Map(); // Use secure database in production
    this.encryptionKey = process.env.TOKENIZATION_KEY;
  }
  
  tokenize(data) {
    // Generate unique token
    const token = crypto.randomBytes(16).toString('hex');
    
    // Encrypt and store original data
    const encrypted = this.encrypt(data);
    this.vault.set(token, encrypted);
    
    return token;
  }
  
  detokenize(token) {
    const encrypted = this.vault.get(token);
    if (!encrypted) {
      throw new Error('Invalid token');
    }
    
    return this.decrypt(encrypted);
  }
  
  encrypt(data) {
    const cipher = crypto.createCipheriv('aes-256-gcm', this.encryptionKey, this.generateIV());
    let encrypted = cipher.update(data, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return encrypted;
  }
  
  decrypt(encrypted) {
    // Decryption logic
    return decryptedData;
  }
  
  generateIV() {
    return crypto.randomBytes(16);
  }
}
```

## 🔍 Payment Card Tokenization

### PCI-DSS Compliant Tokenization

```javascript
// Tokenize credit card for storage
async function tokenizeCreditCard(cardNumber) {
  // Send to tokenization service
  const token = await tokenizationService.tokenize(cardNumber);
  
  // Store only token (not card number)
  await Payment.create({
    userId: userId,
    cardToken: token, // Only token stored
    last4: cardNumber.slice(-4) // Last 4 digits for display
  });
  
  return token;
}

// Detokenize when needed (e.g., for payment processing)
async function processPayment(token, amount) {
  const cardNumber = await tokenizationService.detokenize(token);
  
  // Process payment with card number
  const result = await paymentGateway.charge(cardNumber, amount);
  
  return result;
}
```

## 🔍 Format-Preserving Tokenization

### Preserve Data Format

```javascript
function tokenizeFormatPreserving(data, format) {
  const token = generateToken();
  
  // Format token to match original format
  if (format === 'credit-card') {
    // Format as XXXX-XXXX-XXXX-XXXX
    return formatAsCreditCard(token);
  }
  if (format === 'ssn') {
    // Format as XXX-XX-XXXX
    return formatAsSSN(token);
  }
  
  return token;
}
```

## 🛡️ Best Practices

1. **Secure Vault**: Store tokens in secure, encrypted vault
2. **No Exploitable Value**: Tokens should have no value if compromised
3. **Format Preservation**: Preserve format when needed
4. **Access Control**: Strict access to tokenization service
5. **Audit Logging**: Log all tokenization operations
6. **Compliance**: Follow PCI-DSS for payment data
7. **Key Management**: Secure encryption keys

---

**Next**: Learn about [Data Loss Prevention](./DATA-LOSS-PREVENTION.md)

