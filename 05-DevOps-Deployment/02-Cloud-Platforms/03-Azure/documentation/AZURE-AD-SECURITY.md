# Azure Active Directory Security

## 📚 Overview

Azure Active Directory (Azure AD) is Microsoft's cloud-based identity and access management service. It provides single sign-on, multi-factor authentication, and conditional access.

## 🎯 Azure AD Fundamentals

### Key Concepts

- **Tenant**: Organization's Azure AD instance
- **User**: Individual with access
- **Group**: Collection of users
- **Application**: App registration
- **Service Principal**: Identity for applications

## 👥 User Management

### Create User

```bash
# Create user
az ad user create \
  --display-name "John Doe" \
  --user-principal-name john.doe@example.com \
  --password "MyPassword123!" \
  --force-change-password-next-sign-in true

# List users
az ad user list

# Get user
az ad user show --id john.doe@example.com

# Delete user
az ad user delete --id john.doe@example.com
```

### Groups

```bash
# Create group
az ad group create \
  --display-name "Developers" \
  --mail-nickname "developers"

# Add user to group
az ad group member add \
  --group "Developers" \
  --member-id {user-object-id}

# List group members
az ad group member list --group "Developers"
```

## 🔐 Role-Based Access Control (RBAC)

### Assign Role

```bash
# Assign role to user
az role assignment create \
  --assignee john.doe@example.com \
  --role "Contributor" \
  --scope /subscriptions/{subscription-id}/resourceGroups/myResourceGroup

# List role assignments
az role assignment list --assignee john.doe@example.com

# Remove role assignment
az role assignment delete \
  --assignee john.doe@example.com \
  --role "Contributor" \
  --scope /subscriptions/{subscription-id}/resourceGroups/myResourceGroup
```

### Custom Roles

```json
{
  "Name": "Custom Storage Role",
  "Description": "Custom role for storage operations",
  "Actions": [
    "Microsoft.Storage/storageAccounts/blobServices/containers/read",
    "Microsoft.Storage/storageAccounts/blobServices/containers/write"
  ],
  "NotActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscription-id}"
  ]
}
```

```bash
# Create custom role
az role definition create --role-definition @role-definition.json
```

## 🔒 Multi-Factor Authentication (MFA)

### Enable MFA

```bash
# Enable MFA for user
az ad user update \
  --id john.doe@example.com \
  --strong-authentication-details mfa=Enabled
```

### Conditional Access

```bash
# Create conditional access policy
# Configured through Azure Portal or Microsoft Graph API
```

## 🎭 Service Principals

### Create Service Principal

```bash
# Create service principal
az ad sp create-for-rbac \
  --name myServicePrincipal \
  --role contributor \
  --scopes /subscriptions/{subscription-id}

# Create with specific role
az ad sp create-for-rbac \
  --name myServicePrincipal \
  --role "Storage Blob Data Contributor" \
  --scopes /subscriptions/{subscription-id}/resourceGroups/myResourceGroup
```

## 🔍 Application Registration

### Register Application

```bash
# Register application
az ad app create \
  --display-name "My Application" \
  --web-redirect-uris "https://myapp.com/callback"

# Create service principal for app
az ad sp create --id {app-id}
```

## 🎯 Best Practices

1. **MFA**: Enable for all users
2. **Least Privilege**: Grant minimum required permissions
3. **Regular Reviews**: Review access regularly
4. **Conditional Access**: Implement conditional access
5. **Service Principals**: Use for applications
6. **Audit Logging**: Enable audit logging
7. **Password Policy**: Enforce strong passwords

## 🎓 Learning Resources

- Azure AD Documentation: https://docs.microsoft.com/azure/active-directory/
- RBAC: https://docs.microsoft.com/azure/role-based-access-control/
- Best Practices: https://docs.microsoft.com/azure/active-directory/fundamentals/security-best-practices

---

**Next**: Learn about [AKS Containers](./AKS-CONTAINERS.md)

