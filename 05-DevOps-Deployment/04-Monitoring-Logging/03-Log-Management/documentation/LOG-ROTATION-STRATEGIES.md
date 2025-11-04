# Log Rotation Strategies

## 📚 Overview

Log rotation manages log file size and retention, preventing disk space issues while maintaining log history for analysis and compliance.

## 🎯 Log Rotation Fundamentals

### What is Log Rotation?

Log rotation archives or deletes old log files to manage disk space while retaining recent logs for analysis.

### Benefits

- **Disk Space**: Prevent disk space issues
- **Performance**: Maintain log performance
- **Retention**: Retain logs for required period
- **Compliance**: Meet retention requirements

## 🚀 Rotation Strategies

### Time-Based Rotation

```bash
# Rotate daily
# /etc/logrotate.d/app
/var/log/app.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
}
```

### Size-Based Rotation

```bash
# Rotate when size exceeds limit
/var/log/app.log {
    size 100M
    rotate 5
    compress
    missingok
    notifempty
}
```

### Combination

```bash
# Rotate daily or when size exceeds
/var/log/app.log {
    daily
    size 100M
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
}
```

## 🔧 Logrotate Configuration

### Basic Configuration

```bash
# /etc/logrotate.conf
daily
rotate 7
compress
delaycompress
missingok
notifempty
create 0644 root root
```

### Application-Specific

```bash
# /etc/logrotate.d/myapp
/var/log/myapp/*.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    sharedscripts
    postrotate
        /usr/bin/systemctl reload myapp
    endscript
}
```

## 📊 Cloud Log Rotation

### CloudWatch Logs

```bash
# Set retention policy
aws logs put-retention-policy \
  --log-group-name /aws/lambda/my-function \
  --retention-in-days 7
```

### Elasticsearch

```bash
# Index lifecycle management
# Rollover indices
# Delete old indices
```

## 🎯 Best Practices

1. **Retention**: Set appropriate retention
2. **Compression**: Compress old logs
3. **Archiving**: Archive important logs
4. **Automation**: Automate rotation
5. **Monitoring**: Monitor disk usage
6. **Documentation**: Document policies
7. **Compliance**: Meet compliance requirements

## 🎓 Learning Resources

- Log Rotation: https://linux.die.net/man/8/logrotate
- Best Practices: https://www.loggly.com/ultimate-guide/log-rotation/
- Configuration: https://www.loggly.com/blog/log-rotation-best-practices/

---

**Next**: Learn about [Structured Logging](./STRUCTURED-LOGGING.md)

