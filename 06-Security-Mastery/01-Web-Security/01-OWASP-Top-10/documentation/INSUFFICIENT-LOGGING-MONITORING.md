# Insufficient Logging and Monitoring

## 📚 Overview

Insufficient logging and monitoring is the #9 risk in OWASP Top 10 2021. It occurs when security events are not properly logged, monitored, or responded to. This makes it difficult to detect attacks, investigate incidents, and respond to security breaches.

## 🎯 What is Insufficient Logging and Monitoring?

Insufficient logging and monitoring happens when applications fail to log security-relevant events, don't monitor for suspicious activities, or lack proper alerting mechanisms. This allows attackers to operate undetected and makes incident response difficult.

### Common Issues

1. **Missing Logs**: Security events not logged
2. **Insufficient Detail**: Logs lack necessary information
3. **No Monitoring**: No active monitoring of logs
4. **Delayed Alerts**: Alerts not sent or delayed
5. **Log Tampering**: Logs can be modified or deleted
6. **No Incident Response**: No plan for security incidents

## 🔍 Missing Security Logs

### Vulnerable Code - No Logging

```javascript
// VULNERABLE CODE - No security logging
app.post('/api/login', async (req, res) => {
  const user = await User.findOne({ email: req.body.email });
  const isValid = await bcrypt.compare(req.body.password, user.password);
  
  if (!isValid) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // No logging of failed attempts!
  // No logging of successful logins!
  
  res.json({ token: generateToken(user) });
});

app.delete('/api/users/:id', authenticate, async (req, res) => {
  await User.deleteOne({ id: req.params.id });
  // No logging of user deletion!
  res.json({ success: true });
});
```

### Secure Code - Comprehensive Logging

```javascript
// SECURE CODE - Security event logging
const winston = require('winston');

const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'security.log' }),
    new winston.transports.Console()
  ]
});

app.post('/api/login', async (req, res) => {
  const email = req.body.email;
  const ipAddress = req.ip;
  const userAgent = req.headers['user-agent'];
  
  try {
    const user = await User.findOne({ email });
    const isValid = user && await bcrypt.compare(req.body.password, user.password);
    
    if (!isValid) {
      // Log failed login attempt
      securityLogger.warn('Failed login attempt', {
        email,
        ipAddress,
        userAgent,
        timestamp: new Date().toISOString(),
        reason: user ? 'invalid_password' : 'user_not_found'
      });
      
      // Track failed attempts
      await incrementFailedAttempts(email, ipAddress);
      
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Log successful login
    securityLogger.info('Successful login', {
      userId: user.id,
      email,
      ipAddress,
      userAgent,
      timestamp: new Date().toISOString()
    });
    
    // Reset failed attempts
    await resetFailedAttempts(email);
    
    res.json({ token: generateToken(user) });
  } catch (error) {
    securityLogger.error('Login error', {
      email,
      ipAddress,
      error: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({ error: 'An error occurred' });
  }
});

app.delete('/api/users/:id', authenticate, authorize(['admin']), async (req, res) => {
  const targetUserId = req.params.id;
  const actorUserId = req.user.id;
  
  try {
    await User.deleteOne({ id: targetUserId });
    
    // Log user deletion
    securityLogger.warn('User deleted', {
      targetUserId,
      actorUserId,
      ipAddress: req.ip,
      userAgent: req.headers['user-agent'],
      timestamp: new Date().toISOString()
    });
    
    // Send alert for sensitive action
    await sendSecurityAlert({
      type: 'user_deleted',
      severity: 'high',
      actor: actorUserId,
      target: targetUserId,
      timestamp: Date.now()
    });
    
    res.json({ success: true });
  } catch (error) {
    securityLogger.error('User deletion error', {
      targetUserId,
      actorUserId,
      error: error.message,
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({ error: 'An error occurred' });
  }
});
```

## 🔍 Logging Security Events

### What to Log

