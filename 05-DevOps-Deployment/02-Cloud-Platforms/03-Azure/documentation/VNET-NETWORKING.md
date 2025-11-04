# Azure Virtual Network (VNet)

## 📚 Overview

Azure Virtual Network (VNet) enables you to create isolated networks in Azure. VNets provide secure communication between Azure resources, internet, and on-premises networks.

## 🎯 VNet Fundamentals

### Key Concepts

- **Virtual Network**: Isolated network in Azure
- **Subnet**: Subdivision of VNet IP range
- **Network Security Group (NSG)**: Firewall rules
- **Route Table**: Custom routing rules
- **VPN Gateway**: Connect to on-premises

## 🚀 Creating VNet

### Create VNet

```bash
# Create virtual network
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --address-prefix 10.0.0.0/16 \
  --location eastus

# Create with subnets
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name mySubnet \
  --subnet-prefix 10.0.1.0/24 \
  --location eastus
```

### Create Subnets

```bash
# Create subnet
az network vnet subnet create \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name mySubnet \
  --address-prefix 10.0.1.0/24

# Create subnet with service endpoint
az network vnet subnet create \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name mySubnet \
  --address-prefix 10.0.2.0/24 \
  --service-endpoints Microsoft.Storage
```

## 🔐 Network Security Groups

### Create NSG

```bash
# Create network security group
az network nsg create \
  --resource-group myResourceGroup \
  --name myNSG \
  --location eastus

# Create NSG rule
az network nsg rule create \
  --resource-group myResourceGroup \
  --nsg-name myNSG \
  --name AllowHTTP \
  --priority 1000 \
  --protocol Tcp \
  --destination-port-ranges 80 \
  --access Allow \
  --direction Inbound

# Associate NSG with subnet
az network vnet subnet update \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name mySubnet \
  --network-security-group myNSG
```

## 🔄 Route Tables

### Create Route Table

```bash
# Create route table
az network route-table create \
  --resource-group myResourceGroup \
  --name myRouteTable \
  --location eastus

# Create route
az network route-table route create \
  --resource-group myResourceGroup \
  --route-table-name myRouteTable \
  --name ToInternet \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type Internet

# Associate with subnet
az network vnet subnet update \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name mySubnet \
  --route-table myRouteTable
```

## 🌐 VPN Gateway

### Create VPN Gateway

```bash
# Create public IP
az network public-ip create \
  --resource-group myResourceGroup \
  --name myVpnGatewayIP \
  --allocation-method Dynamic

# Create gateway subnet
az network vnet subnet create \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name GatewaySubnet \
  --address-prefix 10.0.3.0/24

# Create VPN gateway
az network vnet-gateway create \
  --resource-group myResourceGroup \
  --name myVpnGateway \
  --vnet myVNet \
  --public-ip-address myVpnGatewayIP \
  --gateway-type Vpn \
  --vpn-type RouteBased \
  --sku VpnGw1
```

## 🔗 VNet Peering

### Create VNet Peering

```bash
# Create peering
az network vnet peering create \
  --resource-group myResourceGroup \
  --name myVNet-to-myVNet2 \
  --vnet-name myVNet \
  --remote-vnet myVNet2 \
  --allow-vnet-access
```

## 📊 Monitoring

### Network Watcher

```bash
# Enable network watcher
az network watcher configure \
  --resource-group myResourceGroup \
  --locations eastus \
  --enabled true
```

## 🎯 Best Practices

1. **Network Design**: Plan IP ranges carefully
2. **NSGs**: Use least privilege
3. **Subnets**: Organize by function
4. **Monitoring**: Enable Network Watcher
5. **Security**: Implement network security
6. **Documentation**: Document network topology

## 🎓 Learning Resources

- VNet Documentation: https://docs.microsoft.com/azure/virtual-network/
- Networking: https://docs.microsoft.com/azure/networking/
- Best Practices: https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm

---

**Next**: Learn about [Azure AD Security](./AZURE-AD-SECURITY.md)

