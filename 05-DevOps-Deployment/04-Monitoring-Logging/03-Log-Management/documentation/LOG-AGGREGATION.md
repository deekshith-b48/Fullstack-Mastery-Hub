# Log Aggregation

## 📚 Overview

Log aggregation centralizes logs from multiple sources into a single location for analysis, monitoring, and storage.

## 🎯 Aggregation Fundamentals

### What is Log Aggregation?

Log aggregation collects logs from distributed systems and centralizes them for analysis, making it easier to troubleshoot and monitor applications.

### Benefits

- **Centralization**: Single location for logs
- **Analysis**: Easier analysis
- **Correlation**: Correlate logs across services
- **Storage**: Efficient storage
- **Search**: Fast search capabilities

## 🚀 Aggregation Tools

### Fluentd

```bash
# Install Fluentd
gem install fluentd

# Configure Fluentd
# fluent.conf
<source>
  @type tail
  path /var/log/app.log
  pos_file /var/log/app.log.pos
  tag app.logs
</source>

<match app.logs>
  @type elasticsearch
  host localhost
  port 9200
  index_name app-logs
</match>
```

### Fluent Bit

```bash
# Install Fluent Bit
wget https://github.com/fluent/fluent-bit/releases/download/v2.2.0/fluent-bit-2.2.0-linux-amd64.tar.gz
tar -xzf fluent-bit-2.2.0-linux-amd64.tar.gz

# Run Fluent Bit
./fluent-bit -c fluent-bit.conf
```

### Filebeat

```bash
# Install Filebeat
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.10.0-amd64.deb
sudo dpkg -i filebeat-8.10.0-amd64.deb

# Configure Filebeat
# /etc/filebeat/filebeat.yml
```

## 📊 Aggregation Patterns

### Centralized Aggregation

```bash
# All logs sent to central server
# Simple setup
# Single point of failure
```

### Distributed Aggregation

```bash
# Aggregation at multiple levels
# More resilient
# Complex setup
```

## 🎯 Best Practices

1. **Structure**: Structure logs consistently
2. **Parsing**: Parse logs properly
3. **Enrichment**: Enrich logs with context
4. **Routing**: Route logs appropriately
5. **Performance**: Optimize aggregation
6. **Documentation**: Document setup
7. **Monitoring**: Monitor aggregation health

## 🎓 Learning Resources

- Log Aggregation: https://www.elastic.co/guide/en/beats/filebeat/current/index.html
- Fluentd: https://docs.fluentd.org/
- Best Practices: https://www.datadoghq.com/knowledge-center/log-management/log-aggregation/

---

**Next**: Learn about [Log Rotation Strategies](./LOG-ROTATION-STRATEGIES.md)

