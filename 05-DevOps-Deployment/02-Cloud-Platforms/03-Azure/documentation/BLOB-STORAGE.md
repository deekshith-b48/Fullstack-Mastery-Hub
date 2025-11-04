# Azure Blob Storage

## 📚 Overview

Azure Blob Storage is Microsoft's object storage solution for the cloud. It's optimized for storing massive amounts of unstructured data such as text or binary data.

## 🎯 Blob Storage Fundamentals

### Key Concepts

- **Storage Account**: Container for all Azure Storage data
- **Container**: Logical grouping of blobs (like folders)
- **Blob**: Individual file stored in blob storage
- **Access Tier**: Hot, Cool, Archive for cost optimization
- **Replication**: Data redundancy options

### Blob Types

- **Block Blobs**: For text and binary data (up to ~5 TB)
- **Append Blobs**: For append operations (logging)
- **Page Blobs**: For random read/write operations (VHDs)

## 🚀 Storage Account Operations

### Create Storage Account

```bash
# Create storage account
az storage account create \
  --name mystorageaccount \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

# Create with specific configuration
az storage account create \
  --name mystorageaccount \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_GRS \
  --kind StorageV2 \
  --access-tier Hot \
  --https-only true
```

### Storage Account Types

- **Standard_LRS**: Locally redundant storage
- **Standard_GRS**: Geo-redundant storage
- **Standard_RAGRS**: Read-access geo-redundant storage
- **Premium_LRS**: Premium locally redundant storage

## 📦 Container Operations

### Create Container

```bash
# Create container
az storage container create \
  --name mycontainer \
  --account-name mystorageaccount \
  --auth-mode login

# Create with public access
az storage container create \
  --name mypubliccontainer \
  --account-name mystorageaccount \
  --public-access blob \
  --auth-mode login

# List containers
az storage container list \
  --account-name mystorageaccount \
  --auth-mode login
```

## 📄 Blob Operations

### Upload Blobs

```bash
# Upload file
az storage blob upload \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./myfile.txt \
  --auth-mode login

# Upload directory
az storage blob upload-batch \
  --account-name mystorageaccount \
  --destination mycontainer \
  --source ./local-folder \
  --auth-mode login

# Upload with metadata
az storage blob upload \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./myfile.txt \
  --metadata key1=value1 key2=value2 \
  --auth-mode login
```

### Download Blobs

```bash
# Download file
az storage blob download \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./downloaded-file.txt \
  --auth-mode login

# Download directory
az storage blob download-batch \
  --account-name mystorageaccount \
  --destination ./local-folder \
  --source mycontainer \
  --auth-mode login
```

### List Blobs

```bash
# List blobs
az storage blob list \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --auth-mode login

# List with details
az storage blob list \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --output table \
  --auth-mode login
```

### Delete Blobs

```bash
# Delete blob
az storage blob delete \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --auth-mode login

# Delete container
az storage container delete \
  --account-name mystorageaccount \
  --name mycontainer \
  --auth-mode login
```

## 💰 Access Tiers

### Hot Tier

```bash
# Set blob to hot tier
az storage blob set-tier \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --tier Hot \
  --auth-mode login
```

### Cool Tier

```bash
# Set blob to cool tier
az storage blob set-tier \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --tier Cool \
  --auth-mode login
```

### Archive Tier

```bash
# Set blob to archive tier
az storage blob set-tier \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --tier Archive \
  --auth-mode login
```

## 🔐 Security

### Shared Access Signatures (SAS)

```bash
# Generate SAS token
az storage blob generate-sas \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --permissions r \
  --expiry 2024-12-31T23:59:59Z \
  --auth-mode login
```

### Access Policies

```bash
# Create stored access policy
az storage container policy create \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name mypolicy \
  --permissions r \
  --expiry 2024-12-31T23:59:59Z \
  --auth-mode login
```

## 🔄 Lifecycle Management

### Lifecycle Policy

```json
{
  "rules": [
    {
      "name": "MoveToCool",
      "enabled": true,
      "type": "Lifecycle",
      "definition": {
        "filters": {
          "blobTypes": ["blockBlob"],
          "prefixMatch": ["logs/"]
        },
        "actions": {
          "baseBlob": {
            "tierToCool": {
              "daysAfterModificationGreaterThan": 30
            }
          }
        }
      }
    },
    {
      "name": "MoveToArchive",
      "enabled": true,
      "type": "Lifecycle",
      "definition": {
        "filters": {
          "blobTypes": ["blockBlob"],
          "prefixMatch": ["archive/"]
        },
        "actions": {
          "baseBlob": {
            "tierToArchive": {
              "daysAfterModificationGreaterThan": 90
            }
          }
        }
      }
    }
  ]
}
```

```bash
# Apply lifecycle policy
az storage account management-policy create \
  --account-name mystorageaccount \
  --policy @lifecycle-policy.json \
  --resource-group myResourceGroup
```

## 🌐 Static Website Hosting

### Enable Static Website

```bash
# Enable static website
az storage blob service-properties update \
  --account-name mystorageaccount \
  --static-website \
  --404-document error.html \
  --index-document index.html \
  --auth-mode login
```

## 📊 Monitoring

### Metrics

```bash
# View storage metrics
az monitor metrics list \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/mystorageaccount \
  --metric "BlobCapacity"
```

## 🎯 Best Practices

1. **Access Tiers**: Use appropriate tiers
2. **Lifecycle Policies**: Automate tier transitions
3. **Security**: Use SAS tokens and access policies
4. **Monitoring**: Monitor usage and costs
5. **Replication**: Choose appropriate redundancy
6. **Versioning**: Enable versioning for critical data
7. **Soft Delete**: Enable soft delete for recovery

## 🎓 Learning Resources

- Blob Storage Documentation: https://docs.microsoft.com/azure/storage/blobs/
- Best Practices: https://docs.microsoft.com/azure/storage/blobs/storage-blob-best-practices
- Blob Storage: https://azure.microsoft.com/services/storage/blobs/

---

**Next**: Learn about [Functions Serverless](./FUNCTIONS-SERVERLESS.md)

