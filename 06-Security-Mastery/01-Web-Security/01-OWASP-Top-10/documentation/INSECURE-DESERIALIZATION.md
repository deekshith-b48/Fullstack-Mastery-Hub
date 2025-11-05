# Insecure Deserialization

## 📚 Overview

Insecure deserialization occurs when applications deserialize untrusted data without proper validation. Attackers can exploit this to execute arbitrary code, perform denial of service attacks, or manipulate application logic.

## 🎯 What is Insecure Deserialization?

Insecure deserialization happens when applications deserialize data from untrusted sources without proper validation or sanitization. This can lead to remote code execution, privilege escalation, and data manipulation.

### Serialization vs Deserialization

- **Serialization**: Converting objects to storable/transmittable format
- **Deserialization**: Reconstructing objects from serialized format

### Common Vulnerabilities

1. **Remote Code Execution**: Executing arbitrary code
2. **Object Injection**: Manipulating object properties
3. **Denial of Service**: Causing application crashes
4. **Privilege Escalation**: Gaining unauthorized access
5. **Data Tampering**: Modifying serialized data

## 🔍 Remote Code Execution

### Vulnerable Code - Python

```python
# VULNERABLE CODE - Pickle deserialization
import pickle

def deserialize_data(data):
    return pickle.loads(data)  # Dangerous! Can execute arbitrary code

# Attack payload
malicious_pickle = b'''cos
system
(S'rm -rf /'
tR.'''

# Deserializing this would execute: rm -rf /
```

### Secure Code - Python

```python
# SECURE CODE - Use JSON instead of pickle
import json

def serialize_data(data):
    return json.dumps(data)

def deserialize_data(data):
    return json.loads(data)  # Safe - no code execution

# SECURE CODE - If pickle is necessary, use restricted unpickler
import pickle
import io

class RestrictedUnpickler(pickle.Unpickler):
    def find_class(self, module, name):
        # Only allow safe classes
        safe_classes = {
            'builtins': ['dict', 'list', 'tuple', 'str', 'int', 'float']
        }
        
        if module in safe_classes and name in safe_classes[module]:
            return super().find_class(module, name)
        
        raise pickle.UnpicklingError(f"Forbidden class: {module}.{name}")

def safe_deserialize(data):
    return RestrictedUnpickler(io.BytesIO(data)).load()
```

## 🔍 Vulnerable Code - JavaScript

```javascript
// VULNERABLE CODE - eval() for deserialization
function deserializeData(data) {
  return eval('(' + data + ')'); // Dangerous! Executes code
}

// Attack payload
const malicious = "alert('XSS'); ({malicious: true})";
deserializeData(malicious); // Executes alert!
```

### Secure Code - JavaScript

```javascript
// SECURE CODE - JSON.parse() (safe)
function deserializeData(data) {
  return JSON.parse(data); // Safe - no code execution
}

// SECURE CODE - Validate JSON structure
function safeDeserialize(data, schema) {
  const parsed = JSON.parse(data);
  
  // Validate against schema
  const ajv = new Ajv();
  const validate = ajv.compile(schema);
  
  if (!validate(parsed)) {
    throw new Error('Invalid data structure');
  }
  
  return parsed;
}

// Usage
const schema = {
  type: 'object',
  properties: {
    userId: { type: 'number' },
    name: { type: 'string' },
    email: { type: 'string', format: 'email' }
  },
  required: ['userId', 'name', 'email']
};

const data = safeDeserialize(jsonData, schema);
```

## 🔍 Java Deserialization

### Vulnerable Code - Java

```java
// VULNERABLE CODE - Java deserialization
import java.io.*;

public Object deserialize(byte[] data) throws Exception {
    ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(data));
    return ois.readObject(); // Dangerous! Can execute code
}
```

### Secure Code - Java

```java
// SECURE CODE - Use JSON or implement custom deserialization
import com.fasterxml.jackson.databind.ObjectMapper;

ObjectMapper mapper = new ObjectMapper();
MyObject obj = mapper.readValue(jsonData, MyObject.class); // Safe

// SECURE CODE - If ObjectInputStream is necessary
import java.io.*;

public class SecureObjectInputStream extends ObjectInputStream {
    private static final Set<String> ALLOWED_CLASSES = Set.of(
        "java.util.HashMap",
        "java.util.ArrayList",
        "com.myapp.SafeClass"
    );
    
    public SecureObjectInputStream(InputStream in) throws IOException {
        super(in);
        enableResolveObject(true);
    }
    
    @Override
    protected Class<?> resolveClass(ObjectStreamClass desc) 
        throws IOException, ClassNotFoundException {
        
        String className = desc.getName();
        
        if (!ALLOWED_CLASSES.contains(className)) {
            throw new SecurityException("Deserialization of class not allowed: " + className);
        }
        
        return super.resolveClass(desc);
    }
}
```

## 🔍 Object Injection

### Vulnerable Code

```javascript
// VULNERABLE CODE - Object injection
function deserializeUser(data) {
  const user = JSON.parse(data);
  
  // Directly use deserialized object
  if (user.isAdmin) { // Attacker can set isAdmin: true
    grantAdminAccess();
  }
  
  return user;
}

// Attack payload
const malicious = JSON.stringify({
  id: 1,
  username: 'attacker',
  isAdmin: true // Attacker sets this!
});
```

### Secure Code

