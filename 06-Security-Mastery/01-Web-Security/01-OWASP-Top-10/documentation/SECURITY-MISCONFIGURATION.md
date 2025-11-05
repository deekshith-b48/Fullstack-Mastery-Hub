# Security Misconfiguration

## 📚 Overview

Security misconfiguration is the #5 risk in OWASP Top 10 2021. It occurs when security settings are not properly configured, defaults are left unchanged, or security features are disabled. This vulnerability can lead to unauthorized access, data exposure, and system compromise.

## 🎯 What is Security Misconfiguration?

Security misconfiguration happens when applications, frameworks, servers, or cloud services are not securely configured. This includes default accounts, unnecessary features enabled, error messages revealing sensitive information, and improper security headers.

### Common Misconfigurations

1. **Default Credentials**: Unchanged default usernames/passwords
2. **Error Messages**: Revealing sensitive information
3. **Unnecessary Features**: Enabled but unused services
4. **Outdated Software**: Unpatched systems and dependencies
5. **Improper Security Headers**: Missing or misconfigured headers
6. **Debug Mode**: Enabled in production
7. **Directory Listing**: Enabled directory browsing
8. **Unnecessary HTTP Methods**: Enabled dangerous methods

## 🔍 Default Credentials

### Vulnerable Configuration

```javascript
// VULNERABLE CODE - Default credentials
const dbConfig = {
  host: 'localhost',
  user: 'admin', // Default username
  password: 'admin', // Default password
  database: 'app_db'
};

// VULNERABLE CODE - Hardcoded credentials
const apiKey = 'sk_test_1234567890'; // Hardcoded in code!
```

### Secure Configuration

```javascript
// SECURE CODE - Environment variables
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: process.env.NODE_ENV === 'production' ? {
    rejectUnauthorized: true,
    ca: fs.readFileSync(process.env.DB_CA_CERT)
  } : false
};

// Validate required environment variables
const requiredEnvVars = ['DB_USER', 'DB_PASSWORD', 'DB_NAME'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Missing required environment variable: ${envVar}`);
  }
}

// SECURE CODE - Use secrets management
const AWS = require('aws-sdk');
const secretsManager = new AWS.SecretsManager();

async function getDatabaseCredentials() {
  const secret = await secretsManager.getSecretValue({
    SecretId: 'production/database/credentials'
  }).promise();
  
  return JSON.parse(secret.SecretString);
}
```

## 🔍 Error Messages

### Vulnerable Error Handling

```javascript
// VULNERABLE CODE - Detailed error messages
app.post('/api/login', async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
      return res.status(401).json({
        error: 'User not found in database',
        query: req.body.email,
        stack: new Error().stack // Exposes stack trace!
      });
    }
    
    const isValid = await bcrypt.compare(req.body.password, user.password);
    if (!isValid) {
      return res.status(401).json({
        error: 'Password hash comparison failed',
        userId: user.id // Exposes user ID!
      });
    }
    
    res.json({ token: generateToken(user) });
  } catch (error) {
    res.status(500).json({
      error: error.message,
      stack: error.stack, // Exposes internal details!
      code: error.code
    });
  }
});
```

### Secure Error Handling

```javascript
// SECURE CODE - Generic error messages
app.post('/api/login', async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    const isValid = user && await bcrypt.compare(req.body.password, user.password);
    
    // Generic error message for both cases
    if (!isValid) {
      // Log detailed error server-side
      logger.warn('Failed login attempt', {
        email: req.body.email,
        ip: req.ip,
        timestamp: Date.now()
      });
      
      // Generic response to client
      return res.status(401).json({
        error: 'Invalid email or password'
      });
    }
    
    res.json({ token: generateToken(user) });
  } catch (error) {
    // Log detailed error server-side
    logger.error('Login error', {
      error: error.message,
      stack: error.stack,
      email: req.body.email,
      ip: req.ip
    });
    
    // Generic response to client
    res.status(500).json({
      error: 'An error occurred. Please try again later.'
    });
  }
});

// Error handler middleware
app.use((error, req, res, next) => {
  // Log error details
  logger.error('Application error', {
    error: error.message,
    stack: error.stack,
    url: req.url,
    method: req.method,
    ip: req.ip
  });
  
  // Generic response
  res.status(error.status || 500).json({
    error: process.env.NODE_ENV === 'production'
      ? 'An error occurred'
      : error.message // Only in development
  });
});
```

## 🔍 Unnecessary Features

### Vulnerable Configuration

```javascript
// VULNERABLE CODE - Unnecessary features enabled
const express = require('express');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public', { dotfiles: 'allow' })); // Allows .htaccess access!

// Debug mode in production
if (process.env.DEBUG) {
  app.use(require('express-debug')); // Exposes internal state!
}
```

### Secure Configuration

```javascript
// SECURE CODE - Minimal necessary features
const express = require('express');
const helmet = require('helmet');
const app = express();

// Security headers
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  noSniff: true,
  xssFilter: true,
  frameguard: { action: 'deny' }
}));

// Body parsing with limits
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Static files - no dotfiles
app.use(express.static('public', {
  dotfiles: 'ignore',
  index: false, // Disable directory listing
  maxAge: '1d'
}));

