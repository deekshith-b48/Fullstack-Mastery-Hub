# AWS IAM Security

## 📚 Overview

AWS Identity and Access Management (IAM) enables you to manage access to AWS services and resources securely. IAM provides fine-grained access control and identity management for your AWS account.

## 🎯 IAM Fundamentals

### Core Concepts

- **Users**: People or applications that need access
- **Groups**: Collections of users
- **Roles**: Temporary credentials for resources
- **Policies**: Permissions documents
- **MFA**: Multi-factor authentication

### IAM Components

- **Principals**: Users, roles, or applications
- **Actions**: Operations (e.g., s3:GetObject)
- **Resources**: AWS resources (e.g., S3 buckets)
- **Conditions**: Optional access restrictions

## 👥 User Management

### Create IAM User

```bash
# Create user
aws iam create-user \
  --user-name developer \
  --tags Key=Department,Value=Engineering

# Create access key
aws iam create-access-key \
  --user-name developer

# Create login profile
aws iam create-login-profile \
  --user-name developer \
  --password MyPassword123! \
  --password-reset-required
```

### User Operations

```bash
# List users
aws iam list-users

# Get user details
aws iam get-user --user-name developer

# Update user
aws iam update-user \
  --user-name developer \
  --new-user-name dev-user

# Delete user
aws iam delete-user --user-name developer
```

## 🔐 Groups

### Create Group

```bash
# Create group
aws iam create-group --group-name developers

# Add user to group
aws iam add-user-to-group \
  --group-name developers \
  --user-name developer

# List groups
aws iam list-groups

# List users in group
aws iam get-group --group-name developers
```

## 🎭 Roles

### Create Role

```json
// trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

```bash
# Create role
aws iam create-role \
  --role-name ec2-role \
  --assume-role-policy-document file://trust-policy.json

# Attach policy to role
aws iam attach-role-policy \
  --role-name ec2-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

### Instance Profile

```bash
# Create instance profile
aws iam create-instance-profile \
  --instance-profile-name ec2-profile

# Add role to instance profile
aws iam add-role-to-instance-profile \
  --instance-profile-name ec2-profile \
  --role-name ec2-role
```

## 📋 Policies

### Managed Policies

```bash
# List managed policies
aws iam list-policies --scope AWS

# Attach managed policy
aws iam attach-user-policy \
  --user-name developer \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

### Inline Policies

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

```bash
# Create inline policy
aws iam put-user-policy \
  --user-name developer \
  --policy-name my-policy \
  --policy-document file://policy.json
```

### Custom Policies

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowS3Access",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::my-bucket/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "203.0.113.0/24"
        }
      }
    }
  ]
}
```

```bash
# Create custom policy
aws iam create-policy \
  --policy-name my-custom-policy \
  --policy-document file://policy.json

# Attach to user
aws iam attach-user-policy \
  --user-name developer \
  --policy-arn arn:aws:iam::123456789012:policy/my-custom-policy
```

## 🔒 MFA (Multi-Factor Authentication)

### Enable MFA

```bash
# Create virtual MFA device
aws iam create-virtual-mfa-device \
  --virtual-mfa-device-name developer-mfa \
  --outfile QRCode.png \
  --bootstrap-method QRCodePNG

# Enable MFA for user
aws iam enable-mfa-device \
  --user-name developer \
  --serial-number arn:aws:iam::123456789012:mfa/developer-mfa \
  --authentication-code-1 123456 \
  --authentication-code-2 789012
```

### Require MFA

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "false"
        }
      }
    }
  ]
}
```

## 🔍 Access Control

### Policy Conditions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*",
      "Condition": {
        "DateGreaterThan": {
          "aws:CurrentTime": "2024-01-01T00:00:00Z"
        },
        "DateLessThan": {
          "aws:CurrentTime": "2024-12-31T23:59:59Z"
        }
      }
    }
  ]
}
```

### IP Restrictions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ["203.0.113.0/24", "198.51.100.0/24"]
        }
      }
    }
  ]
}
```

## 🎯 Best Practices

1. **Least Privilege**: Grant minimum required permissions
2. **Use Roles**: Use roles for EC2, Lambda, etc.
3. **MFA**: Enable MFA for sensitive operations
4. **Regular Reviews**: Review permissions regularly
5. **Policy Versioning**: Use policy versions
6. **Access Analyzer**: Use for permission analysis
7. **Credentials Rotation**: Rotate access keys regularly

## 🔄 Access Analyzer

```bash
# Create access analyzer
aws accessanalyzer create-analyzer \
  --analyzer-name my-analyzer \
  --type ACCOUNT

# List findings
aws accessanalyzer list-findings \
  --analyzer-arn arn:aws:access-analyzer:us-east-1:123456789012:analyzer/my-analyzer
```

## 📊 IAM Best Practices Checklist

- [ ] Use groups for permissions
- [ ] Enable MFA for users
- [ ] Use roles for services
- [ ] Regular access reviews
- [ ] Rotate credentials
- [ ] Use least privilege
- [ ] Enable CloudTrail
- [ ] Use IAM Access Analyzer

## 🎓 Learning Resources

- IAM Documentation: https://docs.aws.amazon.com/iam/
- IAM Best Practices: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
- IAM Policy Reference: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html

---

**Next**: Learn about [ECS & EKS Containers](./ECS-EKS-CONTAINERS.md)

