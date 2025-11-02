# Security

Web security is critical for protecting applications, user data, and preventing vulnerabilities. Understanding security best practices is essential for every developer.

## 📚 Topics Covered

### Web Security Fundamentals

#### [Web-Security](./Web-Security/)
- OWASP Top 10 vulnerabilities
- Security headers (CSP, HSTS, X-Frame-Options)
- HTTPS/TLS encryption
- Same-Origin Policy
- CORS (Cross-Origin Resource Sharing)
- Content Security Policy (CSP)
- Subresource Integrity (SRI)
- Security misconfigurations
- Security testing

#### [Authentication-Authorization](./Authentication-Authorization/)
- Authentication methods
- Password security (hashing, salting)
- Session management
- JWT (JSON Web Tokens)
- OAuth 2.0 and OpenID Connect
- Multi-factor authentication (MFA)
- Single Sign-On (SSO)
- RBAC (Role-Based Access Control)
- API authentication

#### [Encryption](./Encryption/)
- Symmetric encryption (AES)
- Asymmetric encryption (RSA)
- Hashing algorithms (SHA-256, bcrypt)
- Digital signatures
- SSL/TLS certificates
- Data encryption at rest
- Data encryption in transit
- Key management

#### [OWASP](./OWASP/)
- OWASP Top 10 (2021)
  1. Broken Access Control
  2. Cryptographic Failures
  3. Injection
  4. Insecure Design
  5. Security Misconfiguration
  6. Vulnerable Components
  7. Authentication Failures
  8. Software and Data Integrity Failures
  9. Security Logging Failures
  10. Server-Side Request Forgery (SSRF)
- OWASP Testing Guide
- OWASP ASVS (Application Security Verification Standard)
- Secure coding practices

#### [Vulnerability-Management](./Vulnerability-Management/)
- Vulnerability assessment
- Penetration testing
- Security scanning tools
- Dependency scanning
- Patch management
- Security monitoring
- Incident response
- Security audits

## 🎯 Learning Path

### Beginner
1. Understand common vulnerabilities
2. Learn OWASP Top 10
3. Implement secure authentication
4. Use HTTPS
5. Input validation basics

### Intermediate
1. Implement security headers
2. Secure API endpoints
3. Database security
4. Session management
5. Security testing

### Advanced
1. Advanced encryption
2. Security architecture
3. Penetration testing
4. Security monitoring
5. Compliance and auditing

## 🔒 Common Vulnerabilities & Prevention

### Injection Attacks
- **SQL Injection**: Use parameterized queries
- **XSS (Cross-Site Scripting)**: Sanitize input, use CSP
- **Command Injection**: Validate and sanitize inputs

### Authentication Issues
- **Weak Passwords**: Enforce strong password policies
- **Session Fixation**: Regenerate session IDs
- **Broken Authentication**: Use secure authentication libraries

### Data Exposure
- **Sensitive Data**: Encrypt sensitive data
- **Insecure Storage**: Use secure storage mechanisms
- **Insufficient Logging**: Log security events

## 🛡️ Security Best Practices

### Authentication & Authorization
- [ ] Use strong password hashing (bcrypt, Argon2)
- [ ] Implement rate limiting for login
- [ ] Use HTTPS everywhere
- [ ] Implement MFA for sensitive operations
- [ ] Validate and sanitize all inputs
- [ ] Use least privilege principle
- [ ] Implement proper session management
- [ ] Token expiration and refresh

### Data Protection
- [ ] Encrypt sensitive data at rest
- [ ] Use HTTPS for data in transit
- [ ] Implement proper CORS policies
- [ ] Secure cookie settings (HttpOnly, Secure, SameSite)
- [ ] Don't expose sensitive data in URLs
- [ ] Implement Content Security Policy

### API Security
- [ ] Use API authentication
- [ ] Implement rate limiting
- [ ] Validate API inputs
- [ ] Use API versioning
- [ ] Log API access
- [ ] Implement request signing

### Infrastructure Security
- [ ] Keep dependencies updated
- [ ] Use security scanning tools
- [ ] Implement firewall rules
- [ ] Regular security audits
- [ ] Monitor for suspicious activity
- [ ] Implement backup and recovery

## 🔐 Security Headers

Essential HTTP security headers:
```http
Strict-Transport-Security: max-age=31536000
Content-Security-Policy: default-src 'self'
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=()
```

## 🛠️ Security Tools

### Scanning Tools
- **OWASP ZAP** - Security testing
- **Burp Suite** - Web vulnerability scanner
- **Nmap** - Network scanning
- **Nessus** - Vulnerability scanner

### Dependency Scanning
- **npm audit** - Node.js dependencies
- **Snyk** - Dependency vulnerability scanning
- **Dependabot** - Automated dependency updates

### Security Libraries
- **helmet.js** - Security headers for Express
- **bcrypt** - Password hashing
- **jsonwebtoken** - JWT implementation
- **validator.js** - Input validation

## 📝 Secure Coding Checklist

- [ ] Input validation and sanitization
- [ ] Output encoding
- [ ] Parameterized queries
- [ ] Secure authentication
- [ ] Proper error handling (no sensitive info)
- [ ] Security logging
- [ ] Secure configuration
- [ ] Dependency management
- [ ] Security testing
- [ ] Code review for security

## 🔗 Related Topics

- [Backend](../Backend/) - Server-side security
- [Frontend](../Frontend/) - Client-side security
- [Database](../Database/) - Database security
- [DevOps](../DevOps/) - Infrastructure security

---

Security is not optional. Implement security from the start, not as an afterthought. Regular security audits and staying updated with security news is crucial.

