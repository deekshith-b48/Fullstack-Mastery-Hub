# Azure Functions Serverless

## 📚 Overview

Azure Functions is a serverless compute service that enables you to run event-driven code without managing infrastructure. Functions automatically scale based on demand.

## 🎯 What are Azure Functions?

Azure Functions lets you run code in response to events without provisioning or managing servers. You pay only for execution time and resources consumed.

### Key Features

- **Serverless**: No server management
- **Event-driven**: Responds to events
- **Auto-scaling**: Automatic scaling
- **Pay-per-use**: Pay only for execution
- **Multiple Languages**: C#, JavaScript, Python, Java, PowerShell

### Use Cases

- **HTTP Triggers**: RESTful APIs
- **Timer Triggers**: Scheduled tasks
- **Blob Triggers**: Process file uploads
- **Queue Triggers**: Process queue messages
- **Event Hub Triggers**: Process streaming data

## 🚀 Creating Functions

### HTTP Function (JavaScript)

```javascript
// index.js
module.exports = async function (context, req) {
    context.log('HTTP trigger function processed a request.');
    
    const name = (req.query.name || (req.body && req.body.name));
    const responseMessage = name
        ? `Hello, ${name}. This HTTP triggered function executed successfully.`
        : 'This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.';
    
    context.res = {
        status: 200,
        body: responseMessage
    };
};
```

```bash
# Deploy function
az functionapp create \
  --resource-group myResourceGroup \
  --consumption-plan-location eastus \
  --runtime node \
  --runtime-version 18 \
  --functions-version 4 \
  --name myFunctionApp \
  --storage-account mystorageaccount
```

### HTTP Function (Python)

```python
# __init__.py
import logging
import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    
    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')
    
    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
            status_code=200
        )
```

### Timer Trigger

```javascript
// index.js
module.exports = async function (context, myTimer) {
    const timeStamp = new Date().toISOString();
    
    if (myTimer.isPastDue) {
        context.log('Timer function is running late!');
    }
    
    context.log('Timer trigger function ran!', timeStamp);
};
```

```json
// function.json
{
  "bindings": [
    {
      "name": "myTimer",
      "type": "timerTrigger",
      "direction": "in",
      "schedule": "0 */5 * * * *"
    }
  ]
}
```

### Blob Trigger

```javascript
// index.js
module.exports = async function (context, myBlob) {
    context.log('Blob trigger function processed blob', 
                context.bindingData.name,
                'Size:', myBlob.length);
};
```

```json
// function.json
{
  "bindings": [
    {
      "name": "myBlob",
      "type": "blobTrigger",
      "direction": "in",
      "path": "samples-workitems/{name}",
      "connection": "AzureWebJobsStorage"
    }
  ]
}
```

## 🔧 Function Configuration

### Application Settings

```bash
# Set app setting
az functionapp config appsettings set \
  --name myFunctionApp \
  --resource-group myResourceGroup \
  --settings KEY1=value1 KEY2=value2

# Get app settings
az functionapp config appsettings list \
  --name myFunctionApp \
  --resource-group myResourceGroup
```

### Connection Strings

```bash
# Set connection string
az functionapp config connection-string set \
  --name myFunctionApp \
  --resource-group myResourceGroup \
  --connection-string-type SQLServer \
  --settings DefaultConnection="Server=..."
```

### Deployment

```bash
# Deploy from local
func azure functionapp publish myFunctionApp

# Deploy from GitHub
az functionapp deployment source config \
  --name myFunctionApp \
  --resource-group myResourceGroup \
  --repo-url https://github.com/user/repo \
  --branch main \
  --manual-integration
```

## 🔐 Security

### Authentication

```bash
# Enable authentication
az functionapp auth update \
  --name myFunctionApp \
  --resource-group myResourceGroup \
  --enabled true \
  --action LoginWithAzureActiveDirectory
```

### Managed Identity

```bash
# Assign managed identity
az functionapp identity assign \
  --name myFunctionApp \
  --resource-group myResourceGroup
```

## 📊 Monitoring

### Application Insights

```bash
# Enable Application Insights
az monitor app-insights component create \
  --app myAppInsights \
  --location eastus \
  --resource-group myResourceGroup

# Connect to function app
az functionapp config appsettings set \
  --name myFunctionApp \
  --resource-group myResourceGroup \
  --settings APPINSIGHTS_INSTRUMENTATIONKEY={instrumentation-key}
```

## 🎯 Best Practices

1. **Stateless**: Keep functions stateless
2. **Idempotency**: Make functions idempotent
3. **Error Handling**: Implement proper error handling
4. **Timeouts**: Set appropriate timeouts
5. **Memory**: Right-size memory allocation
6. **Cold Starts**: Minimize cold start time
7. **Monitoring**: Use Application Insights

## 🎓 Learning Resources

- Functions Documentation: https://docs.microsoft.com/azure/azure-functions/
- Best Practices: https://docs.microsoft.com/azure/azure-functions/functions-best-practices
- Functions: https://azure.microsoft.com/services/functions/

---

**Next**: Learn about [VNet Networking](./VNET-NETWORKING.md)

