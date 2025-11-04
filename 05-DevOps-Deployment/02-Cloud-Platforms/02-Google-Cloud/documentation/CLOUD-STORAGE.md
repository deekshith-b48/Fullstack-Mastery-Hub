# Google Cloud Storage

## 📚 Overview

Google Cloud Storage is a unified object storage service for storing and accessing data. It offers high durability, availability, and global scalability with simple integration.

## 🎯 Storage Fundamentals

### Key Concepts

- **Bucket**: Container for objects (globally unique)
- **Object**: File stored in bucket
- **Class**: Storage class for cost optimization
- **Versioning**: Keep multiple object versions
- **Lifecycle**: Automatic transitions and deletions

### Storage Characteristics

- **Durability**: 99.999999999% (11 9's)
- **Availability**: 99.95% (varies by class)
- **Scalability**: Virtually unlimited
- **Security**: Encryption, IAM, ACLs

## 🚀 Basic Operations

### Create Bucket

```bash
# Create bucket
gsutil mb -p PROJECT_ID -c STANDARD -l us-east1 gs://my-bucket

# Create with versioning
gsutil versioning set on gs://my-bucket

# Create with lifecycle
gsutil lifecycle set lifecycle.json gs://my-bucket
```

### Upload Objects

```bash
# Upload file
gsutil cp file.txt gs://my-bucket/

# Upload directory
gsutil cp -r ./local-folder gs://my-bucket/folder/

# Upload with metadata
gsutil cp -h "Content-Type:text/html" file.html gs://my-bucket/

# Parallel upload
gsutil -m cp -r ./local-folder gs://my-bucket/
```

### Download Objects

```bash
# Download file
gsutil cp gs://my-bucket/file.txt .

# Download directory
gsutil cp -r gs://my-bucket/folder/ ./local-folder/

# Parallel download
gsutil -m cp -r gs://my-bucket/folder/ ./local-folder/
```

### List Objects

```bash
# List buckets
gsutil ls

# List objects
gsutil ls gs://my-bucket/

# List recursively
gsutil ls -r gs://my-bucket/

# List with details
gsutil ls -l gs://my-bucket/
```

### Delete Objects

```bash
# Delete object
gsutil rm gs://my-bucket/file.txt

# Delete directory
gsutil rm -r gs://my-bucket/folder/

# Delete bucket
gsutil rm -r gs://my-bucket
```

## 📊 Storage Classes

### Standard Storage

```bash
# Standard (default)
gsutil cp file.txt gs://my-bucket/
```

### Nearline Storage

```bash
# Nearline (accessed once a month)
gsutil cp -s NEARLINE file.txt gs://my-bucket/
```

### Coldline Storage

```bash
# Coldline (accessed once a quarter)
gsutil cp -s COLDLINE file.txt gs://my-bucket/
```

### Archive Storage

```bash
# Archive (accessed once a year)
gsutil cp -s ARCHIVE file.txt gs://my-bucket/
```

### Change Storage Class

```bash
# Change storage class
gsutil rewrite -s NEARLINE gs://my-bucket/file.txt
```

## 🔐 Security

### IAM Permissions

```bash
# Grant read access
gsutil iam ch user:user@example.com:objectViewer gs://my-bucket

# Grant write access
gsutil iam ch user:user@example.com:objectCreator gs://my-bucket

# Grant admin access
gsutil iam ch user:user@example.com:roles/storage.admin gs://my-bucket
```

### ACLs

```bash
# Set ACL
gsutil acl ch -u user@example.com:R gs://my-bucket/file.txt

# Make public
gsutil acl ch -u AllUsers:R gs://my-bucket/file.txt

# Set default ACL
gsutil defacl ch -u user@example.com:R gs://my-bucket/
```

### Encryption

```bash
# Customer-managed encryption keys (CMEK)
gsutil cp -k gs://my-bucket/file.txt gs://my-bucket/encrypted-file.txt

# Bucket encryption
gsutil encryption set gs://my-bucket
```

## 🔄 Versioning

### Enable Versioning

```bash
# Enable versioning
gsutil versioning set on gs://my-bucket

# List versions
gsutil ls -a gs://my-bucket/file.txt

# Restore version
gsutil cp gs://my-bucket/file.txt#1234567890 restored-file.txt

# Delete specific version
gsutil rm gs://my-bucket/file.txt#1234567890
```

## 🔄 Lifecycle Management

### Lifecycle Configuration

```json
{
  "lifecycle": {
    "rule": [
      {
        "action": {
          "type": "SetStorageClass",
          "storageClass": "NEARLINE"
        },
        "condition": {
          "age": 30
        }
      },
      {
        "action": {
          "type": "SetStorageClass",
          "storageClass": "COLDLINE"
        },
        "condition": {
          "age": 90
        }
      },
      {
        "action": {
          "type": "Delete"
        },
        "condition": {
          "age": 365
        }
      }
    ]
  }
}
```

```bash
# Apply lifecycle
gsutil lifecycle set lifecycle.json gs://my-bucket
```

## 🌐 Website Hosting

### Static Website

```bash
# Enable website hosting
gsutil web set -m index.html -e 404.html gs://my-bucket

# Make bucket public
gsutil iam ch allUsers:objectViewer gs://my-bucket
```

## 📊 Monitoring

### Cloud Monitoring

```bash
# View bucket metrics
gcloud monitoring metrics list --filter="resource.type=gcs_bucket"
```

## 🎯 Best Practices

1. **Bucket Naming**: Use DNS-compliant names
2. **Versioning**: Enable for critical data
3. **Lifecycle**: Automate storage transitions
4. **Encryption**: Enable encryption
5. **Access Control**: Use IAM and ACLs
6. **Monitoring**: Monitor usage and costs
7. **Cost Optimization**: Use appropriate storage classes

## 🎓 Learning Resources

- Cloud Storage Documentation: https://cloud.google.com/storage/docs
- Storage Classes: https://cloud.google.com/storage/docs/storage-classes
- Best Practices: https://cloud.google.com/storage/docs/best-practices

---

**Next**: Learn about [Cloud SQL](./CLOUD-SQL.md)

