# Google Cloud Functions

## 📚 Overview

Google Cloud Functions is a serverless execution environment for building and connecting cloud services. Functions run code in response to events without managing servers.

## 🎯 What are Cloud Functions?

Cloud Functions lets you run code in response to events without provisioning or managing servers. You pay only for execution time and resources consumed.

### Key Features

- **Serverless**: No server management
- **Event-driven**: Responds to events
- **Auto-scaling**: Automatic scaling
- **Pay-per-use**: Pay only for execution
- **Multiple Languages**: Node.js, Python, Go, Java, .NET

### Use Cases

- **HTTP Functions**: RESTful APIs
- **Background Functions**: Event processing
- **Cloud Storage**: Process file uploads
- **Pub/Sub**: Message processing
- **Firebase**: Firebase event handling

## 🚀 Creating Functions

### HTTP Function (Node.js)

```javascript
// index.js
exports.helloWorld = (req, res) => {
  const name = req.query.name || req.body.name || 'World';
  res.send(`Hello ${name}!`);
};
```

```bash
# Deploy function
gcloud functions deploy helloWorld \
  --runtime nodejs18 \
  --trigger-http \
  --allow-unauthenticated \
  --entry-point helloWorld
```

### HTTP Function (Python)

```python
# main.py
def hello_world(request):
    name = request.args.get('name', 'World')
    return f'Hello {name}!'
```

```bash
# Deploy function
gcloud functions deploy hello_world \
  --runtime python311 \
  --trigger-http \
  --allow-unauthenticated \
  --entry-point hello_world
```

### Cloud Storage Trigger

```javascript
// index.js
exports.processFile = (file, context) => {
  console.log(`Processing file: ${file.name}`);
  console.log(`Event type: ${context.eventType}`);
  console.log(`Bucket: ${file.bucket}`);
};
```

```bash
# Deploy with storage trigger
gcloud functions deploy processFile \
  --runtime nodejs18 \
  --trigger-bucket my-bucket \
  --entry-point processFile
```

### Pub/Sub Trigger

```javascript
// index.js
exports.processMessage = (message, context) => {
  const data = Buffer.from(message.data, 'base64').toString();
  console.log(`Message: ${data}`);
  console.log(`Attributes:`, message.attributes);
};
```

```bash
# Deploy with Pub/Sub trigger
gcloud functions deploy processMessage \
  --runtime nodejs18 \
  --trigger-topic my-topic \
  --entry-point processMessage
```

## 🔧 Function Configuration

### Environment Variables

```bash
# Set environment variables
gcloud functions deploy myFunction \
  --set-env-vars KEY1=value1,KEY2=value2

# Update environment variables
gcloud functions deploy myFunction \
  --update-env-vars KEY1=newvalue
```

### Memory and Timeout

```bash
# Set memory (128MB to 8GB)
gcloud functions deploy myFunction \
  --memory 512MB

# Set timeout (1s to 540s)
gcloud functions deploy myFunction \
  --timeout 60s
```

### VPC Connector

```bash
# Connect to VPC
gcloud functions deploy myFunction \
  --vpc-connector my-connector \
  --egress-settings private-ranges-only
```

## 🔐 Security

### Authentication

```bash
# Require authentication
gcloud functions deploy myFunction \
  --runtime nodejs18 \
  --trigger-http \
  --no-allow-unauthenticated

# Invoke with authentication
gcloud functions call myFunction \
  --data '{"name":"World"}'
```

### Service Account

```bash
# Use service account
gcloud functions deploy myFunction \
  --service-account my-sa@PROJECT_ID.iam.gserviceaccount.com
```

## 📊 Monitoring

### Cloud Logging

```bash
# View logs
gcloud functions logs read myFunction

# View logs with filter
gcloud functions logs read myFunction --filter="severity>=ERROR"
```

### Cloud Monitoring

```bash
# View metrics
gcloud monitoring metrics list --filter="resource.type=cloud_function"
```

## 🔄 Function Management

### List Functions

```bash
# List functions
gcloud functions list

# Get function details
gcloud functions describe myFunction
```

### Update Function

```bash
# Update function code
gcloud functions deploy myFunction \
  --source . \
  --runtime nodejs18
```

### Delete Function

```bash
# Delete function
gcloud functions delete myFunction
```

## 🎯 Best Practices

1. **Stateless**: Keep functions stateless
2. **Idempotency**: Make functions idempotent
3. **Error Handling**: Implement proper error handling
4. **Timeouts**: Set appropriate timeouts
5. **Memory**: Right-size memory allocation
6. **Cold Starts**: Minimize cold start time
7. **Monitoring**: Use Cloud Logging and Monitoring

## 🎓 Learning Resources

- Cloud Functions Documentation: https://cloud.google.com/functions/docs
- Best Practices: https://cloud.google.com/functions/docs/best-practices
- Serverless: https://cloud.google.com/serverless

---

**Next**: Learn about [VPC Networking](./VPC-NETWORKING.md)