```javascript
// Security events to log
const securityEvents = {
  // Authentication events
  login_success: {
    userId: 'string',
    email: 'string',
    ipAddress: 'string',
    userAgent: 'string',
    timestamp: 'datetime'
  },
  
  login_failure: {
    email: 'string',
    ipAddress: 'string',
    userAgent: 'string',
    reason: 'string',
    timestamp: 'datetime'
  },
  
  logout: {
    userId: 'string',
    ipAddress: 'string',
    timestamp: 'datetime'
  },
  
  // Authorization events
  access_denied: {
    userId: 'string',
    resource: 'string',
    action: 'string',
    ipAddress: 'string',
    timestamp: 'datetime'
  },
  
  privilege_escalation: {
    userId: 'string',
    oldRole: 'string',
    newRole: 'string',
    actor: 'string',
    timestamp: 'datetime'
  },
  
  // Data access events
  sensitive_data_accessed: {
    userId: 'string',
    dataType: 'string',
    recordId: 'string',
    ipAddress: 'string',
    timestamp: 'datetime'
  },
  
  // Configuration changes
  config_change: {
    userId: 'string',
    configKey: 'string',
    oldValue: 'string',
    newValue: 'string',
    timestamp: 'datetime'
  },
  
  // Security events
  suspicious_activity: {
    userId: 'string',
    activity: 'string',
    ipAddress: 'string',
    details: 'object',
    timestamp: 'datetime'
  }
};
```

### Logging Implementation

```javascript
// Centralized security logging
class SecurityLogger {
  constructor() {
    this.logger = winston.createLogger({
      level: 'info',
      format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.errors({ stack: true }),
        winston.format.json()
      ),
      transports: [
        new winston.transports.File({ 
          filename: 'security.log',
          maxsize: 5242880, // 5MB
          maxFiles: 5
        }),
        new winston.transports.File({
          filename: 'security-errors.log',
          level: 'error'
        })
      ]
    });
  }
  
  log(eventType, data) {
    const logEntry = {
      eventType,
      ...data,
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV
    };
    
    this.logger.info(logEntry);
    
    // Check if alert is needed
    if (this.shouldAlert(eventType, data)) {
      this.sendAlert(eventType, data);
    }
  }
  
  shouldAlert(eventType, data) {
    const alertEvents = [
      'login_failure',
      'access_denied',
      'privilege_escalation',
      'suspicious_activity'
    ];
    
    return alertEvents.includes(eventType);
  }
  
  async sendAlert(eventType, data) {
    // Send to monitoring system
    await sendToMonitoringSystem({
      type: eventType,
      severity: this.getSeverity(eventType),
      data: data
    });
  }
  
  getSeverity(eventType) {
    const severityMap = {
      'login_failure': 'low',
      'access_denied': 'medium',
      'privilege_escalation': 'high',
      'suspicious_activity': 'high'
    };
    
    return severityMap[eventType] || 'medium';
  }
}

const securityLogger = new SecurityLogger();
```

## 🔍 Log Protection

### Secure Log Storage

```javascript
// SECURE CODE - Protect logs from tampering
const crypto = require('crypto');

class SecureLogger {
  constructor() {
    this.logFile = 'security.log';
    this.signatureFile = 'security.log.sig';
  }
  
  async writeLog(entry) {
    const logEntry = JSON.stringify(entry) + '\n';
    
    // Append to log file
    await fs.appendFile(this.logFile, logEntry);
    
    // Generate signature
    const signature = this.signLog(logEntry);
    
    // Store signature
    await fs.appendFile(this.signatureFile, signature + '\n');
  }
  
  signLog(data) {
    const hmac = crypto.createHmac('sha256', process.env.LOG_SECRET);
    hmac.update(data);
    return hmac.digest('hex');
  }
  
  async verifyLogs() {
    const logs = await fs.readFile(this.logFile, 'utf8').split('\n');
    const signatures = await fs.readFile(this.signatureFile, 'utf8').split('\n');
    
    for (let i = 0; i < logs.length; i++) {
      if (logs[i]) {
        const expectedSignature = this.signLog(logs[i]);
        if (expectedSignature !== signatures[i]) {
          throw new Error(`Log tampering detected at line ${i + 1}`);
        }
      }
    }
    
    return true;
  }
}
```

### Log Encryption

```javascript
// Encrypt sensitive log data
const crypto = require('crypto');

function encryptLogData(data) {
  const algorithm = 'aes-256-gcm';
  const key = Buffer.from(process.env.LOG_ENCRYPTION_KEY, 'hex');
  const iv = crypto.randomBytes(16);
  
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  
  let encrypted = cipher.update(JSON.stringify(data), 'utf8', 'hex');
  encrypted += cipher.final('hex');
  
  const authTag = cipher.getAuthTag();
  
  return {
    encrypted: encrypted,
    iv: iv.toString('hex'),
    authTag: authTag.toString('hex')
  };
}
```

## 🔍 Monitoring and Alerting

### Real-Time Monitoring

