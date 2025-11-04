# Google Cloud Platform Fundamentals

## 📚 Overview

Google Cloud Platform (GCP) is a suite of cloud computing services that runs on the same infrastructure that Google uses internally. GCP offers computing, storage, networking, and various other services.

## 🎯 What is GCP?

GCP provides a comprehensive set of cloud services for building, deploying, and scaling applications. It offers infrastructure, platform, and software-as-a-service solutions.

### Key Concepts

- **Project**: Organizational unit for resources
- **Region**: Geographic location (e.g., us-east1)
- **Zone**: Deployment area within a region
- **Resource Hierarchy**: Organization → Folder → Project
- **Billing**: Pay-as-you-go model

### Core Services

1. **Compute**: Compute Engine, GKE, Cloud Functions
2. **Storage**: Cloud Storage, Cloud SQL, Bigtable
3. **Networking**: VPC, Load Balancing, Cloud CDN
4. **Security**: IAM, Cloud KMS, Cloud Armor
5. **Monitoring**: Cloud Monitoring, Cloud Logging

## 🚀 Getting Started

### GCP Account Setup

```bash
# Install Google Cloud SDK
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Initialize gcloud
gcloud init

# Set project
gcloud config set project PROJECT_ID

# Verify configuration
gcloud config list
```

### Authentication

```bash
# Login
gcloud auth login

# Set application default credentials
gcloud auth application-default login

# Create service account
gcloud iam service-accounts create my-sa \
  --display-name "My Service Account"

# Create key
gcloud iam service-accounts keys create key.json \
  --iam-account my-sa@PROJECT_ID.iam.gserviceaccount.com
```

## 💻 Compute Engine

### Create VM Instance

```bash
# Create instance
gcloud compute instances create my-instance \
  --zone=us-east1-b \
  --machine-type=e2-medium \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=20GB

# List instances
gcloud compute instances list

# SSH into instance
gcloud compute ssh my-instance --zone=us-east1-b

# Delete instance
gcloud compute instances delete my-instance --zone=us-east1-b
```

### Instance Types

- **e2**: Balanced general-purpose
- **n1**: Standard (legacy)
- **n2**: High memory and CPU
- **c2**: Compute-optimized
- **m1**: Memory-optimized

## 📦 Cloud Storage

### Create Bucket

```bash
# Create bucket
gsutil mb -p PROJECT_ID -c STANDARD -l us-east1 gs://my-bucket

# List buckets
gsutil ls

# Upload file
gsutil cp file.txt gs://my-bucket/

# Download file
gsutil cp gs://my-bucket/file.txt .

# Delete object
gsutil rm gs://my-bucket/file.txt

# Delete bucket
gsutil rm -r gs://my-bucket
```

### Storage Classes

- **Standard**: Frequently accessed
- **Nearline**: Accessed once a month
- **Coldline**: Accessed once a quarter
- **Archive**: Accessed once a year

## 🔐 IAM

### IAM Roles

```bash
# Grant role to user
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/storage.admin"

# Grant role to service account
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:my-sa@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/storage.objectViewer"
```

### Custom Roles

```json
{
  "title": "Custom Storage Role",
  "description": "Custom role for storage operations",
  "stage": "GA",
  "includedPermissions": [
    "storage.objects.get",
    "storage.objects.list"
  ]
}
```

```bash
# Create custom role
gcloud iam roles create customStorageRole \
  --project=PROJECT_ID \
  --file=role-definition.json
```

## 🌐 VPC Networking

### Create VPC

```bash
# Create VPC
gcloud compute networks create my-vpc \
  --subnet-mode=custom

# Create subnet
gcloud compute networks subnets create my-subnet \
  --network=my-vpc \
  --range=10.0.0.0/24 \
  --region=us-east1

# Create firewall rule
gcloud compute firewall-rules create allow-http \
  --network=my-vpc \
  --allow tcp:80 \
  --source-ranges 0.0.0.0/0
```

## 📊 Cloud Monitoring

### Metrics

```bash
# List metrics
gcloud monitoring metrics list

# Create alert policy
gcloud alpha monitoring policies create \
  --notification-channels=CHANNEL_ID \
  --display-name="High CPU Usage" \
  --condition-display-name="CPU > 80%" \
  --condition-threshold-value=80 \
  --condition-threshold-duration=300s
```

## 🎯 Best Practices

1. **Use Projects**: Organize resources by project
2. **IAM**: Implement least privilege
3. **Networking**: Use VPC for isolation
4. **Monitoring**: Enable monitoring and logging
5. **Cost Optimization**: Right-size resources
6. **Security**: Enable security features
7. **Backup**: Regular backups

## 🎓 Learning Resources

- GCP Documentation: https://cloud.google.com/docs
- GCP Best Practices: https://cloud.google.com/docs/enterprise/best-practices
- GCP Free Tier: https://cloud.google.com/free

---

**Next**: Learn about [Compute Engine](./COMPUTE-ENGINE.md)

