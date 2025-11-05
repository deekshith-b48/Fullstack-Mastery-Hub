# Mixed Content Prevention

## 📚 Overview

Mixed content occurs when an HTTPS page loads resources (images, scripts, stylesheets) over HTTP. This creates security vulnerabilities and should be prevented.

## 🎯 What is Mixed Content?

Mixed content happens when:
- HTTPS page loads HTTP resources
- Secure page includes insecure content
- Browser blocks or warns about mixed content

## 🔍 Types of Mixed Content

### Active Mixed Content

More dangerous, includes:
- Scripts (`<script>`)
- Stylesheets (`<link>`)
- iframes (`<iframe>`)
- XMLHttpRequest

Browsers block active mixed content by default.

### Passive Mixed Content

Less dangerous, includes:
- Images (`<img>`)
- Audio (`<audio>`)
- Video (`<video>`)

Browsers may allow but warn about passive mixed content.

## 🔍 Prevention Strategies

### 1. Use HTTPS for All Resources

```javascript
// Always use HTTPS URLs
const secureResources = {
  image: 'https://example.com/image.jpg',
  script: 'https://cdn.example.com/script.js',
  stylesheet: 'https://cdn.example.com/style.css'
};
```

### 2. Content Security Policy

```javascript
// CSP to prevent mixed content
app.use((req, res, next) => {
  res.setHeader('Content-Security-Policy', 
    "default-src 'self' https:; " +
    "script-src 'self' https:; " +
    "style-src 'self' https:; " +
    "img-src 'self' https: data:; " +
    "block-all-mixed-content"
  );
  next();
});
```

### 3. Upgrade Insecure Requests

```javascript
// Upgrade HTTP to HTTPS
app.use((req, res, next) => {
  res.setHeader('Upgrade-Insecure-Requests', '1');
  next();
});
```

## 🔍 Detection and Fixing

### Detect Mixed Content

```javascript
// Check for HTTP URLs in HTML
function detectMixedContent(html) {
  const httpPattern = /http:\/\/(?!localhost)/g;
  const matches = html.match(httpPattern);
  
  if (matches) {
    console.warn('Mixed content detected:', matches);
    return true;
  }
  
  return false;
}

// Fix mixed content
function fixMixedContent(html) {
  return html.replace(/http:\/\/(?!localhost)/g, 'https://');
}
```

## 🔍 Content Security Policy

### Strict CSP

```javascript
const helmet = require('helmet');

app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'", 'https:'],
    scriptSrc: ["'self'", 'https:'],
    styleSrc: ["'self'", 'https:', "'unsafe-inline'"],
    imgSrc: ["'self'", 'https:', 'data:'],
    connectSrc: ["'self'", 'https:'],
    fontSrc: ["'self'", 'https:'],
    objectSrc: ["'none'"],
    mediaSrc: ["'self'", 'https:'],
    frameSrc: ["'none'"],
    upgradeInsecureRequests: []
  }
}));
```

## 🛡️ Best Practices

1. **HTTPS Everything**: Use HTTPS for all resources
2. **CSP Headers**: Implement Content Security Policy
3. **Upgrade Requests**: Use Upgrade-Insecure-Requests
4. **Testing**: Test for mixed content
5. **Monitoring**: Monitor for mixed content warnings
6. **Third-Party**: Ensure third-party resources use HTTPS
7. **Documentation**: Document resource URLs

---

**Next**: Learn about [Certificate Pinning](./CERTIFICATE-PINNING.md)

