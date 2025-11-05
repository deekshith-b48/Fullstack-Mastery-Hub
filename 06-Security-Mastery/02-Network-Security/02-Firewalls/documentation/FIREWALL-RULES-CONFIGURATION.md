# Firewall Rules Configuration

## 📚 Overview

Firewall rules define what traffic is allowed or denied. Proper rule configuration is critical for network security while maintaining necessary functionality.

## 🎯 Rule Configuration Principles

### Configuration Principles

1. **Default Deny**: Deny all by default
2. **Explicit Allow**: Allow only necessary traffic
3. **Least Privilege**: Minimum necessary permissions
4. **Regular Review**: Review rules regularly

## 🔍 Rule Structure

### Standard Rule Format

```javascript
const firewallRule = {
  id: 'rule-001',
  name: 'Allow HTTPS',
  action: 'allow', // allow | deny | reject
  protocol: 'tcp', // tcp | udp | icmp | all
  source: {
    address: '0.0.0.0/0', // Any
    port: 'any'
  },
  destination: {
    address: '10.0.0.1',
    port: 443
  },
  direction: 'inbound', // inbound | outbound
  priority: 100,
  enabled: true
};
```

## 🔍 Rule Configuration Examples

### Common Rules

```javascript
const commonRules = [
  // Allow outbound HTTPS
  {
    name: 'Allow Outbound HTTPS',
    action: 'allow',
    protocol: 'tcp',
    direction: 'outbound',
    destination: { port: 443 }
  },
  
  // Allow inbound HTTPS
  {
    name: 'Allow Inbound HTTPS',
    action: 'allow',
    protocol: 'tcp',
    direction: 'inbound',
    destination: { port: 443 }
  },
  
  // Allow SSH from specific network
  {
    name: 'Allow SSH from Internal',
    action: 'allow',
    protocol: 'tcp',
    direction: 'inbound',
    source: { address: '10.0.0.0/8' },
    destination: { port: 22 }
  },
  
  // Deny all other inbound
  {
    name: 'Deny All Inbound',
    action: 'deny',
    direction: 'inbound',
    priority: 1000
  }
];
```

## 🔍 Rule Validation

### Validate Rules

```javascript
function validateFirewallRule(rule) {
  const errors = [];
  
  if (!rule.action || !['allow', 'deny', 'reject'].includes(rule.action)) {
    errors.push('Invalid action');
  }
  
  if (!rule.direction || !['inbound', 'outbound'].includes(rule.direction)) {
    errors.push('Invalid direction');
  }
  
  if (rule.protocol && !['tcp', 'udp', 'icmp', 'all'].includes(rule.protocol)) {
    errors.push('Invalid protocol');
  }
  
  if (rule.source && !isValidIP(rule.source.address)) {
    errors.push('Invalid source address');
  }
  
  if (rule.destination && !isValidIP(rule.destination.address)) {
    errors.push('Invalid destination address');
  }
  
  return {
    valid: errors.length === 0,
    errors: errors
  };
}
```

## 🔍 Rule Management

### Rule CRUD Operations

```javascript
class FirewallRuleManager {
  constructor() {
    this.rules = [];
  }
  
  addRule(rule) {
    const validation = validateFirewallRule(rule);
    if (!validation.valid) {
      throw new Error(`Invalid rule: ${validation.errors.join(', ')}`);
    }
    
    // Check for conflicts
    if (this.hasConflict(rule)) {
      throw new Error('Rule conflicts with existing rule');
    }
    
    this.rules.push({ ...rule, id: this.generateId() });
    this.sortRules();
  }
  
  removeRule(ruleId) {
    this.rules = this.rules.filter(r => r.id !== ruleId);
  }
  
  updateRule(ruleId, updates) {
    const index = this.rules.findIndex(r => r.id === ruleId);
    if (index === -1) {
      throw new Error('Rule not found');
    }
    
    this.rules[index] = { ...this.rules[index], ...updates };
    this.sortRules();
  }
  
  sortRules() {
    this.rules.sort((a, b) => (a.priority || 1000) - (b.priority || 1000));
  }
}
```

## 🛡️ Best Practices

1. **Document Rules**: Document purpose of each rule
2. **Test Rules**: Test before deploying
3. **Review Regularly**: Review rules quarterly
4. **Minimize Rules**: Keep rules minimal
5. **Use Groups**: Group related rules
6. **Monitor**: Monitor rule effectiveness
7. **Version Control**: Track rule changes

---

**Next**: Learn about [Cloud Firewalls](./CLOUD-FIREWALLS.md)

