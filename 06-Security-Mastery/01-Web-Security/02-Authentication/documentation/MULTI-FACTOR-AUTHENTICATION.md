# Multi-Factor Authentication (MFA)

## 📚 Overview

Multi-Factor Authentication (MFA) adds an extra layer of security by requiring users to provide two or more authentication factors. This significantly reduces the risk of unauthorized access, even if passwords are compromised.

## 🎯 What is Multi-Factor Authentication?

MFA requires users to provide multiple proofs of identity before granting access. This typically combines something you know (password) with something you have (device, token) or something you are (biometric).

### MFA Factors

1. **Knowledge Factor**: Password, PIN, security question
2. **Possession Factor**: Phone, token, smart card
3. **Inherence Factor**: Fingerprint, face, voice
4. **Location Factor**: Geographic location
5. **Time Factor**: Time-based validation

### MFA Methods

- **TOTP**: Time-based One-Time Password (Google Authenticator, Authy)
- **SMS**: Text message codes
- **Email**: Email verification codes
- **Push Notifications**: Mobile app push
- **Hardware Tokens**: Physical security keys
- **Biometric**: Fingerprint, face recognition

## 🔍 TOTP Implementation

### Setting Up TOTP

```javascript
// TOTP setup and verification
const speakeasy = require('speakeasy');
const QRCode = require('qrcode');

// Generate secret and QR code
async function setupTOTP(userId, userEmail) {
  const secret = speakeasy.generateSecret({
    name: `MyApp (${userEmail})`,
    issuer: 'MyApp',
    length: 32
  });
  
  // Store secret temporarily (user needs to verify)
  await TempMFA.create({
    userId,
    secret: secret.base32,
    createdAt: Date.now()
  });
  
  // Generate QR code
  const qrCodeUrl = await QRCode.toDataURL(secret.otpauth_url);
  
  return {
    secret: secret.base32,
    qrCode: qrCodeUrl,
    manualEntryKey: secret.base32
  };
}

// Verify TOTP setup
async function verifyTOTPSetup(userId, token) {
  const tempMFA = await TempMFA.findOne({ userId });
  if (!tempMFA) {
    throw new Error('No MFA setup in progress');
  }
  
  // Check if expired (10 minutes)
  if (Date.now() - tempMFA.createdAt > 600000) {
    await TempMFA.deleteOne({ userId });
    throw new Error('MFA setup expired. Please start again.');
  }
  
  // Verify token
  const verified = speakeasy.totp.verify({
    secret: tempMFA.secret,
    encoding: 'base32',
    token: token,
    window: 2 // Allow 2 time steps tolerance
  });
  
  if (verified) {
    // Save MFA secret
    await User.updateOne(
      { id: userId },
      {
        mfaEnabled: true,
        mfaSecret: tempMFA.secret,
        mfaType: 'totp'
      }
    );
    
    // Delete temporary secret
    await TempMFA.deleteOne({ userId });
    
    // Generate backup codes
    const backupCodes = await generateBackupCodes(userId);
    
    return {
      success: true,
      backupCodes: backupCodes
    };
  }
  
  throw new Error('Invalid verification code');
}

// Verify TOTP during login
async function verifyTOTP(userId, token) {
  const user = await User.findById(userId);
  
  if (!user.mfaEnabled || !user.mfaSecret) {
    throw new Error('MFA not enabled');
  }
  
  const verified = speakeasy.totp.verify({
    secret: user.mfaSecret,
    encoding: 'base32',
    token: token,
    window: 2
  });
  
  if (!verified) {
    // Log failed MFA attempt
    await logSecurityEvent({
      type: 'mfa_failure',
      userId,
      timestamp: Date.now()
    });
    
    throw new Error('Invalid verification code');
  }
  
  // Log successful MFA
  await logSecurityEvent({
    type: 'mfa_success',
    userId,
    timestamp: Date.now()
  });
  
  return true;
}
```

## 🔍 SMS-Based MFA

### SMS MFA Implementation

