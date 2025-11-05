# Input Validation

## 📚 Overview

Input validation ensures that user input is safe and meets expected criteria. It's the first line of defense against injection attacks.

## 🎯 Validation Strategies

### Validation Approaches

1. **Whitelist**: Allow only known good values
2. **Blacklist**: Reject known bad values
3. **Type Checking**: Verify data types
4. **Length Checking**: Verify length limits
5. **Format Validation**: Verify format

## 🔍 Validation Implementation

### Comprehensive Validation

```javascript
// Comprehensive input validation
class InputValidator {
  validateEmail(email) {
    if (!email || typeof email !== 'string') {
      throw new Error('Invalid email');
    }
    
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
      throw new Error('Invalid email format');
    }
    
    if (email.length > 254) {
      throw new Error('Email too long');
    }
    
    return email.toLowerCase().trim();
  }
  
  validateUsername(username) {
    if (!username || typeof username !== 'string') {
      throw new Error('Invalid username');
    }
    
    if (username.length < 3 || username.length > 20) {
      throw new Error('Username length invalid');
    }
    
    const usernamePattern = /^[a-zA-Z0-9_]+$/;
    if (!usernamePattern.test(username)) {
      throw new Error('Username contains invalid characters');
    }
    
    return username;
  }
  
  validateSQLInput(input) {
    // Use parameterized queries instead
    // This is just for demonstration
    const dangerous = ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'UNION'];
    for (const keyword of dangerous) {
      if (input.toUpperCase().includes(keyword)) {
        throw new Error('Potentially dangerous input detected');
      }
    }
    return input;
  }
}
```

## 🔍 Sanitization

### Sanitize Inputs

```javascript
// Sanitize inputs
function sanitizeInput(input) {
  if (typeof input !== 'string') {
    return input;
  }
  
  // Remove null bytes
  input = input.replace(/\0/g, '');
  
  // Trim whitespace
  input = input.trim();
  
  // Remove control characters
  input = input.replace(/[\x00-\x1F\x7F]/g, '');
  
  return input;
}
```

## 🛡️ Best Practices

1. **Whitelist**: Prefer whitelist validation
2. **Server-Side**: Always validate server-side
3. **Type Checking**: Check data types
4. **Length Limits**: Enforce length limits
5. **Sanitization**: Sanitize when needed
6. **Parameterized Queries**: Use for SQL
7. **Regular Updates**: Keep validators updated

---

**Next**: Learn about [Output Encoding](./OUTPUT-ENCODING.md)

