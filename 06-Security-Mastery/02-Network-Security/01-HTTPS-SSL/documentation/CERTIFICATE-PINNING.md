# Certificate Pinning

## 📚 Overview

Certificate pinning binds a host to expected certificate or public key. This prevents man-in-the-middle attacks even if a trusted CA is compromised.

## 🎯 What is Certificate Pinning?

Certificate pinning ensures that only specific certificates or public keys are accepted for a domain, even if other valid certificates exist.

## 🔍 Certificate Pinning Types

### Public Key Pinning

Pin the public key (more flexible):
```javascript
const https = require('https');
const tls = require('tls');

const pinnedPublicKeys = [
  'sha256//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
  'sha256//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB='
];

function verifyPinnedPublicKey(cert) {
  const publicKey = cert.publicKey;
  const fingerprint = crypto.createHash('sha256')
    .update(publicKey.export({ type: 'spki', format: 'der' }))
    .digest('base64');
  
  return pinnedPublicKeys.includes(`sha256//${fingerprint}`);
}
```

### Certificate Pinning

Pin the entire certificate (less flexible):
```javascript
const pinnedCertificates = [
  'sha256//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='
];

function verifyPinnedCertificate(cert) {
  const fingerprint = crypto.createHash('sha256')
    .update(cert.raw)
    .digest('base64');
  
  return pinnedCertificates.includes(`sha256//${fingerprint}`);
}
```

## 🔍 HTTP Public Key Pinning (HPKP)

### HPKP Header (Deprecated but informative)

```javascript
// Note: HPKP is deprecated, but concept is important
app.use((req, res, next) => {
  // Don't use HPKP in production (deprecated)
  // Use certificate pinning in application instead
  res.setHeader('Public-Key-Pins', 
    'pin-sha256="base64=="; ' +
    'pin-sha256="backup=="; ' +
    'max-age=31536000; ' +
    'includeSubDomains'
  );
  next();
});
```

## 🔍 Application-Level Pinning

### Node.js Certificate Pinning

```javascript
const https = require('https');
const tls = require('tls');

const pinnedKeys = [
  'sha256//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='
];

function createPinnedAgent() {
  return new https.Agent({
    checkServerIdentity: (servername, cert) => {
      const publicKey = cert.publicKey;
      const fingerprint = crypto.createHash('sha256')
        .update(publicKey.export({ type: 'spki', format: 'der' }))
        .digest('base64');
      
      const keyPin = `sha256//${fingerprint}`;
      
      if (!pinnedKeys.includes(keyPin)) {
        throw new Error('Certificate pinning failed');
      }
      
      // Standard hostname verification
      return tls.checkServerIdentity(servername, cert);
    }
  });
}

// Use pinned agent for requests
const agent = createPinnedAgent();
https.get('https://api.example.com', { agent }, (res) => {
  // Handle response
});
```

## 🔍 Mobile App Pinning

### React Native Certificate Pinning

```javascript
// Using react-native-ssl-pinning
import { fetch } from 'react-native-ssl-pinning';

fetch('https://api.example.com', {
  method: 'GET',
  sslPinning: {
    certs: ['cert1', 'cert2'] // Certificate fingerprints
  }
})
.then(response => response.json())
.then(data => console.log(data));
```

## 🛡️ Best Practices

1. **Backup Pins**: Always include backup pins
2. **Key Pinning**: Prefer public key over certificate pinning
3. **Rotation Plan**: Have plan for key rotation
4. **Monitoring**: Monitor pinning failures
5. **Testing**: Test pinning thoroughly
6. **Documentation**: Document pinned keys
7. **Avoid HPKP**: Don't use deprecated HPKP header

---

**Next**: Learn about [HTTPS Best Practices](./HTTPS-BEST-PRACTICES.md)

