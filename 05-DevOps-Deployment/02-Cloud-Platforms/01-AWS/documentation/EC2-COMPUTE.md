# AWS EC2 Compute

## 📚 Overview

Amazon Elastic Compute Cloud (EC2) provides resizable compute capacity in the cloud. EC2 instances are virtual servers that can be launched, configured, and managed with flexibility and control.

## 🎯 EC2 Instance Types

### General Purpose

- **t2/t3/t4g**: Burstable performance, cost-effective
  - t2.micro: 1 vCPU, 1 GB RAM
  - t3.medium: 2 vCPU, 4 GB RAM
- **m5/m6i**: Balanced compute, memory, and networking
  - m5.large: 2 vCPU, 8 GB RAM
  - m6i.xlarge: 4 vCPU, 16 GB RAM

### Compute Optimized

- **c5/c6i**: High-performance processors
  - c5.large: 2 vCPU, 4 GB RAM
  - c6i.xlarge: 4 vCPU, 8 GB RAM

### Memory Optimized

- **r5/r6i**: High memory-to-vCPU ratio
  - r5.large: 2 vCPU, 16 GB RAM
  - r6i.xlarge: 4 vCPU, 32 GB RAM

### Storage Optimized

- **i3/i4i**: High IOPS storage
  - i3.large: 2 vCPU, 15.25 GB RAM, 475 GB NVMe SSD

## 🚀 Launching Instances

### Using AWS CLI

```bash
# Launch instance
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --key-name my-key-pair \
  --security-group-ids sg-12345678 \
  --subnet-id subnet-12345678 \
  --count 1 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=my-instance}]'

# Launch with user data
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --user-data file://user-data.sh \
  --key-name my-key-pair
```

### User Data Script

```bash
#!/bin/bash
# user-data.sh
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
```

### Launch Template

```json
{
  "LaunchTemplateName": "my-template",
  "LaunchTemplateData": {
    "ImageId": "ami-0c55b159cbfafe1f0",
    "InstanceType": "t2.micro",
    "KeyName": "my-key-pair",
    "SecurityGroupIds": ["sg-12345678"],
    "UserData": "IyEvYmluL2Jhc2gK..."
  }
}
```

```bash
# Create launch template
aws ec2 create-launch-template \
  --launch-template-name my-template \
  --launch-template-data file://template-data.json

# Launch from template
aws ec2 run-instances \
  --launch-template LaunchTemplateName=my-template
```

## 💾 Storage Options

### EBS Volumes

```bash
# Create EBS volume
aws ec2 create-volume \
  --size 20 \
  --volume-type gp3 \
  --availability-zone us-east-1a

# Attach volume
aws ec2 attach-volume \
  --volume-id vol-1234567890abcdef0 \
  --instance-id i-1234567890abcdef0 \
  --device /dev/xvdf

# Create snapshot
aws ec2 create-snapshot \
  --volume-id vol-1234567890abcdef0 \
  --description "Backup snapshot"
```

### Instance Store

```bash
# Instance store volumes (ephemeral)
# Available on instance types: i3, c5d, m5d, etc.
# Data lost on instance termination
```

## 🔐 Security Groups

### Create Security Group

```bash
# Create security group
aws ec2 create-security-group \
  --group-name my-sg \
  --description "My security group" \
  --vpc-id vpc-12345678

# Add inbound rule
aws ec2 authorize-security-group-ingress \
  --group-id sg-12345678 \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

# Add outbound rule
aws ec2 authorize-security-group-egress \
  --group-id sg-12345678 \
  --protocol tcp \
  --port 443 \
  --cidr 0.0.0.0/0
```

### Security Group Rules

```json
{
  "IpProtocol": "tcp",
  "FromPort": 80,
  "ToPort": 80,
  "IpRanges": [
    {
      "CidrIp": "0.0.0.0/0",
      "Description": "HTTP access"
    }
  ]
}
```

## 🔄 Auto Scaling

### Launch Configuration

```bash
# Create launch configuration
aws autoscaling create-launch-configuration \
  --launch-configuration-name my-launch-config \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --key-name my-key-pair \
  --security-groups sg-12345678
```

### Auto Scaling Group

```bash
# Create auto scaling group
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name my-asg \
  --launch-configuration-name my-launch-config \
  --min-size 2 \
  --max-size 10 \
  --desired-capacity 3 \
  --vpc-zone-identifier "subnet-12345678,subnet-87654321"
```

### Scaling Policies

```bash
# Create scaling policy
aws autoscaling put-scaling-policy \
  --auto-scaling-group-name my-asg \
  --policy-name scale-up \
  --policy-type TargetTrackingScaling \
  --target-tracking-configuration '{
    "TargetValue": 70.0,
    "PredefinedMetricSpecification": {
      "PredefinedMetricType": "ASGAverageCPUUtilization"
    }
  }'
```

## 📊 EC2 Instance Management

### Instance Operations

```bash
# Start instance
aws ec2 start-instances --instance-ids i-1234567890abcdef0

# Stop instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Reboot instance
aws ec2 reboot-instances --instance-ids i-1234567890abcdef0

# Terminate instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0

# Get instance status
aws ec2 describe-instances --instance-ids i-1234567890abcdef0
```

### Instance Metadata

```bash
# Access from instance
curl http://169.254.169.254/latest/meta-data/

# Get instance ID
curl http://169.254.169.254/latest/meta-data/instance-id

# Get instance type
curl http://169.254.169.254/latest/meta-data/instance-type

# Get user data
curl http://169.254.169.254/latest/user-data
```

## 🔍 Monitoring and Logging

### CloudWatch Metrics

```bash
# Get CPU utilization
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
# Send logs to CloudWatch
# Configure in EC2 instance
# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
```

## 💰 Cost Optimization

### Spot Instances

```bash
# Request spot instance
aws ec2 request-spot-instances \
  --spot-price "0.05" \
  --instance-count 1 \
  --type "one-time" \
  --launch-specification file://spot-specification.json
```

### Reserved Instances

```bash
# Purchase reserved instance
aws ec2 purchase-reserved-instances-offering \
  --reserved-instances-offering-id <offering-id> \
  --instance-count 1
```

### Savings Plans

```bash
# Create savings plan
aws savingsplans create-savings-plan \
  --savings-plan-offering-id <offering-id> \
  --commitment 1000 \
  --upfront-payment-amount 0
```

## 🎯 Best Practices

1. **Right-sizing**: Choose appropriate instance types
2. **Auto Scaling**: Use for variable workloads
3. **Security Groups**: Implement least privilege
4. **Backup**: Regular EBS snapshots
5. **Monitoring**: Use CloudWatch
6. **Tags**: Consistent tagging strategy
7. **Cost Optimization**: Use Reserved Instances/Savings Plans

## 🎓 Learning Resources

- EC2 Documentation: https://docs.aws.amazon.com/ec2/
- EC2 Instance Types: https://aws.amazon.com/ec2/instance-types/
- EC2 Best Practices: https://aws.amazon.com/ec2/getting-started/

---

**Next**: Learn about [S3 Storage](./S3-STORAGE.md)

