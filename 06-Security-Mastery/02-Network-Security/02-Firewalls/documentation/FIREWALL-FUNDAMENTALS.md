# Firewall Fundamentals

## 📚 Overview

Firewalls are network security devices that monitor and control incoming and outgoing network traffic based on security rules. They act as barriers between trusted and untrusted networks.

## 🎯 What is a Firewall?

A firewall filters network traffic based on predefined rules, allowing or blocking connections based on source, destination, port, and protocol.

## 🔍 Firewall Types

### 1. Network Firewall

Hardware or software that filters traffic between networks:
- Protects entire network
- Filters at network layer
- Can be hardware or software

### 2. Host-Based Firewall

Software firewall on individual devices:
- Protects single device
- More granular control
- Application-aware

### 3. Web Application Firewall (WAF)

Protects web applications:
- Application-layer filtering
- Protects against web attacks
- Can be cloud or on-premise

## 🔍 Firewall Rules

### Basic Rule Structure

```javascript
// Firewall rule example
const firewallRule = {
  action: 'allow', // or 'deny'
  protocol: 'tcp',
  source: '192.168.1.0/24',
  destination: '10.0.0.1',
  port: 443,
  direction: 'inbound'
};
```

### Rule Priority

```javascript
// Rules processed in order
const firewallRules = [
  // Rule 1: Deny all by default
  { action: 'deny', priority: 1000 },
  
  // Rule 2: Allow HTTPS
  { action: 'allow', protocol: 'tcp', port: 443, priority: 100 },
  
  // Rule 3: Allow SSH from specific IP
  { action: 'allow', protocol: 'tcp', port: 22, source: '10.0.0.0/8', priority: 50 },
  
  // Rule 4: Block specific IP
  { action: 'deny', source: '192.168.1.100', priority: 10 }
];

// Process rules in priority order
function processFirewallRules(packet) {
  const sortedRules = firewallRules.sort((a, b) => a.priority - b.priority);
  
  for (const rule of sortedRules) {
    if (matchesRule(packet, rule)) {
      return rule.action;
    }
  }
  
  return 'deny'; // Default deny
}
```

## 🔍 Firewall Configuration

### Stateful Firewall

Tracks connection state:
```javascript
class StatefulFirewall {
  constructor() {
    this.connections = new Map();
  }
  
  processPacket(packet) {
    // Check if part of existing connection
    const connectionKey = this.getConnectionKey(packet);
    const connection = this.connections.get(connectionKey);
    
    if (connection) {
      // Allow established connections
      return 'allow';
    }
    
    // New connection - check rules
    if (this.allowsConnection(packet)) {
      this.connections.set(connectionKey, {
        state: 'established',
        timestamp: Date.now()
      });
      return 'allow';
    }
    
    return 'deny';
  }
}
```

## 🛡️ Best Practices

1. **Default Deny**: Deny by default, allow explicitly
2. **Least Privilege**: Allow only necessary traffic
3. **Regular Updates**: Update firewall rules
4. **Monitoring**: Monitor firewall logs
5. **Testing**: Test firewall rules
6. **Documentation**: Document all rules
7. **Review**: Regular rule reviews

---

**Next**: Learn about [Network Firewalls](./NETWORK-FIREWALLS.md)

