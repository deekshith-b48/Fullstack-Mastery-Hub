# API Versioning

## 📚 Overview

API versioning allows evolution without breaking existing clients.

## 🎯 Versioning Strategies

### URL Versioning

```javascript
/api/v1/users
/api/v2/users
```

### Header Versioning

```javascript
Accept: application/vnd.api+json;version=1
```

### Query Parameter

```javascript
/api/users?version=1
```

## 📝 Best Practices

```javascript
// ✅ URL versioning is most common
app.use('/api/v1', v1Routes);
app.use('/api/v2', v2Routes);

// Maintain backward compatibility
// Deprecate old versions gradually
```

---

**Next**: Learn about [Documentation Standards](./DOCUMENTATION-STANDARDS.md)

