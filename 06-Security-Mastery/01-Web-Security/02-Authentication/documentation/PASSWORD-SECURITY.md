# Password Security

## 📚 Overview

Password security is fundamental to application security. Weak passwords are a primary attack vector, and improper password handling can lead to account compromise, data breaches, and unauthorized access. This guide covers comprehensive password security practices.

## 🎯 Password Security Fundamentals

Passwords are the most common authentication mechanism. Ensuring password security involves proper storage, validation, policies, and user education.

### Password Security Principles

1. **Strong Password Policies**: Enforce complexity requirements
2. **Secure Storage**: Use strong hashing algorithms
3. **Password Validation**: Validate passwords properly
4. **Breach Detection**: Check against breached passwords
5. **Password Reset**: Secure password recovery
6. **Password History**: Prevent password reuse

## 🔍 Password Storage

### Vulnerable Password Storage

```javascript
// VULNERABLE CODE - Plain text storage
function storePassword(userId, password) {
  db.users.update({ id: userId }, { password: password }); // NEVER!
}

// VULNERABLE CODE - Weak hashing (MD5, SHA1)
const crypto = require('crypto');
function hashPassword(password) {
  return crypto.createHash('md5').update(password).digest('hex'); // Weak!
}

// VULNERABLE CODE - No salt
function hashPassword(password) {
  return crypto.createHash('sha256').update(password).digest('hex'); // No salt!
}
```

### Secure Password Storage

```javascript
// SECURE CODE - bcrypt (recommended)
const bcrypt = require('bcrypt');

async function hashPassword(password) {
  const saltRounds = 12; // Cost factor (10-12 recommended)
  const hashed = await bcrypt.hash(password, saltRounds);
  return hashed;
}

async function verifyPassword(password, hashedPassword) {
  return await bcrypt.compare(password, hashedPassword);
}

// SECURE CODE - Argon2 (even better)
const argon2 = require('argon2');

async function hashPassword(password) {
  return await argon2.hash(password, {
    type: argon2.argon2id, // Best for most use cases
    memoryCost: 65536, // 64 MB
    timeCost: 3, // Number of iterations
    parallelism: 4 // Number of threads
  });
}

async function verifyPassword(hashedPassword, password) {
  return await argon2.verify(hashedPassword, password);
}

// SECURE CODE - scrypt
const crypto = require('crypto');

function hashPassword(password) {
  const salt = crypto.randomBytes(16);
  const hash = crypto.scryptSync(password, salt, 64, {
    N: 16384, // CPU/memory cost
    r: 8, // Block size
    p: 1 // Parallelization
  });
  
  return salt.toString('hex') + ':' + hash.toString('hex');
}

function verifyPassword(password, hashedPassword) {
  const [salt, hash] = hashedPassword.split(':');
  const hashBuffer = crypto.scryptSync(password, Buffer.from(salt, 'hex'), 64, {
    N: 16384,
    r: 8,
    p: 1
  });
  
  return crypto.timingSafeEqual(Buffer.from(hash, 'hex'), hashBuffer);
}
```

## 🔍 Password Policies

### Strong Password Requirements

