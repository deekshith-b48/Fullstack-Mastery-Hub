# Google Cloud IAM Security

## 📚 Overview

Google Cloud Identity and Access Management (IAM) provides fine-grained access control and identity management for GCP resources. IAM enables you to manage who has what access to which resources.

## 🎯 IAM Fundamentals

### Core Concepts

- **Principal**: User, service account, or group
- **Role**: Collection of permissions
- **Policy**: Binding of principals to roles
- **Resource**: GCP resource (project, instance, bucket)
- **Permission**: Action on a resource

### IAM Hierarchy

- **Organization**: Top-level container
- **Folder**: Logical grouping
- **Project**: Resource container
- **Resource**: Individual resources

## 👥 User Management

### Grant Access

```bash
# Grant role to user
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/storage.admin"

# Grant role to group
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="group:developers@example.com" \
  --role="roles/compute.instanceAdmin"
```

### Service Accounts

```bash
# Create service account
gcloud iam service-accounts create my-sa \
  --display-name="My Service Account" \
  --description="Service account for my application"

# Grant role to service account
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:my-sa@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/storage.objectViewer"

# Create key
gcloud iam service-accounts keys create key.json \
  --iam-account=my-sa@PROJECT_ID.iam.gserviceaccount.com
```

## 🎭 Roles

### Predefined Roles

```bash
# Storage Admin
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/storage.admin"

# Compute Instance Admin
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/compute.instanceAdmin"

# Viewer
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/viewer"
```

### Custom Roles

```yaml
# role-definition.yaml
title: "Custom Storage Role"
description: "Custom role for storage operations"
stage: "GA"
includedPermissions:
  - storage.objects.get
  - storage.objects.list
  - storage.objects.create
```

```bash
# Create custom role
gcloud iam roles create customStorageRole \
  --project=PROJECT_ID \
  --file=role-definition.yaml

# Grant custom role
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="projects/PROJECT_ID/roles/customStorageRole"
```

## 🔐 Policy Management

### View Policy

```bash
# Get IAM policy
gcloud projects get-iam-policy PROJECT_ID

# Get IAM policy for resource
gcloud compute instances get-iam-policy my-instance \
  --zone=us-east1-b
```

### Set Policy

```bash
# Set IAM policy
gcloud projects set-iam-policy PROJECT_ID policy.json

# Update IAM policy
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="user:user@example.com" \
  --role="roles/storage.admin"
```

## 🔍 Access Control

### Resource-Level Permissions

```bash
# Grant access to specific bucket
gsutil iam ch user:user@example.com:objectViewer gs://my-bucket

# Grant access to specific instance
gcloud compute instances add-iam-policy-binding my-instance \
  --zone=us-east1-b \
  --member="user:user@example.com" \
  --role="roles/compute.instanceUser"
```

### Conditional Access

```json
{
  "bindings": [
    {
      "role": "roles/storage.admin",
      "members": ["user:user@example.com"],
      "condition": {
        "title": "Access during business hours",
        "expression": "request.time.getHours() >= 9 && request.time.getHours() < 17"
      }
    }
  ]
}
```

## 🔄 Best Practices

### Security Checklist

- [ ] Use service accounts for applications
- [ ] Follow least privilege principle
- [ ] Regular access reviews
- [ ] Use custom roles when needed
- [ ] Enable audit logging
- [ ] Use IAM Conditions
- [ ] Rotate service account keys

## 🎓 Learning Resources

- IAM Documentation: https://cloud.google.com/iam/docs
- IAM Best Practices: https://cloud.google.com/iam/docs/using-iam-securely
- IAM Roles: https://cloud.google.com/iam/docs/understanding-roles

---

**Next**: Learn about [GKE Containers](./GKE-CONTAINERS.md)

