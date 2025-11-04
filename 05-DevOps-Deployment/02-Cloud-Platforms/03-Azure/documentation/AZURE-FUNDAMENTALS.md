# Azure Fundamentals

## 📚 Overview

Microsoft Azure is a cloud computing platform providing infrastructure, platform, and software services. Azure offers a comprehensive set of cloud services for building, deploying, and managing applications.

## 🎯 What is Azure?

Azure provides cloud services including computing, analytics, storage, and networking. It supports multiple programming languages, frameworks, and operating systems.

### Key Concepts

- **Subscription**: Billing and access boundary
- **Resource Group**: Container for resources
- **Region**: Geographic location
- **Availability Zone**: Isolated data centers
- **Resource**: Azure service instance

### Core Services

1. **Compute**: Virtual Machines, App Service, Functions
2. **Storage**: Blob Storage, Files, Disks
3. **Databases**: SQL Database, Cosmos DB, MySQL
4. **Networking**: Virtual Network, Load Balancer, VPN
5. **Security**: Azure AD, Key Vault, Security Center
6. **Monitoring**: Monitor, Log Analytics, Application Insights

## 🚀 Getting Started

### Azure Account Setup

```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login
az login

# Set subscription
az account set --subscription "My Subscription"

# Verify configuration
az account show
```

### Resource Group

```bash
# Create resource group
az group create \
  --name myResourceGroup \
  --location eastus

# List resource groups
az group list

# Delete resource group
az group delete --name myResourceGroup
```

## 💻 Virtual Machines

### Create VM

```bash
# Create VM
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image UbuntuLTS \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys

# Create VM with custom configuration
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image UbuntuLTS \
  --size Standard_B2s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --public-ip-sku Standard \
  --nsg myNSG
```

### VM Management

```bash
# List VMs
az vm list

# Get VM details
az vm show \
  --resource-group myResourceGroup \
  --name myVM

# Start VM
az vm start \
  --resource-group myResourceGroup \
  --name myVM

# Stop VM
az vm stop \
  --resource-group myResourceGroup \
  --name myVM

# Delete VM
az vm delete \
  --resource-group myResourceGroup \
  --name myVM
```

## 📦 Storage

### Blob Storage

```bash
# Create storage account
az storage account create \
  --name mystorageaccount \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

# Create container
az storage container create \
  --name mycontainer \
  --account-name mystorageaccount

# Upload blob
az storage blob upload \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./myfile.txt

# Download blob
az storage blob download \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./downloaded-file.txt
```

## 🔐 Azure Active Directory

### Create Service Principal

```bash
# Create service principal
az ad sp create-for-rbac \
  --name myServicePrincipal \
  --role contributor \
  --scopes /subscriptions/{subscription-id}

# Get service principal
az ad sp list --display-name myServicePrincipal
```

## 🌐 Virtual Network

### Create VNet

```bash
# Create virtual network
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name mySubnet \
  --subnet-prefix 10.0.1.0/24

# Create subnet
az network vnet subnet create \
  --resource-group myResourceGroup \
  --vnet-name myVNet \
  --name mySubnet2 \
  --address-prefix 10.0.2.0/24
```

## 📊 Monitoring

### Monitor Metrics

```bash
# List metrics
az monitor metrics list-definitions \
  --resource /subscriptions/{subscription-id}/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM
```

## 🎯 Best Practices

1. **Resource Groups**: Organize resources logically
2. **Tags**: Use tags for organization
3. **Monitoring**: Enable monitoring and logging
4. **Security**: Use Azure AD and Key Vault
5. **Cost Management**: Monitor and optimize costs
6. **Backup**: Regular backups
7. **Documentation**: Document infrastructure

## 🎓 Learning Resources

- Azure Documentation: https://docs.microsoft.com/azure/
- Azure Best Practices: https://docs.microsoft.com/azure/architecture/best-practices/
- Azure Free Account: https://azure.microsoft.com/free/

---

**Next**: Learn about [App Service](./APP-SERVICE.md)