```javascript
// SECURE CODE - Comprehensive password validation
function validatePassword(password) {
  const errors = [];
  
  // Length requirement
  if (password.length < 12) {
    errors.push('Password must be at least 12 characters long');
  }
  
  if (password.length > 128) {
    errors.push('Password must be less than 128 characters');
  }
  
  // Character requirements
  if (!/[a-z]/.test(password)) {
    errors.push('Password must contain at least one lowercase letter');
  }
  
  if (!/[A-Z]/.test(password)) {
    errors.push('Password must contain at least one uppercase letter');
  }
  
  if (!/\d/.test(password)) {
    errors.push('Password must contain at least one number');
  }
  
  if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
    errors.push('Password must contain at least one special character');
  }
  
  // Common password check
  const commonPasswords = [
    'password', '123456', 'qwerty', 'admin', 'letmein',
    'welcome', 'monkey', '1234567890', 'password123'
  ];
  
  if (commonPasswords.includes(password.toLowerCase())) {
    errors.push('Password is too common');
  }
  
  // Pattern check
  if (/(.)\1{3,}/.test(password)) {
    errors.push('Password cannot contain repeated characters');
  }
  
  // Sequential characters
  if (/12345|abcde|qwerty/i.test(password)) {
    errors.push('Password cannot contain sequential characters');
  }
  
  // Dictionary words
  if (isDictionaryWord(password)) {
    errors.push('Password cannot be a dictionary word');
  }
  
  // Breached password check
  if (isBreachedPassword(password)) {
    errors.push('Password has been found in data breaches');
  }
  
  if (errors.length > 0) {
    throw new Error(errors.join('. '));
  }
  
  return true;
}

// Check against breached passwords
const haveibeenpwned = require('hibp');

async function isBreachedPassword(password) {
  try {
    const hash = crypto.createHash('sha1').update(password).digest('hex').toUpperCase();
    const prefix = hash.substring(0, 5);
    const suffix = hash.substring(5);
    
    const response = await fetch(`https://api.pwnedpasswords.com/range/${prefix}`);
    const hashes = await response.text();
    
    return hashes.includes(suffix);
  } catch (error) {
    // If API fails, allow password but log error
    logger.error('Breached password check failed', error);
    return false;
  }
}
```

## 🔍 Password Strength Meter

```javascript
// Password strength calculation
function calculatePasswordStrength(password) {
  let strength = 0;
  
  // Length bonus
  if (password.length >= 12) strength += 2;
  if (password.length >= 16) strength += 1;
  if (password.length >= 20) strength += 1;
  
  // Character variety
  if (/[a-z]/.test(password)) strength += 1;
  if (/[A-Z]/.test(password)) strength += 1;
  if (/\d/.test(password)) strength += 1;
  if (/[^a-zA-Z0-9]/.test(password)) strength += 2;
  
  // Complexity bonus
  const uniqueChars = new Set(password).size;
  if (uniqueChars >= password.length * 0.7) strength += 1;
  
  // Penalties
  if (/(.)\1{2,}/.test(password)) strength -= 1; // Repeated characters
  if (/12345|abcde|qwerty/i.test(password)) strength -= 2; // Sequences
  if (isDictionaryWord(password)) strength -= 2; // Dictionary words
  
  return Math.max(0, Math.min(10, strength));
}

function getPasswordStrengthLabel(strength) {
  if (strength < 3) return { label: 'Very Weak', color: 'red' };
  if (strength < 5) return { label: 'Weak', color: 'orange' };
  if (strength < 7) return { label: 'Fair', color: 'yellow' };
  if (strength < 9) return { label: 'Good', color: 'lightgreen' };
  return { label: 'Strong', color: 'green' };
}
```

## 🔍 Password Reset

### Secure Password Reset

```javascript
// Secure password reset flow
const crypto = require('crypto');

async function requestPasswordReset(email) {
  const user = await User.findOne({ email });
  
  // Don't reveal if user exists
  if (!user) {
    // Return success to prevent user enumeration
    return { success: true, message: 'If the email exists, a reset link will be sent' };
  }
  
  // Generate secure reset token
  const resetToken = crypto.randomBytes(32).toString('hex');
  const resetHash = await bcrypt.hash(resetToken, 10);
  
  // Store reset token with expiration
  await User.updateOne(
    { email },
    {
      resetToken: resetHash,
      resetTokenExpiry: Date.now() + 3600000, // 1 hour
      resetTokenUsed: false
    }
  );
  
  // Send reset email
  const resetLink = `https://example.com/reset-password?token=${resetToken}`;
  await sendEmail(email, {
    subject: 'Password Reset Request',
    body: `
      You requested a password reset. Click the link below to reset your password:
      ${resetLink}
      
      This link expires in 1 hour.
      If you didn't request this, please ignore this email.
    `
  });
  
  // Log security event
  await logSecurityEvent({
    type: 'password_reset_requested',
    userId: user.id,
    email,
    ipAddress: req.ip,
    timestamp: Date.now()
  });
  
  return { success: true };
}

async function resetPassword(token, newPassword) {
  // Find user with valid reset token
  const users = await User.find({
    resetTokenExpiry: { $gt: Date.now() },
    resetTokenUsed: false
  });
  
  for (const user of users) {
    const isValid = await bcrypt.compare(token, user.resetToken);
    
    if (isValid) {
      // Validate new password
      validatePassword(newPassword);
      
      // Check password history
      if (await isPasswordInHistory(user.id, newPassword)) {
        throw new Error('Password has been used recently. Please choose a different password.');
      }
      
      // Hash new password
      const hashedPassword = await hashPassword(newPassword);
      
      // Update password
      await User.updateOne(
        { id: user.id },
        {
          password: hashedPassword,
          resetToken: null,
          resetTokenExpiry: null,
          resetTokenUsed: true,
          passwordChangedAt: Date.now(),
          lastPasswordChange: Date.now()
        }
      );
      
      // Add to password history
      await addToPasswordHistory(user.id, hashedPassword);
      
      // Invalidate all sessions
      await invalidateUserSessions(user.id);
      
      // Log security event
      await logSecurityEvent({
        type: 'password_reset_successful',
        userId: user.id,
        ipAddress: req.ip,
        timestamp: Date.now()
      });
      
      // Send notification
      await sendEmail(user.email, {
        subject: 'Password Changed',
        body: 'Your password has been successfully changed. If you didn't make this change, please contact support immediately.'
      });
      
      return { success: true };
    }
  }
  
  throw new Error('Invalid or expired reset token');
}
```

## 🔍 Password History

### Preventing Password Reuse

```javascript
// Password history management
async function addToPasswordHistory(userId, hashedPassword) {
  await PasswordHistory.create({
    userId,
    passwordHash: hashedPassword,
    createdAt: Date.now()
  });
  
  // Keep only last 10 passwords
  const history = await PasswordHistory.find({ userId })
    .sort({ createdAt: -1 })
    .limit(10);
  
  const toKeep = history.slice(0, 10);
  const toDelete = history.slice(10);
  
  if (toDelete.length > 0) {
    await PasswordHistory.deleteMany({
      _id: { $in: toDelete.map(h => h._id) }
    });
  }
}