```javascript
// SMS-based MFA
const twilio = require('twilio');
const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

async function sendSMSMFA(userId, phoneNumber) {
  // Generate 6-digit code
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  
  // Store code with expiration
  await MFACode.create({
    userId,
    code: await bcrypt.hash(code, 10), // Hash code
    phoneNumber,
    expiresAt: Date.now() + 600000, // 10 minutes
    attempts: 0
  });
  
  // Send SMS
  await client.messages.create({
    body: `Your verification code is: ${code}. Valid for 10 minutes.`,
    to: phoneNumber,
    from: process.env.TWILIO_PHONE_NUMBER
  });
  
  // Log SMS sent
  await logSecurityEvent({
    type: 'mfa_sms_sent',
    userId,
    phoneNumber: maskPhoneNumber(phoneNumber),
    timestamp: Date.now()
  });
}

async function verifySMSMFA(userId, code) {
  const mfaCode = await MFACode.findOne({
    userId,
    expiresAt: { $gt: Date.now() },
    used: false
  }).sort({ createdAt: -1 });
  
  if (!mfaCode) {
    throw new Error('Invalid or expired code');
  }
  
  // Check attempts
  if (mfaCode.attempts >= 3) {
    throw new Error('Too many failed attempts. Please request a new code.');
  }
  
  // Verify code
  const isValid = await bcrypt.compare(code, mfaCode.code);
  
  if (!isValid) {
    mfaCode.attempts++;
    await mfaCode.save();
    throw new Error('Invalid code');
  }
  
  // Mark as used
  mfaCode.used = true;
  await mfaCode.save();
  
  return true;
}
```

## 🔍 Email-Based MFA

### Email MFA Implementation

```javascript
// Email-based MFA
async function sendEmailMFA(userId, email) {
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  
  await MFACode.create({
    userId,
    code: await bcrypt.hash(code, 10),
    email,
    expiresAt: Date.now() + 600000, // 10 minutes
    attempts: 0
  });
  
  await sendEmail(email, {
    subject: 'Your Verification Code',
    body: `
      Your verification code is: ${code}
      This code is valid for 10 minutes.
      If you didn't request this, please ignore this email.
    `
  });
}

async function verifyEmailMFA(userId, code) {
  const mfaCode = await MFACode.findOne({
    userId,
    expiresAt: { $gt: Date.now() },
    used: false
  }).sort({ createdAt: -1 });
  
  if (!mfaCode) {
    throw new Error('Invalid or expired code');
  }
  
  if (mfaCode.attempts >= 3) {
    throw new Error('Too many failed attempts');
  }
  
  const isValid = await bcrypt.compare(code, mfaCode.code);
  
  if (!isValid) {
    mfaCode.attempts++;
    await mfaCode.save();
    throw new Error('Invalid code');
  }
  
  mfaCode.used = true;
  await mfaCode.save();
  
  return true;
}
```

## 🔍 Backup Codes

### Generating Backup Codes

```javascript
// Generate backup codes for MFA
async function generateBackupCodes(userId) {
  const codes = [];
  
  for (let i = 0; i < 10; i++) {
    const code = crypto.randomBytes(4).toString('hex').toUpperCase();
    codes.push(code);
    
    await BackupCode.create({
      userId,
      code: await bcrypt.hash(code, 10),
      used: false,
      createdAt: Date.now()
    });
  }
  
  return codes;
}

// Verify backup code
async function verifyBackupCode(userId, code) {
  const backupCodes = await BackupCode.find({
    userId,
    used: false
  });
  
  for (const backupCode of backupCodes) {
    const isValid = await bcrypt.compare(code, backupCode.code);
    
    if (isValid) {
      backupCode.used = true;
      await backupCode.save();
      
      // Log backup code usage
      await logSecurityEvent({
        type: 'backup_code_used',
        userId,
        timestamp: Date.now()
      });
      
      return true;
    }
  }
  
  throw new Error('Invalid backup code');
}
```

## 🔍 Login Flow with MFA

