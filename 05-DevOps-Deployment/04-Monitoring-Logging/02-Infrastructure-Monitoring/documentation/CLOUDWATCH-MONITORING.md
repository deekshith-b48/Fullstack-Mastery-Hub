# AWS CloudWatch Monitoring

## 📚 Overview

Amazon CloudWatch is a monitoring and observability service for AWS resources and applications. It provides metrics, logs, and alarms for comprehensive monitoring.

## 🎯 CloudWatch Fundamentals

### Key Features

- **Metrics**: Collect and track metrics
- **Logs**: Centralized log management
- **Alarms**: Set up alarms
- **Dashboards**: Create dashboards
- **Insights**: Query logs with Insights

## 🚀 Getting Started

### CloudWatch Agent

```bash
# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm

# Configure agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-linux -s
```

### Metrics Collection

```bash
# View metrics
aws cloudwatch get-metric-statistics \
  --namespace AWS/EC2 \
  --metric-name CPUUtilization \
  --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Average
```

## 📊 Custom Metrics

### Publish Custom Metrics

```bash
# Publish custom metric
aws cloudwatch put-metric-data \
  --namespace MyApp \
  --metric-name CustomMetric \
  --value 100 \
  --unit Count
```

## 🔔 Alarms

### Create Alarm

```bash
# Create alarm
aws cloudwatch put-metric-alarm \
  --alarm-name high-cpu \
  --alarm-description "Alarm when CPU exceeds 80 percent" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2
```

## 📈 Dashboards

### Create Dashboard

```bash
# Create dashboard
aws cloudwatch put-dashboard \
  --dashboard-name my-dashboard \
  --dashboard-body file://dashboard.json
```

## 🎯 Best Practices

1. **Metrics**: Collect relevant metrics
2. **Alarms**: Set meaningful alarms
3. **Dashboards**: Create useful dashboards
4. **Logs**: Centralize logs
5. **Cost**: Monitor CloudWatch costs
6. **Documentation**: Document monitoring setup
7. **Optimization**: Optimize monitoring

## 🎓 Learning Resources

- CloudWatch: https://docs.aws.amazon.com/cloudwatch/
- Metrics: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html
- Alarms: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html

---

**Next**: Learn about [Stackdriver Monitoring](./STACKDRIVER-MONITORING.md)

