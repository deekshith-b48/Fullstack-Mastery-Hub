# Passwordless Authentication

## 📚 Overview

Passwordless authentication eliminates the need for passwords by using alternative authentication methods. This includes magic links, biometrics, hardware tokens, and one-time codes. Passwordless authentication improves security and user experience.

## 🎯 What is Passwordless Authentication?

Passwordless authentication verifies user identity without requiring a password. Instead, it uses possession-based factors (device, email, phone) or biometric factors (fingerprint, face).

### Passwordless Methods

1. **Magic Links**: Email-based one-click authentication
2. **SMS Codes**: Phone number verification
3. **Push Notifications**: Mobile app authentication
4. **Hardware Tokens**: Physical security keys
5. **Biometrics**: Fingerprint, face recognition

## 🔍 Magic Link Authentication

### Implementation

```javascript
// Magic link authentication
const crypto = require('crypto');

async function sendMagicLink(email) {
  // Generate secure token
  const token = crypto.randomBytes(32).toString('hex');
  const tokenHash = await bcrypt.hash(token, 10);
  
  // Store token with expiration
  await MagicLinkToken.create({
    email: email,
    token: tokenHash,
    expiresAt: Date.now() + 600000, // 10 minutes
    used: false
  });
  
  // Send email with magic link
  const magicLink = `https://example.com/auth/verify?token=${token}&email=${encodeURIComponent(email)}`;
  
  await sendEmail(email, {
    subject: 'Sign in to Your Account',
    body: `Click this link to sign in: ${magicLink}\n\nThis link expires in 10 minutes.`
  });
  
  return { success: true };
}

async function verifyMagicLink(token, email) {
  // Find token
  const tokens = await MagicLinkToken.find({
    email: email,
    expiresAt: { $gt: Date.now() },
    used: false
  });
  
  for (const tokenRecord of tokens) {
    const isValid = await bcrypt.compare(token, tokenRecord.token);
    
    if (isValid) {
      // Mark as used
      tokenRecord.used = true;
      await tokenRecord.save();
      
      // Find or create user
      let user = await User.findOne({ email });
      if (!user) {
        user = await User.create({
          email: email,
          emailVerified: true
        });
      }
      
      // Create session
      const session = await createSession(user.id);
      
      return { success: true, sessionId: session.id };
    }
  }
  
  throw new Error('Invalid or expired magic link');
}
```

## 🔍 SMS-Based Passwordless

```javascript
// SMS passwordless authentication
async function sendSMSCode(phoneNumber) {
  // Generate 6-digit code
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  const codeHash = await bcrypt.hash(code, 10);
  
  // Store code
  await PasswordlessCode.create({
    phoneNumber: phoneNumber,
    code: codeHash,
    expiresAt: Date.now() + 600000, // 10 minutes
    attempts: 0
  });
  
  // Send SMS
  await sendSMS(phoneNumber, `Your verification code is: ${code}`);
  
  return { success: true };
}

async function verifySMSCode(phoneNumber, code) {
  const codeRecord = await PasswordlessCode.findOne({
    phoneNumber: phoneNumber,
    expiresAt: { $gt: Date.now() },
    used: false
  }).sort({ createdAt: -1 });
  
  if (!codeRecord) {
    throw new Error('Invalid or expired code');
  }
  
  if (codeRecord.attempts >= 3) {
    throw new Error('Too many attempts');
  }
  
  const isValid = await bcrypt.compare(code, codeRecord.code);
  
  if (!isValid) {
    codeRecord.attempts++;
    await codeRecord.save();
    throw new Error('Invalid code');
  }
  
  // Mark as used
  codeRecord.used = true;
  await codeRecord.save();
  
  // Find or create user
  let user = await User.findOne({ phoneNumber });
  if (!user) {
    user = await User.create({
      phoneNumber: phoneNumber,
      phoneVerified: true
    });
  }
  
  const session = await createSession(user.id);
  return { success: true, sessionId: session.id };
}
```

## 🔍 Hardware Token (WebAuthn)

```javascript
// WebAuthn for passwordless authentication
const fido2 = require('@webauthn/server');

// Registration
async function registerWebAuthn(userId, deviceName) {
  const user = await User.findById(userId);
  
  const challenge = fido2.generateChallenge();
  
  // Store challenge
  await WebAuthnChallenge.create({
    userId: userId,
    challenge: challenge,
    expiresAt: Date.now() + 60000
  });
  
  const options = {
    challenge: challenge,
    rp: {
      name: 'MyApp',
      id: 'example.com'
    },
    user: {
      id: user.id,
      name: user.email,
      displayName: user.name
    },
    pubKeyCredParams: [
      { type: 'public-key', alg: -7 }, // ES256
      { type: 'public-key', alg: -257 } // RS256
    ],
    authenticatorSelection: {
      authenticatorAttachment: 'platform',
      userVerification: 'required'
    }
  };
  
  return options;
}

// Verification
async function verifyWebAuthn(userId, credential) {
  const challenge = await WebAuthnChallenge.findOne({
    userId: userId,
    expiresAt: { $gt: Date.now() }
  }).sort({ createdAt: -1 });
  
  if (!challenge) {
    throw new Error('Challenge expired');
  }
  
  // Verify credential
  const verification = await fido2.verifyAuthenticationResponse({
    credential: credential,
    expectedChallenge: challenge.challenge,
    expectedOrigin: 'https://example.com',
    expectedRPID: 'example.com'
  });
  
  if (verification.verified) {
    // Store credential
    await WebAuthnCredential.create({
      userId: userId,
      credentialId: credential.id,
      publicKey: credential.publicKey
    });
    
    // Delete challenge
    await WebAuthnChallenge.deleteOne({ _id: challenge._id });
    
    return true;
  }
  
  throw new Error('Verification failed');
}
```

## 🛡️ Best Practices

1. **Secure Tokens**: Use cryptographically secure tokens
2. **Short Expiration**: Set short expiration times (10 minutes)
3. **Rate Limiting**: Limit magic link/code requests
4. **One-Time Use**: Tokens should be single-use
5. **Monitoring**: Log all passwordless authentication attempts
6. **User Experience**: Provide clear instructions
7. **Fallback**: Offer alternative authentication methods

---

**Next**: Learn about [Authentication Best Practices](./AUTHENTICATION-BEST-PRACTICES.md)