```javascript
// Complete login flow with MFA
app.post('/api/login', rateLimit({ windowMs: 15 * 60 * 1000, max: 5 }), async (req, res) => {
  const { username, password, mfaCode } = req.body;
  
  // Step 1: Verify username and password
  const user = await User.findOne({ username });
  const isValid = user && await bcrypt.compare(password, user.password);
  
  if (!isValid) {
    await logSecurityEvent({
      type: 'login_failure',
      username,
      ipAddress: req.ip,
      timestamp: Date.now()
    });
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Step 2: Check if MFA is enabled
  if (user.mfaEnabled) {
    if (!mfaCode) {
      // Return MFA required
      const tempToken = generateTempToken(user.id);
      return res.json({
        mfaRequired: true,
        tempToken: tempToken,
        mfaType: user.mfaType
      });
    }
    
    // Step 3: Verify MFA code
    try {
      if (user.mfaType === 'totp') {
        await verifyTOTP(user.id, mfaCode);
      } else if (user.mfaType === 'sms') {
        await verifySMSMFA(user.id, mfaCode);
      } else if (user.mfaType === 'email') {
        await verifyEmailMFA(user.id, mfaCode);
      } else if (user.mfaType === 'backup') {
        await verifyBackupCode(user.id, mfaCode);
      } else {
        throw new Error('Unknown MFA type');
      }
    } catch (error) {
      return res.status(401).json({ error: error.message });
    }
  }
  
  // Step 4: Create session
  const session = await createSession(user.id);
  
  // Step 5: Log successful login
  await logSecurityEvent({
    type: 'login_success',
    userId: user.id,
    mfaUsed: user.mfaEnabled,
    ipAddress: req.ip,
    timestamp: Date.now()
  });
  
  res.json({
    success: true,
    sessionId: session.id,
    user: {
      id: user.id,
      username: user.username
    }
  });
});
```

## 🔍 MFA Recovery

### MFA Recovery Flow

```javascript
// MFA recovery when device is lost
app.post('/api/mfa/recover', async (req, res) => {
  const { email, backupCode } = req.body;
  
  const user = await User.findOne({ email });
  if (!user || !user.mfaEnabled) {
    return res.status(404).json({ error: 'User not found or MFA not enabled' });
  }
  
  // Verify backup code
  const isValid = await verifyBackupCode(user.id, backupCode);
  
  if (!isValid) {
    return res.status(401).json({ error: 'Invalid backup code' });
  }
  
  // Disable MFA temporarily
  await User.updateOne(
    { id: user.id },
    { mfaEnabled: false, mfaRecoveryMode: true }
  );
  
  // Send recovery email with instructions
  await sendEmail(user.email, {
    subject: 'MFA Recovery',
    body: 'Your MFA has been disabled. Please set it up again from your account settings.'
  });
  
  // Log recovery
  await logSecurityEvent({
    type: 'mfa_recovery',
    userId: user.id,
    ipAddress: req.ip,
    timestamp: Date.now()
  });
  
  res.json({ success: true });
});
```

## 🛡️ MFA Best Practices

### 1. Enable MFA for Sensitive Accounts

- Admin accounts
- Financial accounts
- Accounts with elevated privileges
- Accounts accessing sensitive data

### 2. Multiple MFA Options

- Provide TOTP and SMS options
- Allow backup codes
- Support hardware tokens
- Consider biometric authentication

### 3. User Experience

- Clear setup instructions
- QR code for easy setup
- Backup code storage instructions
- Recovery process documentation

### 4. Security

- Rate limit MFA attempts
- Expire codes quickly
- Monitor for suspicious patterns
- Log all MFA events

## 🎯 Best Practices

1. **Enable MFA**: Require MFA for sensitive accounts
2. **Multiple Methods**: Provide multiple MFA options
3. **Backup Codes**: Generate and securely store backup codes
4. **Rate Limiting**: Limit MFA verification attempts
5. **Monitoring**: Monitor MFA usage and failures
6. **Recovery**: Provide secure recovery mechanisms
7. **User Education**: Educate users on MFA importance

## 🎓 Learning Resources

- MFA Implementation: https://cheatsheetseries.owasp.org/cheatsheets/Multifactor_Authentication_Cheat_Sheet.html
- TOTP: https://tools.ietf.org/html/rfc6238
- MFA Best Practices: https://www.nist.gov/publications/guidelines-multi-factor-authentication

---

**Next**: Learn about [OAuth2 and OpenID Connect](./OAUTH2-OPENID-CONNECT.md)

