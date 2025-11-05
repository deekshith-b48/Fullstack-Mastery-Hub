# Cross-Site Scripting (XSS)

## 📚 Overview

Cross-Site Scripting (XSS) is a critical security vulnerability that allows attackers to inject malicious scripts into web pages viewed by other users. XSS attacks can steal cookies, session tokens, or other sensitive information, and can be used to perform actions on behalf of users.

## 🎯 What is XSS?

XSS occurs when an application includes untrusted data in a web page without proper validation or encoding. An attacker can inject malicious scripts that execute in the victim's browser context, potentially accessing sensitive data or performing unauthorized actions.

### Types of XSS

1. **Reflected XSS**: Script reflected in response
2. **Stored XSS**: Script stored and executed later
3. **DOM-based XSS**: Script manipulating DOM

## 🔍 Reflected XSS

### How Reflected XSS Works

Reflected XSS occurs when user input is immediately reflected in the response without proper sanitization:

```javascript
// VULNERABLE CODE - Reflected XSS
app.get('/api/search', (req, res) => {
  const query = req.query.q;
  res.send(`<h1>Search results for: ${query}</h1>`); // XSS vulnerability!
});

// Attack: GET /api/search?q=<script>alert('XSS')</script>
// Result: Script executes in user's browser
```

### Reflected XSS Prevention

```javascript
// SECURE CODE - Output encoding
const he = require('he');

app.get('/api/search', (req, res) => {
  const query = req.query.q;
  const sanitized = he.encode(query); // HTML entity encoding
  res.send(`<h1>Search results for: ${sanitized}</h1>`);
});

// Using template engine with auto-escaping
app.get('/api/search', (req, res) => {
  const query = req.query.q;
  res.render('search', { query }); // Auto-escaped by template engine
});
```

## 🔍 Stored XSS

### How Stored XSS Works

Stored XSS occurs when malicious scripts are stored in the database and executed when retrieved:

```javascript
// VULNERABLE CODE - Stored XSS
app.post('/api/comments', authenticate, async (req, res) => {
  const comment = {
    userId: req.user.id,
    content: req.body.content, // No sanitization!
    createdAt: new Date()
  };
  
  await Comment.create(comment);
  res.json({ success: true });
});

app.get('/api/comments', async (req, res) => {
  const comments = await Comment.find();
  res.json(comments); // Returns unsanitized content
});

// Frontend - VULNERABLE
// comments.forEach(comment => {
//   document.innerHTML += `<div>${comment.content}</div>`; // XSS!
// });
```

### Stored XSS Prevention

```javascript
// SECURE CODE - Input validation and sanitization
const DOMPurify = require('isomorphic-dompurify');
const validator = require('validator');

app.post('/api/comments', authenticate, async (req, res) => {
  const content = req.body.content;
  
  // Input validation
  if (!content || typeof content !== 'string') {
    return res.status(400).json({ error: 'Invalid content' });
  }
  
  if (content.length > 1000) {
    return res.status(400).json({ error: 'Content too long' });
  }
  
  // Sanitize HTML
  const sanitized = DOMPurify.sanitize(content, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a'],
    ALLOWED_ATTR: ['href'],
    ALLOW_DATA_ATTR: false
  });
  
  const comment = {
    userId: req.user.id,
    content: sanitized, // Sanitized before storage
    createdAt: new Date()
  };
  
  await Comment.create(comment);
  res.json({ success: true });
});

// SECURE CODE - Output encoding
app.get('/api/comments', async (req, res) => {
  const comments = await Comment.find();
  
  // Encode all output
  const safeComments = comments.map(comment => ({
    ...comment,
    content: he.encode(comment.content) // Encode on output
  }));
  
  res.json(safeComments);
});
```

## 🔍 DOM-based XSS

### How DOM-based XSS Works

DOM-based XSS occurs when JavaScript manipulates the DOM with untrusted data:

```javascript
// VULNERABLE CODE - DOM-based XSS
// Frontend JavaScript
const urlParams = new URLSearchParams(window.location.search);
const name = urlParams.get('name');
document.getElementById('greeting').innerHTML = `Hello ${name}`; // XSS!

// Attack: ?name=<img src=x onerror=alert('XSS')>
```

### DOM-based XSS Prevention

```javascript
// SECURE CODE - Safe DOM manipulation
const urlParams = new URLSearchParams(window.location.search);
const name = urlParams.get('name');

// Validate and sanitize
const sanitizedName = DOMPurify.sanitize(name || 'Guest');

// Use textContent instead of innerHTML
document.getElementById('greeting').textContent = `Hello ${sanitizedName}`;

// Or use safe HTML insertion
const greetingEl = document.getElementById('greeting');
greetingEl.innerHTML = DOMPurify.sanitize(`Hello ${name}`, {
  ALLOWED_TAGS: [],
  ALLOWED_ATTR: []
});
```

## 🛡️ XSS Prevention Strategies

### 1. Input Validation

```javascript
function validateInput(input, type) {
  switch (type) {
    case 'text':
      // Remove HTML tags
      return input.replace(/<[^>]*>/g, '');
    
    case 'html':
      // Sanitize HTML
      return DOMPurify.sanitize(input);
    
    case 'url':
      // Validate URL
      if (!validator.isURL(input)) {
        throw new Error('Invalid URL');
      }
      return input;
    
    case 'email':
      // Validate email
      if (!validator.isEmail(input)) {
        throw new Error('Invalid email');
      }
      return validator.normalizeEmail(input);
    
    default:
      return he.encode(input);
  }
}
```

