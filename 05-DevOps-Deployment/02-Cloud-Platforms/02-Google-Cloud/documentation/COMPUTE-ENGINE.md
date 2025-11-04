# Google Cloud Compute Engine

## 📚 Overview

Google Compute Engine provides scalable, high-performance virtual machines running on Google's infrastructure. It offers flexible machine types, persistent disks, and networking capabilities.

## 🎯 VM Instances

### Create Instance

```bash
# Basic instance
gcloud compute instances create my-instance \
  --zone=us-east1-b \
  --machine-type=e2-medium \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud

# Instance with custom configuration
gcloud compute instances create my-instance \
  --zone=us-east1-b \
  --machine-type=e2-medium \
  --image-family=ubuntu-2204-lts \
  --boot-disk-size=50GB \
  --boot-disk-type=pd-ssd \
  --tags=web-server \
  --metadata=startup-script='#!/bin/bash
apt-get update
apt-get install -y nginx'
```

### Instance Types

- **e2**: Balanced general-purpose (e2-micro, e2-small, e2-medium, e2-standard-*)
- **n1**: Standard (legacy) (n1-standard-*, n1-highmem-*, n1-highcpu-*)
- **n2**: High memory and CPU (n2-standard-*, n2-highmem-*)
- **c2**: Compute-optimized (c2-standard-*)
- **m1**: Memory-optimized (m1-megamem-*, m1-ultramem-*)

### Instance Management

```bash
# List instances
gcloud compute instances list

# Get instance details
gcloud compute instances describe my-instance --zone=us-east1-b

# Start instance
gcloud compute instances start my-instance --zone=us-east1-b

# Stop instance
gcloud compute instances stop my-instance --zone=us-east1-b

# Delete instance
gcloud compute instances delete my-instance --zone=us-east1-b
```

## 💾 Persistent Disks

### Create Disk

```bash
# Create disk
gcloud compute disks create my-disk \
  --size=100GB \
  --type=pd-ssd \
  --zone=us-east1-b

# Attach disk
gcloud compute instances attach-disk my-instance \
  --disk=my-disk \
  --zone=us-east1-b

# Create snapshot
gcloud compute snapshots create my-snapshot \
  --source-disk=my-disk \
  --source-disk-zone=us-east1-b
```

### Disk Types

- **pd-standard**: Standard persistent disk
- **pd-ssd**: SSD persistent disk
- **pd-balanced**: Balanced persistent disk
- **pd-extreme**: Extreme persistent disk

## 🔄 Instance Templates

### Create Template

```bash
# Create instance template
gcloud compute instance-templates create my-template \
  --machine-type=e2-medium \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=20GB \
  --tags=web-server
```

### Managed Instance Groups

```bash
# Create managed instance group
gcloud compute instance-groups managed create my-group \
  --template=my-template \
  --size=3 \
  --zone=us-east1-b

# Auto-scaling
gcloud compute instance-groups managed set-autoscaling my-group \
  --max-num-replicas=10 \
  --min-num-replicas=2 \
  --target-cpu-utilization=0.6 \
  --zone=us-east1-b
```

## 🌐 Networking

### Firewall Rules

```bash
# Create firewall rule
gcloud compute firewall-rules create allow-http \
  --network=default \
  --allow tcp:80 \
  --source-ranges 0.0.0.0/0 \
  --target-tags web-server

# List firewall rules
gcloud compute firewall-rules list

# Delete firewall rule
gcloud compute firewall-rules delete allow-http
```

### Load Balancing

```bash
# Create health check
gcloud compute health-checks create http my-health-check \
  --port=80

# Create backend service
gcloud compute backend-services create my-backend-service \
  --health-checks=my-health-check \
  --protocol=HTTP

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

## 🔐 Security

### Service Accounts

```bash
# Create service account
gcloud iam service-accounts create compute-sa \
  --display-name="Compute Service Account"

# Grant role
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:compute-sa@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/storage.objectViewer"

# Use service account with instance
gcloud compute instances create my-instance \
  --service-account=compute-sa@PROJECT_ID.iam.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/cloud-platform
```

### SSH Keys

```bash
# Add SSH key
gcloud compute instances add-metadata my-instance \
  --metadata-from-file ssh-keys=~/.ssh/gcp-key.pub

# SSH into instance
gcloud compute ssh my-instance --zone=us-east1-b
```

## 📊 Monitoring

### Cloud Monitoring

```bash
# Enable monitoring agent
gcloud compute instances create my-instance \
  --metadata=enable-oslogin=TRUE

# View metrics
gcloud monitoring metrics list --filter="resource.type=gce_instance"
```

## 🎯 Best Practices

1. **Right-sizing**: Choose appropriate machine types
2. **Auto-scaling**: Use managed instance groups
3. **Snapshots**: Regular backups
4. **Security**: Use service accounts and firewall rules
5. **Monitoring**: Enable monitoring and logging
6. **Tags**: Use labels for organization
7. **Zones**: Distribute across zones

## 🎓 Learning Resources

- Compute Engine Documentation: https://cloud.google.com/compute/docs
- Instance Types: https://cloud.google.com/compute/docs/machine-types
- Best Practices: https://cloud.google.com/compute/docs/instances/best-practices

---

**Next**: Learn about [Cloud Storage](./CLOUD-STORAGE.md)

