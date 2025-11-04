# AWS S3 Storage

## 📚 Overview

Amazon Simple Storage Service (S3) is an object storage service offering industry-leading scalability, data availability, security, and performance. S3 is designed for 99.999999999% (11 9's) of durability.

## 🎯 S3 Fundamentals

### Key Concepts

- **Bucket**: Container for objects (globally unique name)
- **Object**: File stored in bucket (key-value pair)
- **Key**: Unique identifier for object
- **Region**: Geographic location of bucket
- **Versioning**: Keep multiple versions of objects

### S3 Characteristics

- **Durability**: 99.999999999% (11 9's)
- **Availability**: 99.99% (varies by storage class)
- **Scalability**: Virtually unlimited storage
- **Security**: Encryption, access control, logging

## 🚀 Basic Operations

### Create Bucket

```bash
# Create bucket
aws s3 mb s3://my-bucket-name

# Create bucket in specific region
aws s3 mb s3://my-bucket-name --region us-west-2

# Create bucket with configuration
aws s3api create-bucket \
  --bucket my-bucket-name \
  --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

### Upload Objects

```bash
# Upload single file
aws s3 cp file.txt s3://my-bucket-name/

# Upload with specific key
aws s3 cp file.txt s3://my-bucket-name/path/to/file.txt

# Upload directory
aws s3 cp ./local-folder s3://my-bucket-name/folder/ --recursive

# Sync directory (only changed files)
aws s3 sync ./local-folder s3://my-bucket-name/folder/

# Upload with metadata
aws s3 cp file.txt s3://my-bucket-name/ \
  --metadata "key=value" \
  --metadata "another-key=another-value"
```

### Download Objects

```bash
# Download file
aws s3 cp s3://my-bucket-name/file.txt .

# Download directory
aws s3 cp s3://my-bucket-name/folder/ ./local-folder --recursive

# Sync from S3
aws s3 sync s3://my-bucket-name/folder/ ./local-folder/

# Download with presigned URL
aws s3 presign s3://my-bucket-name/file.txt --expires-in 3600
```

### List Objects

```bash
# List buckets
aws s3 ls

# List objects in bucket
aws s3 ls s3://my-bucket-name/

# List objects recursively
aws s3 ls s3://my-bucket-name/ --recursive

# List with details
aws s3api list-objects-v2 \
  --bucket my-bucket-name \
  --prefix folder/
```

### Delete Objects

```bash
# Delete object
aws s3 rm s3://my-bucket-name/file.txt

# Delete directory
aws s3 rm s3://my-bucket-name/folder/ --recursive

# Delete bucket
aws s3 rb s3://my-bucket-name

# Force delete (with contents)
aws s3 rb s3://my-bucket-name --force
```

## 📊 Storage Classes

### Standard Storage

```bash
# Standard storage (default)
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class STANDARD
```

### Intelligent-Tiering

```bash
# Automatic cost optimization
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class INTELLIGENT_TIERING
```

### Standard-IA (Infrequent Access)

```bash
# For infrequently accessed data
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class STANDARD_IA
```

### One Zone-IA

```bash
# Single AZ, lower cost
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class ONEZONE_IA
```

### Glacier

```bash
# Archive storage
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class GLACIER
```

### Deep Archive

```bash
# Lowest cost archive
aws s3 cp file.txt s3://my-bucket-name/ \
  --storage-class DEEP_ARCHIVE
```

## 🔐 S3 Security

### Bucket Policies

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

```bash
# Apply bucket policy
aws s3api put-bucket-policy \
  --bucket my-bucket-name \
  --policy file://bucket-policy.json
```

### Access Control Lists (ACLs)

```bash
# Set bucket ACL
aws s3api put-bucket-acl \
  --bucket my-bucket-name \
  --acl private

# Set object ACL
aws s3api put-object-acl \
  --bucket my-bucket-name \
  --key file.txt \
  --acl public-read
```

### Encryption

```bash
# Upload with server-side encryption
aws s3 cp file.txt s3://my-bucket-name/ \
  --sse AES256

# Upload with KMS encryption
aws s3 cp file.txt s3://my-bucket-name/ \
  --sse aws:kms \
  --sse-kms-key-id <key-id>
```

### Bucket Encryption

```json
{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }
  ]
}
```

```bash
# Enable bucket encryption
aws s3api put-bucket-encryption \
  --bucket my-bucket-name \
  --server-side-encryption-configuration file://encryption.json
