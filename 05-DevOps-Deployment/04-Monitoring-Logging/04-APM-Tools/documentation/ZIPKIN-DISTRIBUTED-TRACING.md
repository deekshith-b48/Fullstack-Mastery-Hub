# Zipkin Distributed Tracing

## 📚 Overview

Zipkin is a distributed tracing system that helps gather timing data needed to troubleshoot latency problems in microservice architectures.

## 🎯 Zipkin Fundamentals

### What is Zipkin?

Zipkin collects and looks up timing data for distributed systems. It's particularly useful for understanding the timing behavior of requests in microservices.

### Key Features

- **Distributed Tracing**: Track requests across services
- **Latency Analysis**: Analyze latency issues
- **Service Dependencies**: Understand service relationships
- **Error Tracking**: Track errors in traces

## 🚀 Installation

### Docker

```bash
# Run Zipkin
docker run -d \
  -p 9411:9411 \
  openzipkin/zipkin

# Access UI
# http://localhost:9411
```

### Linux

```bash
# Download Zipkin
curl -sSL https://zipkin.io/quickstart.sh | bash -s
java -jar zipkin.jar
```

## 🔧 Instrumentation

### Node.js

```javascript
const { Tracer } = require('zipkin');
const zipkinMiddleware = require('zipkin-instrumentation-express').expressMiddleware;

const tracer = new Tracer({
  ctxImpl: new HttpContext(),
  recorder: new HttpRecorder({ endpoint: 'http://localhost:9411/api/v2/spans' }),
  localServiceName: 'my-service'
});

app.use(zipkinMiddleware({ tracer }));
```

### Python

```python
from py_zipkin.zipkin import zipkin_span
from py_zipkin.transport import BaseTransportHandler

class HttpTransport(BaseTransportHandler):
    def get_max_payload_bytes(self):
        return None

    def send(self, encoded_span):
        # Send to Zipkin
        pass

with zipkin_span(
    service_name='my-service',
    span_name='operation',
    transport_handler=HttpTransport(),
    sample_rate=1.0
):
    # ... operation
    pass
```

## 📊 Querying Traces

### Zipkin UI

```bash
# Access Zipkin UI
# http://localhost:9411

# Search traces
# Filter by service
# Filter by time range
# View trace details
```

### Trace Analysis

```bash
# View trace timeline
# See span durations
# Identify slow operations
# Analyze dependencies
```

## 🎯 Best Practices

1. **Sampling**: Use appropriate sampling
2. **Tags**: Add meaningful tags
3. **Analysis**: Analyze traces regularly
4. **Documentation**: Document instrumentation
5. **Performance**: Monitor Zipkin performance
6. **Storage**: Configure storage appropriately
7. **Optimization**: Optimize based on findings

## 🎓 Learning Resources

- Zipkin: https://zipkin.io/
- Getting Started: https://zipkin.io/pages/quickstart.html
- Instrumentation: https://zipkin.io/pages/instrumenting.html

---

**Next**: Learn about [Service Mesh Observability](./SERVICE-MESH-OBSERVABILITY.md)

