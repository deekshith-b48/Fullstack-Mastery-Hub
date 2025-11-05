# Output Encoding

## 📚 Overview

Output encoding prevents XSS attacks by encoding data before output. It ensures that user input is treated as data, not executable code.

## 🎯 Encoding Contexts

### Context-Specific Encoding

1. **HTML Context**: HTML entity encoding
2. **JavaScript Context**: JavaScript encoding
3. **URL Context**: URL encoding
4. **CSS Context**: CSS encoding
5. **Attribute Context**: HTML attribute encoding

## 🔍 Encoding Implementation

### Context-Aware Encoding

```javascript
// Context-aware output encoding
const he = require('he');

class OutputEncoder {
  encodeForHTML(data) {
    return he.encode(data, {
      useNamedReferences: true,
      encodeEverything: true
    });
  }
  
  encodeForJavaScript(data) {
    return JSON.stringify(data).slice(1, -1);
  }
  
  encodeForURL(data) {
    return encodeURIComponent(data);
  }
  
  encodeForAttribute(data) {
    return he.encode(data, {
      useNamedReferences: true
    });
  }
  
  encodeForCSS(data) {
    // CSS encoding
    return data.replace(/[^a-zA-Z0-9]/g, '\\$&');
  }
}
```

## 🔍 Content Security Policy

### CSP Headers

```javascript
// Content Security Policy
app.use((req, res, next) => {
  res.setHeader('Content-Security-Policy',
    "default-src 'self'; " +
    "script-src 'self'; " +
    "style-src 'self' 'unsafe-inline'; " +
    "img-src 'self' data: https:; " +
    "font-src 'self'; " +
    "connect-src 'self'; " +
    "frame-ancestors 'none';"
  );
  next();
});
```

## 🛡️ Best Practices

1. **Context-Aware**: Use context-appropriate encoding
2. **Always Encode**: Encode all user data
3. **CSP**: Use Content Security Policy
4. **No InnerHTML**: Avoid innerHTML with user data
5. **Libraries**: Use encoding libraries
6. **Testing**: Test encoding
7. **Documentation**: Document encoding strategy

---

**Next**: Learn about [Error Handling Security](./ERROR-HANDLING-SECURITY.md)