```javascript
// Real-time log monitoring
const { EventEmitter } = require('events');

class SecurityMonitor extends EventEmitter {
  constructor() {
    super();
    this.suspiciousPatterns = [
      /multiple.*failed.*login/i,
      /privilege.*escalation/i,
      /unauthorized.*access/i,
      /sql.*injection/i,
      /xss.*attempt/i
    ];
    
    this.startMonitoring();
  }
  
  startMonitoring() {
    // Watch log file
    const fs = require('fs');
    const Tail = require('tail').Tail;
    
    const tail = new Tail('security.log');
    
    tail.on('line', (line) => {
      const logEntry = JSON.parse(line);
      this.analyzeLogEntry(logEntry);
    });
  }
  
  analyzeLogEntry(entry) {
    // Check for suspicious patterns
    const logText = JSON.stringify(entry);
    
    for (const pattern of this.suspiciousPatterns) {
      if (pattern.test(logText)) {
        this.emit('suspicious', entry);
        this.sendAlert(entry);
      }
    }
    
    // Check for anomalies
    this.checkAnomalies(entry);
  }
  
  checkAnomalies(entry) {
    // Example: Multiple failed logins from same IP
    if (entry.eventType === 'login_failure') {
      this.trackFailedLogins(entry.ipAddress);
    }
  }
  
  async trackFailedLogins(ipAddress) {
    const key = `failed_logins:${ipAddress}`;
    const count = await redis.incr(key);
    await redis.expire(key, 3600); // 1 hour
    
    if (count >= 5) {
      this.emit('brute_force_attempt', { ipAddress, count });
      await this.sendAlert({
        type: 'brute_force',
        ipAddress,
        count,
        severity: 'high'
      });
    }
  }
  
  async sendAlert(entry) {
    // Send to alerting system
    await sendToAlertingSystem({
      severity: entry.severity || 'medium',
      message: `Security event: ${entry.eventType}`,
      data: entry,
      timestamp: Date.now()
    });
  }
}

const monitor = new SecurityMonitor();

monitor.on('suspicious', (entry) => {
  console.log('Suspicious activity detected:', entry);
});

monitor.on('brute_force_attempt', (data) => {
  console.log('Brute force attack detected:', data);
  // Block IP address
  blockIPAddress(data.ipAddress);
});
```

## 🔍 Log Analysis

### Security Analytics

```javascript
// Analyze logs for security insights
async function analyzeSecurityLogs(startDate, endDate) {
  const logs = await getLogsBetweenDates(startDate, endDate);
  
  const analysis = {
    totalEvents: logs.length,
    eventTypes: {},
    topIPAddresses: {},
    failedLogins: 0,
    successfulLogins: 0,
    accessDenied: 0,
    suspiciousActivities: []
  };
  
  for (const log of logs) {
    // Count event types
    analysis.eventTypes[log.eventType] = 
      (analysis.eventTypes[log.eventType] || 0) + 1;
    
    // Track IP addresses
    if (log.ipAddress) {
      analysis.topIPAddresses[log.ipAddress] = 
        (analysis.topIPAddresses[log.ipAddress] || 0) + 1;
    }
    
    // Count specific events
    if (log.eventType === 'login_failure') analysis.failedLogins++;
    if (log.eventType === 'login_success') analysis.successfulLogins++;
    if (log.eventType === 'access_denied') analysis.accessDenied++;
    
    // Detect suspicious activities
    if (isSuspicious(log)) {
      analysis.suspiciousActivities.push(log);
    }
  }
  
  return analysis;
}

function isSuspicious(log) {
  // Define suspicious patterns
  const suspiciousPatterns = [
    log.eventType === 'login_failure' && log.reason === 'invalid_password',
    log.eventType === 'access_denied' && log.resource === 'admin',
    log.eventType === 'sensitive_data_accessed' && log.userId !== log.expectedUserId
  ];
  
  return suspiciousPatterns.some(pattern => pattern === true);
}
```

## 🎯 Best Practices

1. **Log All Security Events**: Authentication, authorization, data access
2. **Include Context**: IP address, user agent, timestamp, user ID
3. **Protect Logs**: Encrypt, sign, and secure log files
4. **Monitor Actively**: Real-time monitoring and alerting
5. **Regular Analysis**: Analyze logs for patterns and anomalies
6. **Incident Response**: Have a response plan for security events
7. **Retention**: Retain logs according to compliance requirements

## 🎓 Learning Resources

- OWASP Logging: https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html
- Security Monitoring: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Information_Gathering/
- Logging Best Practices: https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html

---

**OWASP Top 10 section complete!** Next: Learn about [Authentication Fundamentals](./../02-Authentication/documentation/AUTHENTICATION-FUNDAMENTALS.md)

