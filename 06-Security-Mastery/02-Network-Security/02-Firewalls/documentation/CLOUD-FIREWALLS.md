# Cloud Firewalls

## 📚 Overview

Cloud firewalls provide network security in cloud environments. They protect cloud resources with scalable, managed firewall services.

## 🎯 Cloud Firewall Types

### Types

1. **Network ACLs**: Subnet-level filtering
2. **Security Groups**: Instance-level filtering
3. **Cloud WAF**: Application-layer protection
4. **Managed Firewalls**: Cloud provider managed

## 🔍 AWS Security Groups

### Security Group Configuration

```javascript
// AWS Security Group example
const securityGroup = {
  GroupName: 'web-server-sg',
  Description: 'Security group for web servers',
  VpcId: 'vpc-123456',
  InboundRules: [
    {
      Protocol: 'tcp',
      Port: 443,
      Source: '0.0.0.0/0',
      Description: 'Allow HTTPS from internet'
    },
    {
      Protocol: 'tcp',
      Port: 22,
      Source: '10.0.0.0/8',
      Description: 'Allow SSH from internal network'
    }
  ],
  OutboundRules: [
    {
      Protocol: '-1', // All
      Destination: '0.0.0.0/0',
      Description: 'Allow all outbound'
    }
  ]
};
```

## 🔍 Azure Network Security Groups

### NSG Configuration

```javascript
// Azure NSG example
const nsg = {
  name: 'web-nsg',
  rules: [
    {
      name: 'AllowHTTPS',
      priority: 100,
      direction: 'Inbound',
      access: 'Allow',
      protocol: 'Tcp',
      sourcePortRange: '*',
      destinationPortRange: '443',
      sourceAddressPrefix: '*',
      destinationAddressPrefix: '*'
    },
    {
      name: 'DenyAllInbound',
      priority: 4096,
      direction: 'Inbound',
      access: 'Deny',
      protocol: '*',
      sourcePortRange: '*',
      destinationPortRange: '*',
      sourceAddressPrefix: '*',
      destinationAddressPrefix: '*'
    }
  ]
};
```

## 🔍 GCP Firewall Rules

### GCP Firewall Configuration

```javascript
// GCP Firewall rule example
const firewallRule = {
  name: 'allow-https',
  direction: 'INGRESS',
  priority: 1000,
  allowed: [
    {
      IPProtocol: 'tcp',
      ports: ['443']
    }
  ],
  sourceRanges: ['0.0.0.0/0'],
  targetTags: ['web-server'],
  description: 'Allow HTTPS traffic'
};
```

## 🔍 Cloud WAF Integration

### AWS WAF

```javascript
// AWS WAF rules
const wafRules = {
  sqlInjection: {
    name: 'SQLInjectionRule',
    priority: 1,
    statement: {
      byteMatchStatement: {
        searchString: 'SELECT',
        fieldToMatch: { allQueryArguments: {} }
      }
    },
    action: { block: {} }
  }
};
```

## 🛡️ Best Practices

1. **Least Privilege**: Minimize allowed traffic
2. **Network Segmentation**: Use VPCs/subnets
3. **Automation**: Automate rule management
4. **Monitoring**: Monitor firewall logs
5. **Regular Review**: Review rules regularly
6. **Documentation**: Document all rules
7. **Testing**: Test rule changes

---

**Next**: Learn about [Firewall Monitoring](./FIREWALL-MONITORING.md)

