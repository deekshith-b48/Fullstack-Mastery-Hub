# AWS Lambda Serverless

## 📚 Overview

AWS Lambda is a serverless compute service that runs code in response to events and automatically manages the compute resources. Lambda enables you to build applications without provisioning or managing servers.

## 🎯 What is Lambda?

Lambda lets you run code without provisioning or managing servers. You pay only for the compute time you consume. Lambda automatically scales your application by running code in response to each trigger.

### Key Features

- **Serverless**: No server management
- **Auto-scaling**: Automatic scaling
- **Pay-per-use**: Pay only for execution time
- **Event-driven**: Responds to events
- **Multiple Languages**: Node.js, Python, Java, Go, .NET, Ruby

### Use Cases

- **API Backends**: RESTful APIs
- **Data Processing**: Transform and process data
- **Real-time Processing**: Stream processing
- **Scheduled Tasks**: Cron-like jobs
- **File Processing**: Process S3 uploads

## 🚀 Creating Lambda Functions

### Basic Lambda Function (Node.js)

```javascript
// index.js
exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: 'Hello from Lambda!',
            input: event
        })
    };
    return response;
};
```

### Deploy Function

```bash
# Package function
zip function.zip index.js

# Create function
aws lambda create-function \
  --function-name my-function \
  --runtime nodejs18.x \
  --role arn:aws:iam::123456789012:role/lambda-execution-role \
  --handler index.handler \
  --zip-file fileb://function.zip
```

### Python Function

```python
# lambda_function.py
import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda!',
            'input': event
        })
    }
```

```bash
# Create Python function
aws lambda create-function \
  --function-name my-python-function \
  --runtime python3.11 \
  --role arn:aws:iam::123456789012:role/lambda-execution-role \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://function.zip
```

## 🔧 Function Configuration

### Environment Variables

```bash
# Set environment variables
aws lambda update-function-configuration \
  --function-name my-function \
  --environment Variables="{KEY1=value1,KEY2=value2}"
```

### Memory and Timeout

```bash
# Configure memory (128MB to 10GB)
aws lambda update-function-configuration \
  --function-name my-function \
  --memory-size 512

# Configure timeout (up to 900 seconds)
aws lambda update-function-configuration \
  --function-name my-function \
  --timeout 30
```

### VPC Configuration

```bash
# Configure VPC
aws lambda update-function-configuration \
  --function-name my-function \
  --vpc-config SubnetIds=subnet-123,subnet-456,SecurityGroupIds=sg-123
```

## 🔄 Event Sources

### API Gateway

```bash
# Create API Gateway integration
aws apigatewayv2 create-integration \
  --api-id <api-id> \
  --integration-type AWS_PROXY \
  --integration-uri arn:aws:lambda:us-east-1:123456789012:function:my-function
```

### S3 Events

```json
{
  "LambdaFunctionConfigurations": [
    {
      "LambdaFunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:my-function",
      "Events": ["s3:ObjectCreated:*"],
      "Filter": {
        "Key": {
          "FilterRules": [
            {
              "Name": "prefix",
              "Value": "uploads/"
            }
          ]
        }
      }
    }
  ]
}
```

### DynamoDB Streams

```bash
# Create event source mapping
aws lambda create-event-source-mapping \
  --function-name my-function \
  --event-source-arn arn:aws:dynamodb:us-east-1:123456789012:table/my-table/stream/2024-01-01T00:00:00.000 \
  --starting-position LATEST
```

### SQS

```bash
# SQS event source
aws lambda create-event-source-mapping \
  --function-name my-function \
  --event-source-arn arn:aws:sqs:us-east-1:123456789012:my-queue \
  --batch-size 10
```

## 📊 Lambda Layers

### Create Layer

```bash
# Package layer
mkdir python
pip install requests -t python/
zip -r layer.zip python/

# Create layer
aws lambda publish-layer-version \
  --layer-name my-layer \
  --zip-file fileb://layer.zip \
  --compatible-runtimes python3.11
```

### Use Layer

```bash
# Add layer to function
aws lambda update-function-configuration \
  --function-name my-function \
  --layers arn:aws:lambda:us-east-1:123456789012:layer:my-layer:1
```

## 🔐 Security

### IAM Roles

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

### VPC Configuration

```bash
# Lambda in VPC
aws lambda update-function-configuration \
  --function-name my-function \
  --vpc-config SubnetIds=subnet-123,SecurityGroupIds=sg-123
```

## 🔍 Monitoring

### CloudWatch Logs

```bash
# View logs
aws logs tail /aws/lambda/my-function --follow

# Get log streams
aws logs describe-log-streams \
  --log-group-name /aws/lambda/my-function
```

### CloudWatch Metrics

```bash
# Get invocation metrics
aws cloudwatch get-metric-statistics \
  --namespace AWS/Lambda \
  --metric-name Invocations \
  --dimensions Name=FunctionName,Value=my-function \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Sum
```

### X-Ray Tracing

```bash
# Enable X-Ray tracing
aws lambda update-function-configuration \
  --function-name my-function \
  --tracing-config Mode=Active
```

## 🎯 Best Practices

1. **Stateless**: Keep functions stateless
2. **Idempotency**: Make functions idempotent
3. **Error Handling**: Implement proper error handling
4. **Timeouts**: Set appropriate timeouts
5. **Memory**: Right-size memory allocation
6. **Cold Starts**: Minimize cold start time
7. **Monitoring**: Use CloudWatch and X-Ray

## 🎓 Learning Resources

- Lambda Documentation: https://docs.aws.amazon.com/lambda/
- Lambda Best Practices: https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html
- Serverless Applications: https://aws.amazon.com/serverless/

---

**Next**: Learn about [VPC Networking](./VPC-NETWORKING.md)

