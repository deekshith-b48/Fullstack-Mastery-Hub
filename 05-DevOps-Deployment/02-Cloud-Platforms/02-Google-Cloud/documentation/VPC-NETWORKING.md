# Google Cloud VPC Networking

## 📚 Overview

Google Cloud VPC provides networking functionality for Compute Engine, GKE, and other services. It enables you to create isolated networks with custom IP ranges, subnets, and firewall rules.

## 🎯 VPC Fundamentals

### Key Concepts

- **VPC Network**: Isolated virtual network
- **Subnet**: IP address range in a region
- **Firewall Rules**: Control traffic flow
- **Routes**: Define how traffic is routed
- **VPN**: Connect to on-premises networks

### VPC Modes

- **Auto Mode**: Automatically created subnets
- **Custom Mode**: Manual subnet configuration

## 🚀 Creating VPC

### Create VPC

```bash
# Create custom VPC
gcloud compute networks create my-vpc \
  --subnet-mode=custom

# Create auto mode VPC
gcloud compute networks create my-auto-vpc \
  --subnet-mode=auto
```

### Create Subnets

```bash
# Create subnet
gcloud compute networks subnets create my-subnet \
  --network=my-vpc \
  --range=10.0.0.0/24 \
  --region=us-east1

# Create subnet with secondary ranges
gcloud compute networks subnets create my-subnet \
  --network=my-vpc \
  --range=10.0.0.0/24 \
  --secondary-range pods=10.1.0.0/16 \
  --secondary-range services=10.2.0.0/16 \
  --region=us-east1
```

## 🔐 Firewall Rules

### Create Firewall Rule

```bash
# Allow HTTP
gcloud compute firewall-rules create allow-http \
  --network=my-vpc \
  --allow tcp:80 \
  --source-ranges 0.0.0.0/0 \
  --target-tags web-server

# Allow HTTPS
gcloud compute firewall-rules create allow-https \
  --network=my-vpc \
  --allow tcp:443 \
  --source-ranges 0.0.0.0/0 \
  --target-tags web-server

# Allow SSH from specific IP
gcloud compute firewall-rules create allow-ssh \
  --network=my-vpc \
  --allow tcp:22 \
  --source-ranges 203.0.113.0/24 \
  --target-tags ssh-allowed
```

### Firewall Rule Management

```bash
# List firewall rules
gcloud compute firewall-rules list

# Describe firewall rule
gcloud compute firewall-rules describe allow-http

# Update firewall rule
gcloud compute firewall-rules update allow-http \
  --source-ranges 203.0.113.0/24,198.51.100.0/24

# Delete firewall rule
gcloud compute firewall-rules delete allow-http
```

## 🌐 Load Balancing

### HTTP(S) Load Balancing

```bash
# Create health check
gcloud compute health-checks create http my-health-check \
  --port=80 \
  --request-path=/health

# Create backend service
gcloud compute backend-services create my-backend-service \
  --protocol=HTTP \
  --health-checks=my-health-check \
  --global

# Add instance group to backend
gcloud compute backend-services add-backend my-backend-service \
  --instance-group=my-instance-group \
  --instance-group-zone=us-east1-b \
  --global

# Create URL map
gcloud compute url-maps create my-url-map \
  --default-service=my-backend-service

# Create target proxy
gcloud compute target-http-proxies create my-proxy \
  --url-map=my-url-map

# Create forwarding rule
gcloud compute forwarding-rules create my-rule \
  --global \
  --target-http-proxy=my-proxy \
  --ports=80
```

### Internal Load Balancing

```bash
# Create internal load balancer
gcloud compute forwarding-rules create my-internal-lb \
  --load-balancing-scheme=internal \
  --network=my-vpc \
  --subnet=my-subnet \
  --region=us-east1 \
  --backend-service=my-backend-service \
  --ports=80
```

## 🔗 VPN

### VPN Gateway

```bash
# Create VPN gateway
gcloud compute vpn-gateways create my-vpn-gateway \
  --network=my-vpc \
  --region=us-east1

# Create VPN tunnel
gcloud compute vpn-tunnels create my-tunnel \
  --peer-ip=203.0.113.1 \
  --shared-secret=SECRET_KEY \
  --vpn-gateway=my-vpn-gateway \
  --region=us-east1 \
  --local-traffic-selector=0.0.0.0/0 \
  --remote-traffic-selector=10.0.0.0/8
```

## 🔍 VPC Peering

### Create VPC Peering

```bash
# Create peering connection
gcloud compute networks peerings create peer-to-network2 \
  --network=my-vpc \
  --peer-network=network2 \
  --auto-create-routes
```

## 📊 Monitoring

### VPC Flow Logs

```bash
# Enable VPC flow logs
gcloud compute networks update my-vpc \
  --enable-flow-logs \
  --flow-log-sampling=0.5 \
  --flow-log-metadata=INCLUDE_ALL_METADATA
```

## 🎯 Best Practices

1. **Network Design**: Plan IP ranges carefully
2. **Firewall Rules**: Use least privilege
3. **Subnets**: Organize by function or environment
4. **Load Balancing**: Use for high availability
5. **Monitoring**: Enable flow logs
6. **Security**: Implement network security
7. **Documentation**: Document network topology

## 🎓 Learning Resources

- VPC Documentation: https://cloud.google.com/vpc/docs
- Networking: https://cloud.google.com/network-connectivity/docs
- Best Practices: https://cloud.google.com/vpc/docs/best-practices

---

**Next**: Learn about [IAM Security](./IAM-SECURITY.md)

