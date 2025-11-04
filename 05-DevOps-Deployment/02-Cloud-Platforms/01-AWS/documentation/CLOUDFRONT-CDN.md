# AWS CloudFront CDN

## 📚 Overview

Amazon CloudFront is a content delivery network (CDN) service that delivers data, videos, applications, and APIs to users globally with low latency and high transfer speeds.

## 🎯 CloudFront Fundamentals

### Key Concepts

- **Distribution**: CloudFront configuration
- **Origin**: Source of content (S3, EC2, etc.)
- **Edge Location**: Cache location near users
- **Cache Behavior**: How content is cached
- **Invalidation**: Clear cached content

### Benefits

1. **Global Reach**: Edge locations worldwide
2. **Low Latency**: Content served from nearest edge
3. **High Performance**: Optimized delivery
4. **Security**: DDoS protection, SSL/TLS
5. **Cost Effective**: Pay only for data transfer

## 🚀 Creating Distribution

### S3 Origin

```bash
# Create CloudFront distribution
aws cloudfront create-distribution \
  --distribution-config file://distribution-config.json
```

```json
{
  "CallerReference": "my-distribution-123",
  "Comment": "My CloudFront distribution",
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3-my-bucket",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"],
      "CachedMethods": {
        "Quantity": 2,
        "Items": ["GET", "HEAD"]
      }
    },
    "ForwardedValues": {
      "QueryString": false,
      "Cookies": {
        "Forward": "none"
      }
    },
    "MinTTL": 0,
    "DefaultTTL": 86400,
    "MaxTTL": 31536000
  },
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "S3-my-bucket",
        "DomainName": "my-bucket.s3.amazonaws.com",
        "S3OriginConfig": {
          "OriginAccessIdentity": ""
        }
      }
    ]
  },
  "Enabled": true
}
```

### Custom Origin

```json
{
  "Origins": {
    "Items": [
      {
        "Id": "my-custom-origin",
        "DomainName": "api.example.com",
        "CustomOriginConfig": {
          "HTTPPort": 80,
          "HTTPSPort": 443,
          "OriginProtocolPolicy": "https-only",
          "OriginSslProtocols": {
            "Quantity": 1,
            "Items": ["TLSv1.2"]
          }
        }
      }
    ]
  }
}
```

## 🔐 Security

### SSL/TLS Certificates

```bash
# Use ACM certificate
# Request certificate in ACM
aws acm request-certificate \
  --domain-name example.com \
  --validation-method DNS

# Use in CloudFront distribution
# Configure in distribution settings
```

### Signed URLs

```python
# Generate signed URL
from botocore.signers import CloudFrontSigner

def rsa_signer(message):
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.asymmetric import padding
    from cryptography.hazmat.backends import default_backend
    
    with open('private_key.pem', 'rb') as key_file:
        private_key = serialization.load_pem_private_key(
            key_file.read(),
            password=None,
            backend=default_backend()
        )
    
    return private_key.sign(message, padding.PKCS1v15(), hashes.SHA1())

cloudfront_signer = CloudFrontSigner('KEY_ID', rsa_signer)

url = cloudfront_signer.generate_presigned_url(
    'https://d1234567890.cloudfront.net/file.jpg',
    date_less_than=datetime(2024, 12, 31)
)
```

### Signed Cookies

```python
# Generate signed cookies
policy = CloudFrontSigner.build_policy(
    'https://d1234567890.cloudfront.net/*',
    datetime(2024, 12, 31)
).encode('utf8')

signature = cloudfront_signer._signer(policy)
```

## 🔄 Cache Behaviors

### Path-Based Caching

```json
{
  "CacheBehaviors": {
    "Quantity": 2,
    "Items": [
      {
        "PathPattern": "/api/*",
        "TargetOriginId": "api-origin",
        "ViewerProtocolPolicy": "https-only",
        "CachePolicyId": "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
      },
      {
        "PathPattern": "/static/*",
        "TargetOriginId": "s3-origin",
        "ViewerProtocolPolicy": "redirect-to-https",
        "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e788f"
      }
    ]
  }
}
```

### Query String Caching

```json
{
  "ForwardedValues": {
    "QueryString": true,
    "QueryStringCacheKeys": {
      "Quantity": 2,
      "Items": ["version", "token"]
    },
    "Cookies": {
      "Forward": "whitelist",
      "WhitelistedNames": {
        "Quantity": 1,
        "Items": ["session"]
      }
    }
  }
}
```

## 🔄 Invalidations

### Create Invalidation

```bash
# Invalidate all files
aws cloudfront create-invalidation \
  --distribution-id E1234567890ABC \
  --paths "/*"

# Invalidate specific paths
aws cloudfront create-invalidation \
  --distribution-id E1234567890ABC \
  --paths "/index.html" "/assets/*"

# Check invalidation status
aws cloudfront get-invalidation \
  --distribution-id E1234567890ABC \
  --id I1234567890ABC
```

## 🌐 Geo-Restrictions

### Restrict by Country

```json
{
  "Restrictions": {
    "GeoRestriction": {
      "RestrictionType": "whitelist",
      "Quantity": 2,
      "Items": ["US", "CA"]
    }
  }
}
```

```bash
# Configure geo-restriction
aws cloudfront update-distribution \
  --id E1234567890ABC \
  --distribution-config file://distribution-config.json
```

## 📊 Monitoring

### CloudWatch Metrics

```bash
# Get CloudFront metrics
aws cloudwatch get-metric-statistics \
  --namespace AWS/CloudFront \
  --metric-name Requests \
  --dimensions Name=DistributionId,Value=E1234567890ABC Name=Region,Value=Global \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Sum
```

### Real-Time Logs

```bash
# Enable real-time logs
aws cloudfront create-realtime-log-config \
  --name my-realtime-logs \
  --sampling-rate 100 \
  --fields timestamp c-ip sc-status \
  --end-points StreamType=Kinesis,DeliveryStreamArn=arn:aws:kinesis:us-east-1:123456789012:stream/cloudfront-logs
```

## 🎯 Best Practices

1. **Cache Headers**: Set appropriate cache headers
2. **Compression**: Enable compression
3. **HTTPS**: Use HTTPS for all distributions
4. **Invalidations**: Minimize invalidations
5. **Monitoring**: Monitor CloudFront metrics
6. **Origin Shield**: Use for origin protection
7. **WAF**: Use Web Application Firewall

## 🎓 Learning Resources

- CloudFront Documentation: https://docs.aws.amazon.com/cloudfront/
- CloudFront Best Practices: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/best-practices.html
- CDN: https://aws.amazon.com/cloudfront/

---

**Next**: Learn about [AWS Best Practices](./AWS-BEST-PRACTICES.md)

