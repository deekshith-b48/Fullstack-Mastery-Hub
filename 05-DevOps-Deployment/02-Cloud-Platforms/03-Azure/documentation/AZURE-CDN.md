# Azure CDN

## 📚 Overview

Azure Content Delivery Network (CDN) delivers content to users with high availability and performance. It caches content at edge locations close to users worldwide.

## 🎯 CDN Fundamentals

### Key Features

- **Global Edge Locations**: Content cached worldwide
- **High Performance**: Low latency delivery
- **Security**: DDoS protection, HTTPS
- **Analytics**: Usage analytics and reporting
- **Customization**: Custom rules and policies

### CDN Providers

- **Standard Microsoft**: Microsoft's CDN
- **Standard Verizon**: Verizon CDN
- **Standard Akamai**: Akamai CDN

## 🚀 Creating CDN Profile

### Create CDN Profile

```bash
# Create CDN profile
az cdn profile create \
  --resource-group myResourceGroup \
  --name myCDNProfile \
  --sku Standard_Microsoft

# Create endpoint
az cdn endpoint create \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myCDNEndpoint \
  --origin www.example.com \
  --origin-host-header www.example.com
```

### Storage Account Origin

```bash
# Create endpoint with storage account
az cdn endpoint create \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myStorageEndpoint \
  --origin mystorageaccount.blob.core.windows.net \
  --origin-host-header mystorageaccount.blob.core.windows.net
```

## 🔧 Configuration

### Custom Domain

```bash
# Add custom domain
az cdn custom-domain create \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --endpoint-name myCDNEndpoint \
  --hostname www.example.com

# Enable HTTPS
az cdn custom-domain enable-https \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --endpoint-name myCDNEndpoint \
  --custom-domain-name www.example.com
```

### Caching Rules

```bash
# Create caching rule
az cdn endpoint rule add \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --endpoint-name myCDNEndpoint \
  --rule-name "CacheStatic" \
  --action-name "CacheExpiration" \
  --cache-duration 3600 \
  --match-variable "RequestUri" \
  --operator "Contains" \
  --match-values "static"
```

## 🔄 Content Purge

### Purge Content

```bash
# Purge all content
az cdn endpoint purge \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myCDNEndpoint \
  --content-paths "/*"

# Purge specific paths
az cdn endpoint purge \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myCDNEndpoint \
  --content-paths "/images/*" "/css/*"
```

### Load Content

```bash
# Preload content
az cdn endpoint load \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myCDNEndpoint \
  --content-paths "/index.html" "/images/logo.png"
```

## 🔐 Security

### HTTPS

```bash
# Enable HTTPS
az cdn custom-domain enable-https \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --endpoint-name myCDNEndpoint \
  --custom-domain-name www.example.com \
  --min-tls-version 1.2
```

### WAF Integration

```bash
# Enable WAF
az cdn endpoint update \
  --resource-group myResourceGroup \
  --profile-name myCDNProfile \
  --name myCDNEndpoint \
  --enable-waf
```

## 📊 Monitoring

### Metrics

```bash
# View CDN metrics
az monitor metrics list \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Cdn/profiles/myCDNProfile/endpoints/myCDNEndpoint \
  --metric "BytesDownloaded"
```

## 🎯 Best Practices

1. **Caching**: Configure appropriate cache rules
2. **HTTPS**: Enable HTTPS for all endpoints
3. **Compression**: Enable compression
4. **Monitoring**: Monitor CDN performance
5. **Purge Strategy**: Minimize purges
6. **Custom Domains**: Use custom domains
7. **Security**: Enable WAF for protection

## 🎓 Learning Resources

- CDN Documentation: https://docs.microsoft.com/azure/cdn/
- Best Practices: https://docs.microsoft.com/azure/cdn/cdn-best-practices
- CDN: https://azure.microsoft.com/services/cdn/

---

**Next**: Learn about [Azure Best Practices](./AZURE-BEST-PRACTICES.md)

