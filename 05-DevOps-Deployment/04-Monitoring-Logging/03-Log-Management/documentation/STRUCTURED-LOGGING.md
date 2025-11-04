# Structured Logging

## 📚 Overview

Structured logging uses a consistent format (typically JSON) for log entries, making logs easier to parse, search, and analyze.

## 🎯 Structured Logging Fundamentals

### What is Structured Logging?

Structured logging formats logs as structured data (JSON, key-value pairs) rather than free-form text, enabling better parsing and analysis.

### Benefits

- **Parsing**: Easy to parse
- **Search**: Better search capabilities
- **Analysis**: Easier analysis
- **Correlation**: Better correlation
- **Automation**: Easier automation

## 🚀 Implementation

### JSON Logging

```javascript
// Node.js with Winston
const winston = require('winston');

const logger = winston.createLogger({
  format: winston.format.json(),
  transports: [
    new winston.transports.Console()
  ]
});

logger.info('Request processed', {
  method: 'GET',
  path: '/api/users',
  statusCode: 200,
  duration: 45,
  userId: '123'
});
```

### Python Structured Logging

```python
# Python with structlog
import structlog

logger = structlog.get_logger()

logger.info("Request processed",
    method="GET",
    path="/api/users",
    status_code=200,
    duration=45,
    user_id="123"
)
```

### Java Structured Logging

```java
// Java with Logback
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import net.logstash.logback.encoder.LogstashEncoder;

Logger logger = LoggerFactory.getLogger(MyClass.class);

logger.info("Request processed",
    kv("method", "GET"),
    kv("path", "/api/users"),
    kv("statusCode", 200),
    kv("duration", 45),
    kv("userId", "123")
);
```

## 📊 Log Schema

### Standard Fields

```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "info",
  "service": "api",
  "message": "Request processed",
  "method": "GET",
  "path": "/api/users",
  "statusCode": 200,
  "duration": 45,
  "userId": "123"
}
```

### Context Fields

```json
{
  "traceId": "abc123",
  "spanId": "def456",
  "userId": "123",
  "requestId": "req-789",
  "environment": "production"
}
```

## 🔍 Log Analysis

### Querying Structured Logs

```bash
# Elasticsearch query
GET /logs/_search
{
  "query": {
    "bool": {
      "must": [
        { "match": { "level": "error" } },
        { "range": { "statusCode": { "gte": 500 } } }
      ]
    }
  }
}
```

### Aggregations

```bash
# Aggregate by field
GET /logs/_search
{
  "aggs": {
    "errors_by_service": {
      "terms": { "field": "service" }
    }
  }
}
```

## 🎯 Best Practices

1. **Consistency**: Use consistent schema
2. **Context**: Include relevant context
3. **Levels**: Use appropriate log levels
4. **Performance**: Don't log too much
5. **Security**: Don't log sensitive data
6. **Documentation**: Document schema
7. **Validation**: Validate log structure

## 🎓 Learning Resources

- Structured Logging: https://www.elastic.co/guide/en/ecs/current/index.html
- Best Practices: https://www.datadoghq.com/blog/logging-best-practices/
- JSON Logging: https://www.loggly.com/ultimate-guide/structured-logging/

---

**Next**: Learn about [Log Analysis Techniques](./LOG-ANALYSIS-TECHNIQUES.md)

