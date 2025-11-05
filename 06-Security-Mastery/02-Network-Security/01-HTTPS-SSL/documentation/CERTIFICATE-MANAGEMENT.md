# Certificate Management

## 📚 Overview

Certificate management involves obtaining, configuring, renewing, and monitoring SSL/TLS certificates. Proper certificate management ensures continuous secure connections and prevents service disruptions.

## 🎯 Certificate Lifecycle

### Certificate Lifecycle Stages

1. **Generation**: Create certificate signing request (CSR)
2. **Validation**: CA validates domain ownership
3. **Issuance**: CA issues certificate
4. **Installation**: Install certificate on server
5. **Renewal**: Renew before expiration
6. **Revocation**: Revoke if compromised

## 🔍 Certificate Generation

### Generate CSR

```javascript
const { generateKeyPairSync } = require('crypto');
const fs = require('fs');

function generateCSR(domain) {
  const { privateKey, publicKey } = generateKeyPairSync('rsa', {
    modulusLength: 2048,
    publicKeyEncoding: {
      type: 'spki',
      format: 'pem'
    },
    privateKeyEncoding: {
      type: 'pkcs8',
      format: 'pem'
    }
  });
  
  // Save private key securely
  fs.writeFileSync('private-key.pem', privateKey, { mode: 0o600 });
  
  // Generate CSR (requires openssl or similar)
  // openssl req -new -key private-key.pem -out csr.pem
  
  return { privateKey, publicKey };
}
```

## 🔍 Certificate Installation

### Install Certificate

```javascript
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('private-key.pem'),
  cert: fs.readFileSync('certificate.pem'),
  ca: fs.readFileSync('ca-bundle.crt') // Certificate chain
};

const server = https.createServer(options, app);
server.listen(443);
```

## 🔍 Certificate Renewal

### Automated Renewal

```javascript
const cron = require('node-cron');

// Check certificate expiration daily
cron.schedule('0 0 * * *', async () => {
  const cert = fs.readFileSync('certificate.pem');
  const x509 = new X509Certificate(cert);
  const expirationDate = new Date(x509.validTo);
  const daysUntilExpiry = (expirationDate - Date.now()) / (1000 * 60 * 60 * 24);
  
  // Renew if expires within 30 days
  if (daysUntilExpiry < 30) {
    await renewCertificate();
  }
});

async function renewCertificate() {
  // Use ACME client to renew
  const acme = require('acme-client');
  // ... renewal logic ...
}
```

## 🔍 Certificate Monitoring

### Monitor Expiration

```javascript
function checkCertificateExpiration(certPath) {
  const cert = fs.readFileSync(certPath);
  const x509 = new X509Certificate(cert);
  
  const expirationDate = new Date(x509.validTo);
  const now = new Date();
  const daysUntilExpiry = (expirationDate - now) / (1000 * 60 * 60 * 24);
  
  if (daysUntilExpiry < 0) {
    throw new Error('Certificate expired');
  }
  
  if (daysUntilExpiry < 30) {
    console.warn(`Certificate expires in ${daysUntilExpiry} days`);
    // Trigger renewal
  }
  
  return {
    valid: expirationDate > now,
    expiresAt: expirationDate,
    daysUntilExpiry: Math.floor(daysUntilExpiry)
  };
}
```

## 🛡️ Best Practices

1. **Automate Renewal**: Use automated certificate renewal
2. **Monitor Expiration**: Check expiration regularly
3. **Secure Storage**: Protect private keys
4. **Backup Certificates**: Backup certificates securely
5. **Revocation Plan**: Have revocation procedures
6. **Documentation**: Document certificate locations
7. **Testing**: Test renewal process

---

**Next**: Learn about [HSTS Implementation](./HSTS-IMPLEMENTATION.md)

