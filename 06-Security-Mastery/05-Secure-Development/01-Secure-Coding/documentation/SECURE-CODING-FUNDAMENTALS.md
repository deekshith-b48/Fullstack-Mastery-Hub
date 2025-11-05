# Secure Coding Fundamentals

## 📚 Overview

Secure coding practices help prevent security vulnerabilities in software. Following secure coding principles reduces the risk of introducing security flaws.

## 🎯 Secure Coding Principles

### Core Principles

1. **Input Validation**: Validate all inputs
2. **Output Encoding**: Encode all outputs
3. **Error Handling**: Secure error handling
4. **Cryptography**: Use strong cryptography
5. **Authentication**: Secure authentication
6. **Authorization**: Proper authorization

## 🔍 Input Validation

### Validate Inputs

```javascript
// Secure input validation
function validateInput(input, schema) {
  // Type validation
  if (typeof input !== schema.type) {
    throw new Error('Invalid input type');
  }
  
  // Length validation
  if (input.length > schema.maxLength) {
    throw new Error('Input too long');
  }
  
  // Format validation
  if (schema.pattern && !schema.pattern.test(input)) {
    throw new Error('Invalid input format');
  }
  
  // Whitelist validation
  if (schema.whitelist && !schema.whitelist.includes(input)) {
    throw new Error('Input not in whitelist');
  }
  
  return sanitizeInput(input);
}
```

## 🔍 Output Encoding

### Encode Outputs

```javascript
// Secure output encoding
const he = require('he');

function encodeOutput(data, context) {
  if (context === 'html') {
    return he.encode(data);
  }
  if (context === 'javascript') {
    return JSON.stringify(data);
  }
  if (context === 'url') {
    return encodeURIComponent(data);
  }
  
  return data;
}
```

## 🔍 Error Handling

### Secure Error Handling

```javascript
// Secure error handling
try {
  await processData(data);
} catch (error) {
  // Log detailed error server-side
  logger.error('Processing error', {
    error: error.message,
    stack: error.stack,
    data: data
  });
  
  // Return generic error to client
  res.status(500).json({
    error: 'An error occurred. Please try again later.'
  });
}
```

## 🛡️ Best Practices

1. **Validate Input**: Always validate inputs
2. **Encode Output**: Encode all outputs
3. **Error Handling**: Secure error handling
4. **Cryptography**: Use strong crypto
5. **Least Privilege**: Follow least privilege
6. **Documentation**: Document security
7. **Testing**: Security testing

---

**Next**: Learn about [Input Validation](./INPUT-VALIDATION.md)

