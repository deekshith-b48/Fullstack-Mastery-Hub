# AWS VPC Networking

## 📚 Overview

Amazon Virtual Private Cloud (VPC) enables you to launch AWS resources into a virtual network that you define. VPC provides complete control over your virtual networking environment, including selection of IP address ranges, creation of subnets, and configuration of route tables and network gateways.

## 🎯 VPC Fundamentals

### VPC Components

- **VPC**: Isolated virtual network
- **Subnet**: Segment of VPC IP range
- **Internet Gateway**: Internet connectivity
- **NAT Gateway**: Outbound internet for private subnets
- **Route Table**: Routing rules
- **Security Group**: Virtual firewall
- **Network ACL**: Subnet-level firewall
- **VPC Peering**: Connect VPCs

## 🚀 Creating VPC

### Create VPC

```bash
# Create VPC
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=my-vpc}]'

# Create VPC with DNS
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --enable-dns-hostnames \
  --enable-dns-support
```

### Create Subnets

```bash
# Create public subnet
aws ec2 create-subnet \
  --vpc-id vpc-12345678 \
  --cidr-block 10.0.1.0/24 \
  --availability-zone us-east-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-subnet-1a}]'

# Create private subnet
aws ec2 create-subnet \
  --vpc-id vpc-12345678 \
  --cidr-block 10.0.2.0/24 \
  --availability-zone us-east-1b \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-subnet-1b}]'
```

### Internet Gateway

```bash
# Create internet gateway
aws ec2 create-internet-gateway \
  --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]'

# Attach to VPC
aws ec2 attach-internet-gateway \
  --internet-gateway-id igw-12345678 \
  --vpc-id vpc-12345678
```

### Route Tables

```bash
# Create route table
aws ec2 create-route-table \
  --vpc-id vpc-12345678 \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=public-rt}]'

# Add route to internet
aws ec2 create-route \
  --route-table-id rtb-12345678 \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-12345678

# Associate subnet with route table
aws ec2 associate-route-table \
  --subnet-id subnet-12345678 \
  --route-table-id rtb-12345678
```

## 🔐 Security Groups

### Create Security Group

```bash
# Create security group
aws ec2 create-security-group \
  --group-name web-sg \
  --description "Web server security group" \
  --vpc-id vpc-12345678

# Add inbound rule
aws ec2 authorize-security-group-ingress \
  --group-id sg-12345678 \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

# Add outbound rule
aws ec2 authorize-security-group-egress \
  --group-id sg-12345678 \
  --protocol tcp \
  --port 443 \
  --cidr 0.0.0.0/0
```

### Network ACLs

```bash
# Create network ACL
aws ec2 create-network-acl \
  --vpc-id vpc-12345678 \
  --tag-specifications 'ResourceType=network-acl,Tags=[{Key=Name,Value=my-nacl}]'

# Create ACL rule
aws ec2 create-network-acl-entry \
  --network-acl-id acl-12345678 \
  --rule-number 100 \
  --protocol tcp \
  --port-range From=80,To=80 \
  --cidr-block 0.0.0.0/0 \
  --egress \
  --rule-action allow
```

## 🌐 NAT Gateway

### Create NAT Gateway

```bash
# Allocate Elastic IP
aws ec2 allocate-address --domain vpc

# Create NAT Gateway
aws ec2 create-nat-gateway \
  --subnet-id subnet-12345678 \
  --allocation-id eipalloc-12345678 \
  --tag-specifications 'ResourceType=nat-gateway,Tags=[{Key=Name,Value=my-nat}]'

# Add route for private subnet
aws ec2 create-route \
  --route-table-id rtb-87654321 \
  --destination-cidr-block 0.0.0.0/0 \
  --nat-gateway-id nat-12345678
```

## 🔗 VPC Peering

### Create VPC Peering

```bash
# Create peering connection
aws ec2 create-vpc-peering-connection \
  --vpc-id vpc-12345678 \
  --peer-vpc-id vpc-87654321

# Accept peering connection
aws ec2 accept-vpc-peering-connection \
  --vpc-peering-connection-id pcx-12345678

# Add routes
aws ec2 create-route \
  --route-table-id rtb-12345678 \
  --destination-cidr-block 10.1.0.0/16 \
  --vpc-peering-connection-id pcx-12345678
```

## 🔍 VPC Flow Logs

### Enable Flow Logs

```bash
# Create IAM role for flow logs
# Then enable flow logs
aws ec2 create-flow-logs \
  --resource-type VPC \
  --resource-ids vpc-12345678 \
  --traffic-type ALL \
  --log-destination-type cloud-watch-logs \
  --log-group-name vpc-flow-logs
```

## 🎯 Best Practices

1. **CIDR Planning**: Plan IP ranges carefully
2. **Multi-AZ**: Deploy across Availability Zones
3. **Security Groups**: Use least privilege
4. **NAT Gateway**: Use for private subnets
5. **Flow Logs**: Enable for security monitoring
6. **Route Tables**: Organize routing logically
7. **Tagging**: Consistent tagging strategy

## 🎓 Learning Resources

- VPC Documentation: https://docs.aws.amazon.com/vpc/
- VPC Best Practices: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-best-practices.html
- Networking: https://aws.amazon.com/vpc/

---

**Next**: Learn about [IAM Security](./IAM-SECURITY.md)

