# Logstash & Beats

## 📚 Overview

Logstash and Beats are part of the Elastic Stack for data ingestion and processing.

## 📥 Logstash

### Installation

```bash
# Install Logstash
sudo apt install logstash

# Start Logstash
sudo systemctl start logstash
```

### Configuration

```ruby
# logstash.conf
input {
  file {
    path => "/var/log/application.log"
    start_position => "beginning"
  }
}

filter {
  grok {
    match => { "message" => "%{TIMESTAMP_ISO8601:timestamp} %{LOGLEVEL:level} %{GREEDYDATA:message}" }
  }
  date {
    match => [ "timestamp", "ISO8601" ]
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
}
```

### Run Logstash

```bash
# Run with config file
bin/logstash -f logstash.conf
```

## 📊 Beats

### Filebeat

```bash
# Install Filebeat
sudo apt install filebeat

# Configure filebeat.yml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/*.log

output.elasticsearch:
  hosts: ["localhost:9200"]
```

### Metricbeat

```bash
# Monitor system metrics
metricbeat modules enable system
metricbeat setup
service metricbeat start
```

## 🎯 Best Practices

1. **Use appropriate beats** for data types
2. **Configure parsing** correctly
3. **Monitor beat performance**
4. **Use filters** to transform data
5. **Handle errors** gracefully

---

**Elasticsearch section complete!** Next: Learn about [Cassandra](./../04-Cassandra/documentation/CASSANDRA-FUNDAMENTALS.md)

