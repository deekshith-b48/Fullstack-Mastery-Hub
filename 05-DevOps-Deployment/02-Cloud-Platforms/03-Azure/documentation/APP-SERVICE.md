# Azure App Service

## 📚 Overview

Azure App Service is a fully managed platform for building, deploying, and scaling web apps and APIs. It supports multiple languages and frameworks including .NET, Node.js, Python, Java, and PHP.

## 🎯 App Service Plans

### Service Plan Types

- **Free**: Development and testing
- **Shared**: Low-cost shared infrastructure
- **Basic**: Dedicated resources, basic scaling
- **Standard**: Production workloads, auto-scaling
- **Premium**: High-performance, advanced features
- **Isolated**: Dedicated network, highest isolation

### Create App Service Plan

```bash
# Create App Service Plan
az appservice plan create \
  --name myAppServicePlan \
  --resource-group myResourceGroup \
  --sku B1 \
  --location eastus

# Create Linux App Service Plan
az appservice plan create \
  --name myLinuxPlan \
  --resource-group myResourceGroup \
  --sku B1 \
  --is-linux \
  --location eastus
```

## 🚀 Web Apps

### Create Web App

```bash
# Create web app
az webapp create \
  --name myWebApp \
  --resource-group myResourceGroup \
  --plan myAppServicePlan

# Create web app with runtime
az webapp create \
  --name myWebApp \
  --resource-group myResourceGroup \
  --plan myAppServicePlan \
  --runtime "NODE:18-lts"

# Create Linux web app
az webapp create \
  --name myLinuxApp \
  --resource-group myResourceGroup \
  --plan myLinuxPlan \
  --runtime "NODE:18-lts"
```

### Deploy Application

```bash
# Deploy from local Git
az webapp deployment source config-local-git \
  --name myWebApp \
  --resource-group myResourceGroup

# Deploy from GitHub
az webapp deployment source config \
  --name myWebApp \
  --resource-group myResourceGroup \
  --repo-url https://github.com/user/repo \
  --branch main \
  --manual-integration

# Deploy from ZIP
az webapp deployment source config-zip \
  --resource-group myResourceGroup \
  --name myWebApp \
  --src app.zip
```

## 🔧 Configuration

### App Settings

```bash
# Set app settings
az webapp config appsettings set \
  --name myWebApp \
  --resource-group myResourceGroup \
  --settings \
    APP_SETTING1=value1 \
    APP_SETTING2=value2

# List app settings
az webapp config appsettings list \
  --name myWebApp \
  --resource-group myResourceGroup
```

### Connection Strings

```bash
# Set connection string
az webapp config connection-string set \
  --name myWebApp \
  --resource-group myResourceGroup \
  --connection-string-type SQLServer \
  --settings DefaultConnection="Server=..."

# List connection strings
az webapp config connection-string list \
  --name myWebApp \
  --resource-group myResourceGroup
```

### Custom Domains

```bash
# Add custom domain
az webapp config hostname add \
  --webapp-name myWebApp \
  --resource-group myResourceGroup \
  --hostname www.example.com

# Bind SSL certificate
az webapp config ssl bind \
  --name myWebApp \
  --resource-group myResourceGroup \
  --certificate-name myCert \
  --ssl-type SNI
```

## 🔄 Scaling

### Manual Scaling

```bash
# Scale up (change plan)
az appservice plan update \
  --name myAppServicePlan \
  --resource-group myResourceGroup \
  --sku S1

# Scale out (add instances)
az appservice plan update \
  --name myAppServicePlan \
  --resource-group myResourceGroup \
  --number-of-workers 3
```

### Auto-Scaling

```bash
# Create auto-scale settings
az monitor autoscale create \
  --name myAutoScale \
  --resource-group myResourceGroup \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Web/serverfarms/myAppServicePlan \
  --min-count 1 \
  --max-count 10 \
  --count 2
```

## 🔐 Security

### Authentication

```bash
# Enable authentication
az webapp auth update \
  --name myWebApp \
  --resource-group myResourceGroup \
  --enabled true \
  --action LoginWithAzureActiveDirectory \
  --aad-client-id {client-id} \
  --aad-client-secret {client-secret} \
  --aad-token-issuer-url https://sts.windows.net/{tenant-id}/
```

### Managed Identity

```bash
# Assign managed identity
az webapp identity assign \
  --name myWebApp \
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

# Connect to web app
az webapp config appsettings set \
  --name myWebApp \
  --resource-group myResourceGroup \
  --settings APPINSIGHTS_INSTRUMENTATIONKEY={instrumentation-key}
```

## 🎯 Best Practices

1. **App Service Plans**: Choose appropriate plan
2. **Scaling**: Configure auto-scaling
3. **Deployment**: Use deployment slots
4. **Monitoring**: Enable Application Insights
5. **Security**: Use managed identities
6. **Backup**: Configure backups
7. **SSL**: Enable HTTPS

## 🎓 Learning Resources

- App Service Documentation: https://docs.microsoft.com/azure/app-service/
- Best Practices: https://docs.microsoft.com/azure/app-service/app-service-best-practices
- App Service: https://azure.microsoft.com/services/app-service/

---

**Next**: Learn about [SQL Database](./SQL-DATABASE.md)

