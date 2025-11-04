# Elastic Stack (ELK)

## 📚 Overview

Elastic Stack (ELK) consists of Elasticsearch, Logstash, and Kibana. It provides a complete solution for log collection, storage, and visualization.

## 🎯 Elastic Stack Components

### Elasticsearch

- **Search Engine**: Distributed search and analytics
- **Storage**: Stores indexed logs
- **Query**: Powerful query capabilities
- **Scalability**: Horizontal scaling

### Logstash

- **Collection**: Collects logs from various sources
- **Processing**: Transforms and enriches logs
- **Output**: Sends to Elasticsearch

### Kibana

- **Visualization**: Creates dashboards
- **Exploration**: Explore log data
- **Analysis**: Analyze patterns

## 🚀 Installation

### Elasticsearch

```bash
# Install Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.10.0-amd64.deb
sudo dpkg -i elasticsearch-8.10.0-amd64.deb

# Start Elasticsearch
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
```

### Logstash

```bash
# Install Logstash
wget https://artifacts.elastic.co/downloads/logstash/logstash-8.10.0-amd64.deb
sudo dpkg -i logstash-8.10.0-amd64.deb

# Start Logstash
sudo systemctl start logstash
```

### Kibana

```bash
# Install Kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.10.0-amd64.deb
sudo dpkg -i kibana-8.10.0-amd64.deb

# Start Kibana
sudo systemctl start kibana
```

## 🔧 Configuration

### Logstash Configuration

```ruby
# logstash.conf
input {
  file {
    path => "/var/log/app.log"
    start_position => "beginning"
  }
}

filter {
  grok {
    match => { "message" => "%{TIMESTAMP_ISO8601:timestamp} %{LOGLEVEL:level} %{GREEDYDATA:message}" }
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
}
```

### Kibana Index Patterns

```bash
# Create index pattern
# Management > Index Patterns > Create
# Pattern: logs-*
# Time field: @timestamp
```

## 📊 Visualization

### Create Dashboards

```bash
# Create visualizations
# Line charts
# Pie charts
# Tables
# Maps
```

### Discover

```bash
# Explore logs
# Search logs
# Filter logs
# Analyze patterns
```

## 🎯 Best Practices

1. **Index Management**: Manage indices properly
2. **Retention**: Set retention policies
3. **Performance**: Optimize queries
4. **Security**: Secure Elastic Stack
5. **Monitoring**: Monitor stack health
6. **Documentation**: Document configurations
7. **Backup**: Regular backups

## 🎓 Learning Resources

- Elastic Stack: https://www.elastic.co/guide/en/elastic-stack/index.html
- Getting Started: https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-elastic-stack.html
- Elastic: https://www.elastic.co/

---

**Next**: Learn about [Loki Logging](./LOKI-LOGGING.md)