```javascript
// SECURE CODE - Validate and reconstruct
function deserializeUser(data) {
  const parsed = JSON.parse(data);
  
  // Validate structure
  if (typeof parsed.id !== 'number' || typeof parsed.username !== 'string') {
    throw new Error('Invalid user data');
  }
  
  // Reconstruct object - don't trust deserialized properties
  const user = {
    id: parsed.id,
    username: parsed.username,
    // isAdmin is set from database, not from deserialized data
    isAdmin: false // Always false, set from database lookup
  };
  
  // Verify permissions from database
  const dbUser = await User.findById(user.id);
  if (dbUser) {
    user.isAdmin = dbUser.isAdmin; // Get from database
  }
  
  return user;
}
```

## 🔍 Denial of Service

### Vulnerable Code

```javascript
// VULNERABLE CODE - No size limits
function deserializeData(data) {
  const parsed = JSON.parse(data);
  
  // Process large nested objects
  processObject(parsed); // Can cause DoS with large objects
}

// Attack payload - Deeply nested object
const malicious = JSON.stringify({
  a: {
    b: {
      c: {
        // ... 10000 levels deep
      }
    }
  }
});
```

### Secure Code

```javascript
// SECURE CODE - Size and depth limits
function deserializeData(data) {
  // Check size
  if (data.length > 1000000) { // 1MB limit
    throw new Error('Data too large');
  }
  
  const parsed = JSON.parse(data);
  
  // Check depth
  function checkDepth(obj, maxDepth = 10, currentDepth = 0) {
    if (currentDepth > maxDepth) {
      throw new Error('Object too deeply nested');
    }
    
    if (typeof obj === 'object' && obj !== null) {
      for (const key in obj) {
        checkDepth(obj[key], maxDepth, currentDepth + 1);
      }
    }
  }
  
  checkDepth(parsed);
  
  return parsed;
}
```

## 🛡️ Prevention Strategies

### 1. Avoid Deserialization When Possible

```javascript
// Prefer explicit data structures
function processUserData(data) {
  // Instead of deserializing, use explicit parsing
  const userId = parseInt(data.userId, 10);
  const username = String(data.username);
  
  if (isNaN(userId) || !username) {
    throw new Error('Invalid data');
  }
  
  return { userId, username };
}
```

### 2. Use Safe Serialization Formats

```javascript
// Use JSON instead of binary formats
function serializeData(data) {
  return JSON.stringify(data); // Safe format
}

function deserializeData(jsonString) {
  return JSON.parse(jsonString); // Safe parsing
}

// Validate JSON structure
function safeDeserialize(jsonString, allowedKeys) {
  const parsed = JSON.parse(jsonString);
  
  // Only allow specific keys
  const filtered = {};
  for (const key of allowedKeys) {
    if (key in parsed) {
      filtered[key] = parsed[key];
    }
  }
  
  return filtered;
}
```

### 3. Implement Whitelisting

```javascript
// Whitelist allowed classes/types
const ALLOWED_TYPES = {
  User: ['id', 'username', 'email'],
  Order: ['id', 'userId', 'total', 'items']
};

function deserializeData(data, type) {
  const parsed = JSON.parse(data);
  
  if (!ALLOWED_TYPES[type]) {
    throw new Error(`Unknown type: ${type}`);
  }
  
  const allowedKeys = ALLOWED_TYPES[type];
  const filtered = {};
  
  for (const key of allowedKeys) {
    if (key in parsed) {
      filtered[key] = parsed[key];
    }
  }
  
  return filtered;
}
```

### 4. Digital Signatures

```javascript
// Sign serialized data
const crypto = require('crypto');

function serializeAndSign(data) {
  const serialized = JSON.stringify(data);
  const signature = crypto
    .createHmac('sha256', process.env.SECRET_KEY)
    .update(serialized)
    .digest('hex');
  
  return {
    data: serialized,
    signature: signature
  };
}

function deserializeAndVerify(signedData) {
  const expectedSignature = crypto
    .createHmac('sha256', process.env.SECRET_KEY)
    .update(signedData.data)
    .digest('hex');
  
  if (expectedSignature !== signedData.signature) {
    throw new Error('Invalid signature');
  }
  
  return JSON.parse(signedData.data);
}
```

## 📊 Testing for Deserialization Vulnerabilities

```javascript
// Test deserialization security
async function testDeserialization() {
  const testCases = [
    // Test for code execution
    {
      input: '{"__proto__":{"isAdmin":true}}',
      expected: 'Should not allow prototype pollution'
    },
    // Test for DoS
    {
      input: JSON.stringify({ a: { b: { c: { /* deep nesting */ } } } }),
      expected: 'Should reject deeply nested objects'
    },
    // Test for type confusion
    {
      input: '{"id":"1","isAdmin":true}',
      expected: 'Should validate types'
    }
  ];
  
  for (const testCase of testCases) {
    try {
      const result = safeDeserialize(testCase.input);
      console.log('Test passed:', testCase.expected);
    } catch (error) {
      console.log('Test failed:', error.message);
    }
  }
}
```

## 🎯 Best Practices

1. **Avoid Deserialization**: Use explicit data structures when possible
2. **Safe Formats**: Use JSON instead of binary formats
3. **Input Validation**: Validate all deserialized data
4. **Whitelisting**: Only allow expected classes/types
5. **Digital Signatures**: Sign and verify serialized data
6. **Size Limits**: Enforce size and depth limits
7. **Isolation**: Deserialize in isolated environments

## 🎓 Learning Resources

- OWASP Deserialization: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Input_Validation_Testing/17-Testing_for_Deserialization
- Deserialization Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/Deserialization_Cheat_Sheet.html
- Python Pickle Security: https://docs.python.org/3/library/pickle.html#restricting-globals

---

**Next**: Learn about [Using Vulnerable Components](./USING-VULNERABLE-COMPONENTS.md)

