# API Input Validation

## 📚 Overview

Validating API input prevents security vulnerabilities.

## ✅ Validation Libraries

### Express Validator

```javascript
const { body, param, query } = require('express-validator');

app.post('/users',
  body('email').isEmail().normalizeEmail(),
  body('age').isInt({ min: 0, max: 120 }),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process request
  }
);
```

### Joi

```javascript
const Joi = require('joi');

const schema = Joi.object({
  email: Joi.string().email().required(),
  age: Joi.number().integer().min(0).max(120).required(),
  password: Joi.string().min(8).required()
});

const { error, value } = schema.validate(req.body);
if (error) {
  return res.status(400).json({ error: error.details });
}
```

---

**Next**: Learn about [SQL Injection Prevention](./SQL-INJECTION-PREVENTION.md)

