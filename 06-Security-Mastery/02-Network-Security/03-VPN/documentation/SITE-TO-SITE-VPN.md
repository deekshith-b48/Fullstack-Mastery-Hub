# Site-to-Site VPN

## 📚 Overview

Site-to-Site VPN connects entire networks together, creating a secure tunnel between two or more locations. It's commonly used to connect branch offices to headquarters.

## 🎯 Site-to-Site VPN Use Cases

### Common Use Cases

1. **Branch Offices**: Connect remote offices
2. **Data Centers**: Connect multiple data centers
3. **Cloud Integration**: Connect on-premise to cloud
4. **Partner Networks**: Secure partner connections

## 🔍 Site-to-Site VPN Setup

### Configuration Example

```javascript
// Site-to-Site VPN configuration
const siteToSiteVPN = {
  site1: {
    name: 'Headquarters',
    network: '10.0.0.0/16',
    gateway: '203.0.113.1',
    preSharedKey: 'secure-key-here'
  },
  site2: {
    name: 'Branch Office',
    network: '192.168.1.0/24',
    gateway: '198.51.100.1',
    preSharedKey: 'secure-key-here'
  },
  protocol: 'IPSec',
  encryption: 'AES-256',
  authentication: 'SHA-256'
};
```

## 🔍 Cloud VPN Integration

### AWS Site-to-Site VPN

```javascript
// AWS VPN configuration
const awsVPN = {
  customerGateway: {
    ipAddress: '203.0.113.1',
    type: 'ipsec.1'
  },
  virtualPrivateGateway: {
    vpcId: 'vpc-123456',
    type: 'ipsec.1'
  },
  vpnConnection: {
    type: 'ipsec.1',
    staticRoutes: ['192.168.1.0/24']
  }
};
```

## 🔍 Monitoring

### VPN Monitoring

```javascript
// Monitor VPN connection
async function monitorVPNConnection(vpnId) {
  const status = await getVPNStatus(vpnId);
  
  if (status.state !== 'available') {
    sendAlert({
      type: 'vpn_down',
      vpnId: vpnId,
      state: status.state
    });
  }
  
  // Monitor bandwidth
  const bandwidth = await getVPNBandwidth(vpnId);
  if (bandwidth.usage > bandwidth.limit * 0.9) {
    sendAlert({
      type: 'vpn_bandwidth_high',
      vpnId: vpnId,
      usage: bandwidth.usage
    });
  }
}
```

## 🛡️ Best Practices

1. **Redundancy**: Use multiple VPN tunnels
2. **Monitoring**: Monitor connection status
3. **Encryption**: Use strong encryption
4. **Routing**: Configure routes properly
5. **Testing**: Test failover scenarios
6. **Documentation**: Document configuration
7. **Backup**: Backup VPN configurations

---

**Next**: Learn about [Remote Access VPN](./REMOTE-ACCESS-VPN.md)

