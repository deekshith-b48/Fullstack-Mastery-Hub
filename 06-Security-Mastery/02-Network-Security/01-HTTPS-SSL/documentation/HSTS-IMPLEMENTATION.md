# HSTS Implementation

## 📚 Overview

HTTP Strict Transport Security (HSTS) is a security policy that forces browsers to use HTTPS connections. It prevents protocol downgrade attacks and cookie hijacking.

## 🎯 What is HSTS?

HSTS tells browsers to only connect to a site via HTTPS, even if the user types HTTP. This prevents man-in-the-middle attacks and ensures secure connections.

## 🔍 HSTS Header

### Basic HSTS Header

```javascript
app.use((req, res, next) => {
  if (req.secure || req.headers['x-forwarded-proto'] === 'https') {
    res.setHeader('Strict-Transport-Security', 
      'max-age=31536000; includeSubDomains; preload'
    );
  }
  next();
});
```

### HSTS Parameters

- **max-age**: Time in seconds (31536000 = 1 year)
- **includeSubDomains**: Applies to all subdomains
- **preload**: Eligible for browser preload lists

## 🔍 HSTS Implementation

### Express.js HSTS

```javascript
const helmet = require('helmet');

app.use(helmet.hsts({
  maxAge: 31536000,
  includeSubDomains: true,
  preload: true
}));
```

### Custom HSTS Middleware

```javascript
function hstsMiddleware(maxAge = 31536000, includeSubDomains = true, preload = false) {
  return (req, res, next) => {
    if (req.secure || req.headers['x-forwarded-proto'] === 'https') {
      let hstsValue = `max-age=${maxAge}`;
      
      if (includeSubDomains) {
        hstsValue += '; includeSubDomains';
      }
      
      if (preload) {
        hstsValue += '; preload';
      }
      
      res.setHeader('Strict-Transport-Security', hstsValue);
    }
    next();
  };
}

app.use(hstsMiddleware());
```

## 🔍 HSTS Preload

### Preload List Submission

To submit to HSTS preload list:
1. Implement HSTS with `preload` directive
2. Ensure HTTPS works correctly
3. Submit to https://hstspreload.org
4. Once accepted, browsers will preload HSTS

### Preload Requirements

- HSTS header with `preload` directive
- Valid HTTPS certificate
- Redirect HTTP to HTTPS
- Include subdomains
- max-age >= 31536000 (1 year)

## 🛡️ Best Practices

1. **Always Use HSTS**: Implement HSTS on all HTTPS sites
2. **Long max-age**: Use at least 1 year (31536000)
3. **Include Subdomains**: Use includeSubDomains
4. **Preload**: Consider preload for public sites
5. **HTTPS Only**: Ensure all connections use HTTPS
6. **Testing**: Test HSTS implementation
7. **Monitoring**: Monitor HSTS header presence

---

**Next**: Learn about [SSL/TLS Configuration](./SSL-TLS-CONFIGURATION.md)

