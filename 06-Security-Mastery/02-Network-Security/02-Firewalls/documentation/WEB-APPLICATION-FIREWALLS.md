# Web Application Firewalls (WAF)

## 📚 Overview

Web Application Firewalls protect web applications by filtering HTTP/HTTPS traffic. They detect and block web attacks like SQL injection, XSS, and other OWASP Top 10 vulnerabilities.

## 🎯 WAF Functions

### Protection Features

1. **Attack Detection**: Detect common web attacks
2. **Traffic Filtering**: Block malicious requests
3. **Rate Limiting**: Prevent DDoS attacks
4. **Bot Protection**: Block malicious bots

## 🔍 WAF Implementation

### Application-Level WAF

```javascript
const express = require('express');
const helmet = require('helmet');

const app = express();

// Basic WAF using helmet
app.use(helmet());

// Custom WAF middleware
function wafMiddleware(req, res, next) {
  // Check for SQL injection
  const sqlPatterns = [
    /(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION)\b)/i,
    /('|(\\')|(--)|(\/\*)|(\*\/)|(\%27)|(\%00))/i
  ];
  
  const queryString = JSON.stringify(req.query) + JSON.stringify(req.body);
  
  for (const pattern of sqlPatterns) {
    if (pattern.test(queryString)) {
      return res.status(403).json({ error: 'Request blocked by WAF' });
    }
  }
  
  // Check for XSS
  const xssPatterns = [
    /<script[^>]*>.*?<\/script>/gi,
    /javascript:/gi,
    /on\w+\s*=/gi
  ];
  
  for (const pattern of xssPatterns) {
    if (pattern.test(queryString)) {
      return res.status(403).json({ error: 'Request blocked by WAF' });
    }
  }
  
  next();
}

app.use(wafMiddleware);
```

## 🔍 WAF Rules

### Common WAF Rules

```javascript
const wafRules = {
  sqlInjection: {
    pattern: /(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION)\b)/i,
    action: 'block',
    severity: 'high'
  },
  xss: {
    pattern: /<script[^>]*>.*?<\/script>/gi,
    action: 'block',
    severity: 'high'
  },
  pathTraversal: {
    pattern: /\.\.\/|\.\.\\|\.\.%2f|\.\.%5c/i,
    action: 'block',
    severity: 'high'
  },
  commandInjection: {
    pattern: /[;&|`$(){}[\]]/,
    action: 'block',
    severity: 'high'
  }
};

function checkWAFRules(request) {
  const requestData = JSON.stringify(request);
  
  for (const [ruleName, rule] of Object.entries(wafRules)) {
    if (rule.pattern.test(requestData)) {
      logWAFEvent({
        rule: ruleName,
        severity: rule.severity,
        request: request,
        action: rule.action
      });
      
      return { blocked: true, rule: ruleName };
    }
  }
  
  return { blocked: false };
}
```

## 🔍 Cloud WAF

### AWS WAF Integration

```javascript
// AWS WAF rules
const awsWAFRules = {
  // SQL injection rule
  sqlInjection: {
    priority: 1,
    statement: {
      byteMatchStatement: {
        searchString: 'SELECT',
        fieldToMatch: { allQueryArguments: {} },
        textTransformations: [{ priority: 0, type: 'LOWERCASE' }]
      }
    },
    action: { block: {} }
  },
  
  // XSS rule
  xss: {
    priority: 2,
    statement: {
      xssMatchStatement: {
        fieldToMatch: { allQueryArguments: {} },
        textTransformations: [{ priority: 0, type: 'NONE' }]
      }
    },
    action: { block: {} }
  }
};
```

## 🛡️ Best Practices

1. **Rule Tuning**: Tune rules for your application
2. **False Positives**: Monitor and reduce false positives
3. **Regular Updates**: Keep WAF rules updated
4. **Monitoring**: Monitor WAF logs
5. **Testing**: Test WAF rules
6. **Whitelisting**: Whitelist legitimate traffic
7. **Documentation**: Document WAF configuration

---

**Next**: Learn about [Firewall Rules Configuration](./FIREWALL-RULES-CONFIGURATION.md)