// Disable debug mode in production
if (process.env.NODE_ENV === 'production') {
  app.set('env', 'production');
  app.disable('x-powered-by'); // Remove X-Powered-By header
}
```

## 🔍 Security Headers

### Missing Security Headers

```javascript
// VULNERABLE CODE - No security headers
app.get('/api/data', (req, res) => {
  res.json({ data: 'sensitive data' });
  // Missing security headers!
});
```

### Secure Headers Configuration

```javascript
// SECURE CODE - Comprehensive security headers
app.use((req, res, next) => {
  // Content Security Policy
  res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'");
  
  // X-Content-Type-Options
  res.setHeader('X-Content-Type-Options', 'nosniff');
  
  // X-Frame-Options
  res.setHeader('X-Frame-Options', 'DENY');
  
  // X-XSS-Protection
  res.setHeader('X-XSS-Protection', '1; mode=block');
  
  // Strict-Transport-Security
  if (req.secure || req.headers['x-forwarded-proto'] === 'https') {
    res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains; preload');
  }
  
  // Referrer-Policy
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  
  // Permissions-Policy
  res.setHeader('Permissions-Policy', 'geolocation=(), microphone=(), camera=()');
  
  // Remove X-Powered-By
  res.removeHeader('X-Powered-By');
  
  next();
});
```

## 🔍 Directory Listing

### Vulnerable Configuration

```javascript
// VULNERABLE CODE - Directory listing enabled
app.use(express.static('public', {
  index: true, // Shows directory listing!
  dotfiles: 'allow' // Allows access to hidden files!
}));
```

### Secure Configuration

```javascript
// SECURE CODE - Disable directory listing
app.use(express.static('public', {
  index: false, // No directory listing
  dotfiles: 'ignore', // Ignore hidden files
  redirect: false
}));

// Custom 404 for directory access
app.use((req, res, next) => {
  if (req.path.endsWith('/')) {
    return res.status(404).json({ error: 'Not found' });
  }
  next();
});
```

## 🔍 HTTP Methods

### Vulnerable Configuration

```javascript
// VULNERABLE CODE - All methods enabled
app.all('/api/data', (req, res) => {
  // Allows TRACE, OPTIONS, etc.
  res.json({ data: 'data' });
});
```

### Secure Configuration

```javascript
// SECURE CODE - Restrict HTTP methods
const allowedMethods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'];

app.use((req, res, next) => {
  if (!allowedMethods.includes(req.method)) {
    return res.status(405).json({ error: 'Method not allowed' });
  }
  next();
});

// Disable TRACE method
app.use((req, res, next) => {
  if (req.method === 'TRACE') {
    return res.status(405).json({ error: 'Method not allowed' });
  }
  next();
});
```

## 🔍 Debug Mode

### Vulnerable Configuration

```javascript
// VULNERABLE CODE - Debug mode in production
if (process.env.DEBUG) {
  app.use(require('morgan')('dev')); // Verbose logging
  app.use(require('express-debug')); // Debug toolbar
}

// VULNERABLE CODE - Verbose error pages
app.set('view options', { debug: true });
```

### Secure Configuration

```javascript
// SECURE CODE - Disable debug in production
const isDevelopment = process.env.NODE_ENV === 'development';

if (isDevelopment) {
  app.use(require('morgan')('dev'));
  app.use(require('express-debug'));
} else {
  // Production: minimal logging
  app.use(require('morgan')('combined'));
  app.disable('view cache');
  app.set('view options', { debug: false });
}
```

## 🛡️ Configuration Management

### Secure Configuration

```javascript
// SECURE CODE - Configuration validation
const Joi = require('joi');

const configSchema = Joi.object({
  NODE_ENV: Joi.string().valid('development', 'production', 'test').required(),
  PORT: Joi.number().port().required(),
  DB_HOST: Joi.string().hostname().required(),
  DB_USER: Joi.string().required(),
  DB_PASSWORD: Joi.string().min(12).required(),
  JWT_SECRET: Joi.string().min(32).required(),
  SESSION_SECRET: Joi.string().min(32).required()
});

function validateConfig() {
  const config = {
    NODE_ENV: process.env.NODE_ENV,
    PORT: process.env.PORT,
    DB_HOST: process.env.DB_HOST,
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    JWT_SECRET: process.env.JWT_SECRET,
    SESSION_SECRET: process.env.SESSION_SECRET
  };
  
  const { error, value } = configSchema.validate(config);
  
  if (error) {
    throw new Error(`Configuration error: ${error.details[0].message}`);
  }
  
  return value;
}

const config = validateConfig();
```

## 📊 Security Checklist

### Application Security

- [ ] Default credentials changed
- [ ] Error messages sanitized
- [ ] Debug mode disabled in production
- [ ] Security headers configured
- [ ] Directory listing disabled
- [ ] Unnecessary features disabled
- [ ] HTTP methods restricted

### Server Security

- [ ] Server software updated
- [ ] Unnecessary services disabled
- [ ] Firewall configured
- [ ] SSL/TLS properly configured
- [ ] Access logs enabled
- [ ] File permissions set correctly

### Database Security

- [ ] Default accounts disabled
- [ ] Strong passwords set
- [ ] Network access restricted
- [ ] Encryption enabled
- [ ] Backups secured
- [ ] Audit logging enabled

## 🎯 Best Practices

1. **Security by Default**: Secure defaults
2. **Regular Updates**: Keep software updated
3. **Minimal Configuration**: Enable only necessary features
4. **Error Handling**: Generic error messages
5. **Security Headers**: Configure all security headers
6. **Configuration Validation**: Validate all configurations
7. **Regular Audits**: Review configurations regularly

## 🎓 Learning Resources

- OWASP Security Misconfiguration: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/
- Security Headers: https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html
- Configuration Security: https://cheatsheetseries.owasp.org/cheatsheets/Application_Security_Verification_Standard.html

---

**Next**: Learn about [Cross-Site Scripting (XSS)](./CROSS-SITE-SCRIPTING-XSS.md)