async function isPasswordInHistory(userId, password) {
  const history = await PasswordHistory.find({ userId })
    .sort({ createdAt: -1 })
    .limit(10);
  
  for (const entry of history) {
    const matches = await bcrypt.compare(password, entry.passwordHash);
    if (matches) {
      return true;
    }
  }
  
  return false;
}

// Check during password change
app.post('/api/change-password', authenticate, async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  const userId = req.user.id;
  
  // Verify current password
  const user = await User.findById(userId);
  const isValid = await bcrypt.compare(currentPassword, user.password);
  
  if (!isValid) {
    return res.status(401).json({ error: 'Current password is incorrect' });
  }
  
  // Check password history
  if (await isPasswordInHistory(userId, newPassword)) {
    return res.status(400).json({ 
      error: 'Password has been used recently. Please choose a different password.' 
    });
  }
  
  // Validate new password
  validatePassword(newPassword);
  
  // Update password
  const hashedPassword = await hashPassword(newPassword);
  await User.updateOne({ id: userId }, { 
    password: hashedPassword,
    passwordChangedAt: Date.now()
  });
  
  // Add to history
  await addToPasswordHistory(userId, hashedPassword);
  
  res.json({ success: true });
});
```

## 🔍 Password Expiration

### Implementing Password Expiration

```javascript
// Password expiration policy
const PASSWORD_MAX_AGE = 90 * 24 * 60 * 60 * 1000; // 90 days

async function checkPasswordExpiration(userId) {
  const user = await User.findById(userId);
  
  if (!user.passwordChangedAt) {
    // First-time password, require change
    return { expired: true, daysUntilExpiry: 0 };
  }
  
  const age = Date.now() - user.passwordChangedAt;
  const daysUntilExpiry = Math.ceil((PASSWORD_MAX_AGE - age) / (24 * 60 * 60 * 1000));
  
  if (age > PASSWORD_MAX_AGE) {
    return { expired: true, daysUntilExpiry: 0 };
  }
  
  // Warn if expiring soon
  if (daysUntilExpiry <= 7) {
    return { expired: false, daysUntilExpiry, warning: true };
  }
  
  return { expired: false, daysUntilExpiry };
}

// Middleware to check password expiration
async function checkPasswordExpired(req, res, next) {
  const expiration = await checkPasswordExpiration(req.user.id);
  
  if (expiration.expired) {
    return res.status(403).json({
      error: 'Password expired. Please change your password.',
      requiresPasswordChange: true
    });
  }
  
  if (expiration.warning) {
    res.setHeader('X-Password-Expires-In', expiration.daysUntilExpiry);
  }
  
  next();
}
```

## 🛡️ Password Security Best Practices

### 1. Storage

- Use bcrypt, Argon2, or scrypt
- Never store passwords in plain text
- Use appropriate cost factors
- Store salts securely

### 2. Validation

- Enforce strong password policies
- Check against breached passwords
- Prevent common passwords
- Validate password strength

### 3. User Education

- Provide password strength indicators
- Explain password requirements
- Offer password generation tools
- Regular security reminders

### 4. Monitoring

- Log password changes
- Monitor for suspicious patterns
- Alert on multiple failed attempts
- Track password-related events

## 🎯 Best Practices

1. **Strong Hashing**: Use bcrypt, Argon2, or scrypt
2. **Password Policies**: Enforce complexity requirements
3. **Breach Detection**: Check against breached passwords
4. **Password History**: Prevent password reuse
5. **Secure Reset**: Implement secure password recovery
6. **Expiration**: Consider password expiration policies
7. **Monitoring**: Log and monitor password events

## 🎓 Learning Resources

- Password Storage: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- Password Policy: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
- Have I Been Pwned: https://haveibeenpwned.com/API/v3

---

**Next**: Learn about [Multi-Factor Authentication](./MULTI-FACTOR-AUTHENTICATION.md)

