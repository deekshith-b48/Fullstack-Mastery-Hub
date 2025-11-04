# AWS CloudWatch Logs

## 📚 Overview

AWS CloudWatch Logs is a service for monitoring, storing, and accessing log files from AWS resources and applications.

## 🎯 CloudWatch Logs Features

### Key Features

- **Log Collection**: Collect logs from various sources
- **Log Storage**: Store logs securely
- **Log Analysis**: Analyze logs with Insights
- **Log Streaming**: Real-time log streaming
- **Alerts**: Alert on log patterns

## 🚀 Getting Started

### Create Log Group

```bash
# Create log group
aws logs create-log-group \
  --log-group-name /aws/lambda/my-function

# Create log stream
aws logs create-log-stream \
  --log-group-name /aws/lambda/my-function \
  --log-stream-name stream1
```

### Send Logs

```bash
# Put log events
aws logs put-log-events \
  --log-group-name /aws/lambda/my-function \
  --log-stream-name stream1 \
  --log-events \
    timestamp=$(date +%s)000,message="Log message"
```

## 📊 Log Insights

### Query Logs

```bash
# Query logs
aws logs start-query \
  --log-group-name /aws/lambda/my-function \
  --start-time $(date -d '1 hour ago' +%s) \
  --end-time $(date +%s) \
  --query-string "fields @timestamp, @message | filter @message like /error/"
```

### CloudWatch Logs Insights

```sql
-- Query logs
fields @timestamp, @message
| filter @message like /error/
| sort @timestamp desc
| limit 100

-- Aggregate logs
fields @timestamp, @message
| stats count() by bin(5m)
```

## 🔔 Alerts

### Metric Filters

```bash
# Create metric filter
aws logs put-metric-filter \
  --log-group-name /aws/lambda/my-function \
  --filter-name error-count \
  --filter-pattern "[timestamp, request_id, level=ERROR]" \
  --metric-transformations \
    metricName=ErrorCount,metricNamespace=MyApp,metricValue=1
```

## 🎯 Best Practices

1. **Log Groups**: Organize logs by application
2. **Retention**: Set retention policies
3. **Insights**: Use Logs Insights
4. **Alerts**: Set up metric filters
5. **Cost**: Monitor log costs
6. **Documentation**: Document logging
7. **Security**: Secure log access

## 🎓 Learning Resources

- CloudWatch Logs: https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/
- Logs Insights: https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html
- Best Practices: https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html

---

**Next**: Learn about [Log Aggregation](./LOG-AGGREGATION.md)