```

## 🔄 Versioning

### Enable Versioning

```bash
# Enable versioning
aws s3api put-bucket-versioning \
  --bucket my-bucket-name \
  --versioning-configuration Status=Enabled
```

### Version Operations

```bash
# List object versions
aws s3api list-object-versions \
  --bucket my-bucket-name \
  --prefix file.txt

# Restore specific version
aws s3api get-object \
  --bucket my-bucket-name \
  --key file.txt \
  --version-id <version-id> \
  restored-file.txt

# Delete specific version
aws s3api delete-object \
  --bucket my-bucket-name \
  --key file.txt \
  --version-id <version-id>
```

## 🌐 Website Hosting

### Static Website Hosting

```bash
# Enable static website hosting
aws s3 website s3://my-bucket-name/ \
  --index-document index.html \
  --error-document error.html
```

### Website Configuration

```json
{
  "IndexDocument": {
    "Suffix": "index.html"
  },
  "ErrorDocument": {
    "Key": "error.html"
  },
  "RoutingRules": [
    {
      "Condition": {
        "KeyPrefixEquals": "docs/"
      },
      "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
      }
    }
  ]
}
```

## 🔄 Lifecycle Policies

### Lifecycle Configuration

```json
{
  "Rules": [
    {
      "Id": "Move to IA after 30 days",
      "Status": "Enabled",
      "Prefix": "",
      "Transitions": [
        {
          "Days": 30,
          "StorageClass": "STANDARD_IA"
        }
      ]
    },
    {
      "Id": "Move to Glacier after 90 days",
      "Status": "Enabled",
      "Prefix": "archive/",
      "Transitions": [
        {
          "Days": 90,
          "StorageClass": "GLACIER"
        }
      ]
    },
    {
      "Id": "Delete after 365 days",
      "Status": "Enabled",
      "Prefix": "temp/",
      "Expiration": {
        "Days": 365
      }
    }
  ]
}
```

```bash
# Apply lifecycle policy
aws s3api put-bucket-lifecycle-configuration \
  --bucket my-bucket-name \
  --lifecycle-configuration file://lifecycle.json
```

## 🔍 S3 Events

### Event Notifications

```bash
# Configure event notification
aws s3api put-bucket-notification-configuration \
  --bucket my-bucket-name \
  --notification-configuration file://notification.json
```

```json
{
  "LambdaFunctionConfigurations": [
    {
      "LambdaFunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:my-function",
      "Events": ["s3:ObjectCreated:*"],
      "Filter": {
        "Key": {
          "FilterRules": [
            {
              "Name": "prefix",
              "Value": "images/"
            }
          ]
        }
      }
    }
  ]
}
```

## 📊 S3 Analytics

### Storage Class Analysis

```bash
# Create storage class analysis
aws s3control create-storage-lens-configuration \
  --account-id 123456789012 \
  --config-id default-account-dashboard \
  --storage-lens-configuration file://lens-config.json
```

## 🎯 Best Practices

1. **Bucket Naming**: Use DNS-compliant names
2. **Versioning**: Enable for critical data
3. **Lifecycle Policies**: Automate storage transitions
4. **Encryption**: Enable encryption by default
5. **Access Control**: Use IAM and bucket policies
6. **Monitoring**: Enable CloudWatch metrics
7. **Cost Optimization**: Use appropriate storage classes

## 🎓 Learning Resources

- S3 Documentation: https://docs.aws.amazon.com/s3/
- S3 Best Practices: https://docs.aws.amazon.com/AmazonS3/latest/userguide/best-practices.html
- S3 Storage Classes: https://aws.amazon.com/s3/storage-classes/

---

**Next**: Learn about [RDS Databases](./RDS-DATABASES.md)

