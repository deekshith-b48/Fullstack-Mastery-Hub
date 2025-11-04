# Google Cloud Load Balancing

## 📚 Overview

Google Cloud Load Balancing distributes traffic across multiple instances to ensure high availability and performance. It provides global and regional load balancing options.

## 🎯 Load Balancer Types

### HTTP(S) Load Balancing

- **Global**: Distributes traffic globally
- **Regional**: Regional distribution
- **SSL/TLS**: Terminates SSL/TLS
- **Content-based**: Route based on content

### Network Load Balancing

- **TCP/UDP**: Layer 4 load balancing
- **Regional**: Regional distribution
- **High Performance**: Low latency

### Internal Load Balancing

- **Internal**: Private load balancing
- **Regional**: Regional distribution
- **VPC**: Within VPC network

## 🚀 HTTP(S) Load Balancing

### Create HTTP Load Balancer

```bash
# Create health check
gcloud compute health-checks create http my-health-check \
  --port=80 \
  --request-path=/health \
  --check-interval=10s \
  --timeout=5s \
  --healthy-threshold=2 \
  --unhealthy-threshold=3

# Create instance group
gcloud compute instance-groups managed create my-instance-group \
  --size=3 \
  --template=my-template \
  --zone=us-east1-b

# Create backend service
gcloud compute backend-services create my-backend-service \
  --protocol=HTTP \
  --health-checks=my-health-check \
  --global

# Add backend
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

### HTTPS Load Balancer

```bash
# Create SSL certificate
gcloud compute ssl-certificates create my-cert \
  --certificate=cert.pem \
  --private-key=key.pem

# Create HTTPS target proxy
gcloud compute target-https-proxies create my-https-proxy \
  --url-map=my-url-map \
  --ssl-certificates=my-cert

# Create HTTPS forwarding rule
gcloud compute forwarding-rules create my-https-rule \
  --global \
  --target-https-proxy=my-https-proxy \
  --ports=443
```

## 🌐 Network Load Balancing

### Create Network Load Balancer

```bash
# Create health check
gcloud compute health-checks create tcp my-tcp-health-check \
  --port=80

# Create backend service
gcloud compute backend-services create my-network-backend \
  --protocol=TCP \
  --health-checks=my-tcp-health-check \
  --region=us-east1

# Create forwarding rule
gcloud compute forwarding-rules create my-network-lb \
  --load-balancing-scheme=EXTERNAL \
  --backend-service=my-network-backend \
  --ports=80 \
  --region=us-east1
```

## 🔗 Internal Load Balancing

### Create Internal Load Balancer

```bash
# Create internal backend service
gcloud compute backend-services create my-internal-backend \
  --protocol=TCP \
  --load-balancing-scheme=INTERNAL \
  --region=us-east1

# Create internal forwarding rule
gcloud compute forwarding-rules create my-internal-lb \
  --load-balancing-scheme=INTERNAL \
  --backend-service=my-internal-backend \
  --ports=80 \
  --subnet=my-subnet \
  --region=us-east1
```

## 🔄 Content-Based Routing

### URL Map with Path Rules

```bash
# Create URL map with path rules
gcloud compute url-maps create my-url-map \
  --default-service=my-backend-service \
  --path-matcher-name=api-matcher \
  --path-rules="/api/*=api-backend-service,/static/*=static-backend-service"
```

## 📊 Monitoring

### Cloud Monitoring

```bash
# View load balancer metrics
gcloud monitoring metrics list --filter="resource.type=https_lb_rule"
```

## 🎯 Best Practices

1. **Health Checks**: Configure appropriate health checks
2. **Backend Distribution**: Distribute across zones
3. **SSL/TLS**: Use HTTPS for security
4. **Monitoring**: Monitor load balancer metrics
5. **Auto-scaling**: Use with auto-scaling
6. **CDN**: Use Cloud CDN with HTTP(S) load balancer
7. **Security**: Implement security policies

## 🎓 Learning Resources

- Load Balancing Documentation: https://cloud.google.com/load-balancing/docs
- Best Practices: https://cloud.google.com/load-balancing/docs/best-practices
- Load Balancing: https://cloud.google.com/load-balancing

---

**Next**: Learn about [GCP Best Practices](./GCP-BEST-PRACTICES.md)

