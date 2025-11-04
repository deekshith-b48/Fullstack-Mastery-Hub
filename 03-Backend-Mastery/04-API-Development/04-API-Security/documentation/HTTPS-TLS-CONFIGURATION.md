# HTTPS/TLS Configuration

## 📚 Overview

HTTPS encrypts data in transit using TLS/SSL.

## 🔒 Express with HTTPS

```javascript
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('private-key.pem'),
  cert: fs.readFileSync('certificate.pem')
};

https.createServer(options, app).listen(443);
```

## 🚀 Let's Encrypt

```bash
# Install certbot
sudo apt-get install certbot

# Generate certificate
sudo certbot certonly --standalone -d yourdomain.com

# Auto-renewal
sudo certbot renew --dry-run
```

## 🔧 Nginx SSL Configuration

```nginx
server {
  listen 443 ssl;
  server_name yourdomain.com;
  
  ssl_certificate /path/to/cert.pem;
  ssl_certificate_key /path/to/key.pem;
  
  location / {
    proxy_pass http://localhost:3000;
  }
}
```

---

**Next**: Learn about [API Rate Limiting](./API-RATE-LIMITING.md)

