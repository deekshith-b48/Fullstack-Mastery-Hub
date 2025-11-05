# Network Firewalls

## 📚 Overview

Network firewalls protect entire networks by filtering traffic at the network boundary. They can be hardware appliances or software-based solutions.

## 🎯 Network Firewall Functions

### Core Functions

1. **Traffic Filtering**: Allow/deny based on rules
2. **Network Segmentation**: Isolate network segments
3. **Attack Prevention**: Block malicious traffic
4. **Logging**: Log all traffic for analysis

## 🔍 Firewall Deployment

### Perimeter Firewall

Protects network boundary:
```javascript
// Network topology
const networkConfig = {
  internet: {
    firewall: 'perimeter',
    rules: [
      { action: 'allow', protocol: 'tcp', port: 443 }, // HTTPS
      { action: 'allow', protocol: 'tcp', port: 80 },  // HTTP (redirects)
      { action: 'deny', protocol: 'tcp', port: 22 }    // SSH (use VPN)
    ]
  },
  dmz: {
    firewall: 'dmz',
    rules: [
      { action: 'allow', source: 'internet', destination: 'dmz', port: 443 },
      { action: 'deny', source: 'dmz', destination: 'internal' }
    ]
  },
  internal: {
    firewall: 'internal',
    rules: [
      { action: 'allow', source: 'internal', destination: 'internal' },
      { action: 'deny', source: 'external', destination: 'internal' }
    ]
  }
};
```

## 🔍 Firewall Rules

### Common Firewall Rules

```javascript
const firewallRules = {
  // Allow outbound HTTPS
  allowOutboundHTTPS: {
    direction: 'outbound',
    protocol: 'tcp',
    port: 443,
    action: 'allow'
  },
  
  // Allow inbound HTTPS
  allowInboundHTTPS: {
    direction: 'inbound',
    protocol: 'tcp',
    port: 443,
    action: 'allow'
  },
  
  // Block all inbound by default
  denyAllInbound: {
    direction: 'inbound',
    action: 'deny',
    priority: 1000
  },
  
  // Allow specific IP ranges
  allowInternalNetwork: {
    direction: 'inbound',
    source: '10.0.0.0/8',
    action: 'allow',
    priority: 100
  }
};
```

## 🔍 Firewall Management

### Rule Management

```javascript
class FirewallManager {
  constructor() {
    this.rules = [];
  }
  
  addRule(rule) {
    // Validate rule
    if (!this.validateRule(rule)) {
      throw new Error('Invalid firewall rule');
    }
    
    // Check for conflicts
    if (this.hasConflict(rule)) {
      throw new Error('Rule conflict detected');
    }
    
    this.rules.push(rule);
    this.applyRules();
  }
  
  removeRule(ruleId) {
    this.rules = this.rules.filter(r => r.id !== ruleId);
    this.applyRules();
  }
  
  validateRule(rule) {
    return rule.action && rule.protocol && rule.port;
  }
}
```

## 🛡️ Best Practices

1. **Default Deny**: Deny all by default
2. **Explicit Allow**: Allow only necessary traffic
3. **Network Segmentation**: Isolate network segments
4. **Regular Updates**: Update rules regularly
5. **Monitoring**: Monitor firewall logs
6. **Testing**: Test rules before deployment
7. **Documentation**: Document all rules

---

**Next**: Learn about [Web Application Firewalls](./WEB-APPLICATION-FIREWALLS.md)