### 2. Output Encoding

```javascript
// Context-specific encoding
function encodeForContext(input, context) {
  switch (context) {
    case 'html':
      return he.encode(input);
    
    case 'html-attribute':
      return he.encode(input, { useNamedReferences: true });
    
    case 'javascript':
      return input
        .replace(/\\/g, '\\\\')
        .replace(/'/g, "\\'")
        .replace(/"/g, '\\"')
        .replace(/\n/g, '\\n')
        .replace(/\r/g, '\\r');
    
    case 'css':
      return input.replace(/[<>\"']/g, '');
    
    case 'url':
      return encodeURIComponent(input);
    
    default:
      return he.encode(input);
  }
}
```

### 3. Content Security Policy (CSP)

```javascript
// SECURE CODE - CSP headers
app.use((req, res, next) => {
  res.setHeader('Content-Security-Policy', [
    "default-src 'self'",
    "script-src 'self' 'unsafe-inline'", // Avoid unsafe-inline if possible
    "style-src 'self' 'unsafe-inline'",
    "img-src 'self' data: https:",
    "font-src 'self'",
    "connect-src 'self'",
    "frame-ancestors 'none'",
    "base-uri 'self'",
    "form-action 'self'"
  ].join('; '));
  
  next();
});

// Nonce-based CSP (better security)
app.use((req, res, next) => {
  const nonce = crypto.randomBytes(16).toString('base64');
  res.locals.nonce = nonce;
  
  res.setHeader('Content-Security-Policy', [
    `script-src 'self' 'nonce-${nonce}'`,
    "style-src 'self'",
    "default-src 'self'"
  ].join('; '));
  
  next();
});

// In template
<script nonce="<%= nonce %>">
  // This script will execute
</script>
```

### 4. HTTP-Only Cookies

```javascript
// SECURE CODE - HTTP-only cookies
app.post('/api/login', async (req, res) => {
  const token = generateToken(user);
  
  res.cookie('sessionToken', token, {
    httpOnly: true, // Prevents JavaScript access
    secure: true, // HTTPS only
    sameSite: 'strict', // CSRF protection
    maxAge: 3600000 // 1 hour
  });
  
  res.json({ success: true });
});
```

## 🔍 XSS in Different Contexts

### XSS in React

```javascript
// VULNERABLE CODE - React
function UserProfile({ user }) {
  return <div dangerouslySetInnerHTML={{ __html: user.bio }} />; // XSS!
}

// SECURE CODE - React
function UserProfile({ user }) {
  return <div>{user.bio}</div>; // Auto-escaped by React
}

// If HTML is needed
function UserProfile({ user }) {
  const sanitized = DOMPurify.sanitize(user.bio);
  return <div dangerouslySetInnerHTML={{ __html: sanitized }} />;
}
```

### XSS in JSON APIs

```javascript
// VULNERABLE CODE - JSON response
app.get('/api/data', (req, res) => {
  const data = {
    name: req.query.name,
    message: `Hello ${req.query.name}` // Could contain XSS
  };
  res.json(data);
});

// Frontend - VULNERABLE
// document.body.innerHTML = data.message; // XSS!

// SECURE CODE - Sanitize JSON data
app.get('/api/data', (req, res) => {
  const name = he.encode(req.query.name || 'Guest');
  const data = {
    name: name,
    message: `Hello ${name}` // Already encoded
  };
  res.json(data);
});
```

## 📊 XSS Testing

```javascript
// XSS test payloads
const xssPayloads = [
  '<script>alert("XSS")</script>',
  '<img src=x onerror=alert("XSS")>',
  '<svg onload=alert("XSS")>',
  '"><script>alert("XSS")</script>',
  "javascript:alert('XSS')",
  '<iframe src="javascript:alert(\'XSS\')"></iframe>',
  '<body onload=alert("XSS")>',
  '<input autofocus onfocus=alert("XSS")>',
  '<select onfocus=alert("XSS") autofocus>',
  '<textarea onfocus=alert("XSS") autofocus>',
  '<keygen onfocus=alert("XSS") autofocus>',
  '<video><source onerror=alert("XSS")>',
  '<audio src=x onerror=alert("XSS")>'
];

// Test function
async function testXSS(payload) {
  const response = await fetch(`/api/search?q=${encodeURIComponent(payload)}`);
  const html = await response.text();
  
  if (html.includes(payload) && !html.includes(he.encode(payload))) {
    console.log('XSS vulnerability detected!');
    return true;
  }
  
  return false;
}
```

## 🎯 Best Practices

1. **Input Validation**: Validate all user input
2. **Output Encoding**: Encode all output appropriately
3. **Content Security Policy**: Implement CSP headers
4. **HTTP-Only Cookies**: Use HTTP-only cookies
5. **Template Engines**: Use auto-escaping template engines
6. **Sanitization**: Sanitize HTML when needed
7. **Regular Testing**: Test for XSS vulnerabilities

## 🎓 Learning Resources

- OWASP XSS: https://owasp.org/www-community/attacks/xss/
- XSS Prevention: https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html
- DOM XSS: https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html

---

**Next**: Learn about [Insecure Deserialization](./INSECURE-DESERIALIZATION.md)

