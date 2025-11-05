# Penetration Testing Methodologies

## 📚 Overview

Penetration testing methodologies provide structured approaches to security testing. Following established methodologies ensures comprehensive and consistent testing.

## 🎯 Common Methodologies

### 1. OWASP Testing Guide

Web application focus:
- Information gathering
- Configuration testing
- Authentication testing
- Authorization testing
- Input validation
- Error handling

### 2. PTES (Penetration Testing Execution Standard)

Comprehensive standard:
- Pre-engagement
- Intelligence gathering
- Threat modeling
- Vulnerability analysis
- Exploitation
- Post-exploitation
- Reporting

### 3. NIST SP 800-115

NIST methodology:
- Planning
- Discovery
- Attack
- Reporting

## 🔍 OWASP Methodology

### Testing Phases

```javascript
// OWASP testing phases
const owaspPhases = {
  informationGathering: [
    'fingerprinting',
    'enumeration',
    'configuration_analysis'
  ],
  authentication: [
    'login_testing',
    'password_policy',
    'session_management'
  ],
  authorization: [
    'access_control',
    'privilege_escalation',
    'horizontal_vertical'
  ],
  inputValidation: [
    'sql_injection',
    'xss',
    'command_injection'
  ]
};
```

## 🔍 PTES Methodology

### PTES Phases

```javascript
// PTES methodology
const ptesPhases = {
  preEngagement: {
    scope: 'define_scope',
    rules: 'establish_rules',
    authorization: 'obtain_authorization'
  },
  intelligenceGathering: {
    passive: 'passive_recon',
    active: 'active_recon',
    social: 'social_engineering'
  },
  threatModeling: {
    assets: 'identify_assets',
    threats: 'identify_threats',
    vulnerabilities: 'identify_vulnerabilities'
  },
  vulnerabilityAnalysis: {
    scanning: 'vulnerability_scanning',
    analysis: 'vulnerability_analysis',
    validation: 'validate_findings'
  },
  exploitation: {
    exploit: 'attempt_exploitation',
    postExploit: 'post_exploitation',
    persistence: 'test_persistence'
  }
};
```

## 🛡️ Best Practices

1. **Choose Methodology**: Select appropriate methodology
2. **Follow Structure**: Follow methodology structure
3. **Documentation**: Document all steps
4. **Consistency**: Consistent approach
5. **Comprehensive**: Cover all areas
6. **Reporting**: Standard reporting format
7. **Continuous**: Regular testing

---

**Next**: Learn about [Web Application Pen Testing](./WEB-APPLICATION-PEN-TESTING.md)

