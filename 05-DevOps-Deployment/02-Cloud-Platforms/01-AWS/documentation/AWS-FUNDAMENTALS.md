# AWS Fundamentals

## 📚 Overview

Amazon Web Services (AWS) is a comprehensive cloud computing platform offering a wide range of services for computing, storage, databases, networking, and more. Understanding AWS fundamentals is essential for cloud deployment and management.

## 🎯 What is AWS?

AWS provides on-demand cloud computing platforms and APIs to individuals, companies, and governments. It offers over 200 services covering compute, storage, databases, networking, analytics, machine learning, and more.

### Key Concepts

- **Region**: Geographic area with multiple Availability Zones
- **Availability Zone (AZ)**: Isolated data center within a region
- **EC2**: Elastic Compute Cloud - virtual servers
- **S3**: Simple Storage Service - object storage
- **VPC**: Virtual Private Cloud - isolated network
- **IAM**: Identity and Access Management - security

### Core Services

1. **Compute**: EC2, Lambda, ECS, EKS
2. **Storage**: S3, EBS, EFS, Glacier
3. **Databases**: RDS, DynamoDB, ElastiCache
4. **Networking**: VPC, CloudFront, Route 53
5. **Security**: IAM, KMS, Secrets Manager
6. **Monitoring**: CloudWatch, CloudTrail

## 🚀 Getting Started

### AWS Account Setup

```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS CLI
aws configure
# AWS Access Key ID: [Your Access Key]
# AWS Secret Access Key: [Your Secret Key]
# Default region: us-east-1
# Default output format: json

# Verify configuration
aws sts get-caller-identity
```

### AWS Regions

```bash
# List available regions
aws ec2 describe-regions

# Common regions
# us-east-1 (N. Virginia)
# us-west-2 (Oregon)
# eu-west-1 (Ireland)
# ap-southeast-1 (Singapore)
```

## 💻 EC2 Basics

### Launch EC2 Instance

```bash
# List available instance types
aws ec2 describe-instance-types

# Launch instance
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --key-name my-key-pair \
  --security-group-ids sg-12345678 \
  --subnet-id subnet-12345678 \
  --count 1

# List instances
aws ec2 describe-instances

# Terminate instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

### EC2 Instance Types

- **t2/t3**: General purpose, burstable
- **m5/m6i**: General purpose, balanced
- **c5/c6i**: Compute optimized
- **r5/r6i**: Memory optimized
- **g4**: GPU instances
- **i3**: Storage optimized

## 📦 S3 Basics

### S3 Operations

```bash
# Create bucket
aws s3 mb s3://my-bucket-name

# List buckets
aws s3 ls

# Upload file
aws s3 cp file.txt s3://my-bucket-name/

# Download file
aws s3 cp s3://my-bucket-name/file.txt .

# Sync directory
aws s3 sync ./local-folder s3://my-bucket-name/folder/

# Delete object
aws s3 rm s3://my-bucket-name/file.txt

# Delete bucket
aws s3 rb s3://my-bucket-name --force
```

### S3 Storage Classes

- **Standard**: General purpose, frequently accessed
- **Intelligent-Tiering**: Automatic cost optimization
- **Standard-IA**: Infrequently accessed
- **One Zone-IA**: Single AZ, infrequently accessed
- **Glacier**: Archive storage
- **Deep Archive**: Lowest cost archive

## 🔐 IAM Basics

### IAM Users

```bash
# Create IAM user
aws iam create-user --user-name developer

# Create access key
aws iam create-access-key --user-name developer

# Attach policy
aws iam attach-user-policy \
  --user-name developer \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

# List users
aws iam list-users
```

### IAM Roles

```bash
# Create role
aws iam create-role \
  --role-name ec2-role \
  --assume-role-policy-document file://trust-policy.json

# Attach policy to role
aws iam attach-role-policy \
  --role-name ec2-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```

### IAM Policies

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

## 🌐 VPC Basics

### VPC Components

- **VPC**: Virtual network
- **Subnet**: Segment of VPC
- **Internet Gateway**: Internet access
- **NAT Gateway**: Outbound internet for private subnets
- **Route Table**: Routing rules
- **Security Group**: Firewall rules

### Create VPC

```bash
# Create VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Create subnet
aws ec2 create-subnet \
  --vpc-id vpc-12345678 \
  --cidr-block 10.0.1.0/24

# Create internet gateway
aws ec2 create-internet-gateway

# Attach internet gateway
aws ec2 attach-internet-gateway \
  --internet-gateway-id igw-12345678 \
  --vpc-id vpc-12345678
```

## 📊 CloudWatch

### CloudWatch Metrics

```bash
# List metrics
aws cloudwatch list-metrics --namespace AWS/EC2

# Get metric statistics
aws cloudwatch get-metric-statistics \
  --namespace AWS/EC2 \
  --metric-name CPUUtilization \
  --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Average
```

### CloudWatch Logs

```bash
# Create log group
aws logs create-log-group --log-group-name /aws/ec2/my-app

# Put log events
aws logs put-log-events \
  --log-group-name /aws/ec2/my-app \
  --log-stream-name stream1 \
  --log-events timestamp=1234567890000,message="Log message"
```

## 🎯 Best Practices

1. **Use IAM**: Implement least privilege
2. **Multi-AZ**: Deploy across Availability Zones
3. **Backup**: Regular backups
4. **Monitoring**: Use CloudWatch
5. **Cost Optimization**: Right-size resources
6. **Security**: Enable security features
7. **Tagging**: Use consistent tagging strategy

## 📚 Learning Resources

- AWS Documentation: https://docs.aws.amazon.com/
- AWS Well-Architected: https://aws.amazon.com/architecture/well-architected/
- AWS Free Tier: https://aws.amazon.com/free/

---

**Next**: Learn about [EC2 Compute](./EC2-COMPUTE.md)

