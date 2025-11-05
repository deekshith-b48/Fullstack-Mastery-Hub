# Attribute-Based Access Control (ABAC)

## 📚 Overview

Attribute-Based Access Control (ABAC) makes authorization decisions based on attributes of users, resources, actions, and environment. It provides fine-grained, flexible access control that can adapt to complex business requirements.

## 🎯 ABAC Fundamentals

### ABAC Components

1. **Subject Attributes**: User characteristics (role, department, clearance)
2. **Resource Attributes**: Object characteristics (sensitivity, owner, classification)
3. **Action Attributes**: Operation characteristics (type, time)
4. **Environment Attributes**: Context (time, location, IP)

### ABAC Advantages

- Fine-grained control
- Dynamic policy evaluation
- Context-aware decisions
- Flexible rule definition

## 🔍 ABAC Implementation

### Policy Engine

```javascript
// ABAC policy evaluation
class ABACPolicyEngine {
  constructor() {
    this.policies = [];
  }
  
  addPolicy(name, condition, effect) {
    this.policies.push({ name, condition, effect });
  }
  
  evaluate(user, resource, action, context) {
    for (const policy of this.policies) {
      if (policy.condition(user, resource, action, context)) {
        return policy.effect === 'allow';
      }
    }
    return false; // Default deny
  }
}

// Usage
const engine = new ABACPolicyEngine();

// Policy: Users can read their own documents
engine.addPolicy('own-documents', 
  (user, resource, action) => 
    resource.owner === user.id && action === 'read',
  'allow'
);

// Policy: Managers can read department documents during business hours
engine.addPolicy('department-access',
  (user, resource, action, context) =>
    user.role === 'manager' &&
    resource.department === user.department &&
    action === 'read' &&
    isBusinessHours(context.time),
  'allow'
);
```

## 🔍 Context-Aware Authorization

### Environment-Based Decisions

```javascript
// Authorization based on context
function evaluateAccess(user, resource, action, context) {
  // Check user attributes
  if (user.role === 'admin') return true;
  
  // Check resource attributes
  if (resource.sensitivity === 'high' && user.clearance < 5) {
    return false;
  }
  
  // Check environment
  if (context.location !== 'office' && resource.restricted === true) {
    return false;
  }
  
  // Check time-based access
  if (!isBusinessHours(context.time) && action !== 'read') {
    return false;
  }
  
  // Check IP restrictions
  if (resource.ipRestricted && !allowedIPs.includes(context.ip)) {
    return false;
  }
  
  return true;
}
```

## 🔍 Dynamic Policy Evaluation

### Real-Time Policy Evaluation

```javascript
// Evaluate policies dynamically
async function checkAccess(user, resource, action) {
  const context = {
    time: Date.now(),
    location: await getUserLocation(user.id),
    ip: await getUserIP(user.id),
    sessionDuration: await getSessionDuration(user.id)
  };
  
  // Get user attributes
  const userAttributes = {
    role: user.role,
    department: user.department,
    clearance: user.clearance,
    employmentStatus: user.employmentStatus
  };
  
  // Get resource attributes
  const resourceAttributes = {
    owner: resource.userId,
    department: resource.department,
    sensitivity: resource.classification,
    createdAt: resource.createdAt
  };
  
  // Evaluate policies
  return abacEngine.evaluate(
    userAttributes,
    resourceAttributes,
    action,
    context
  );
}
```

## 🛡️ Best Practices

1. **Policy Definition**: Clearly define policies
2. **Performance**: Cache policy evaluations when possible
3. **Auditing**: Log all policy evaluations
4. **Testing**: Test policy combinations
5. **Documentation**: Document policy logic
6. **Monitoring**: Monitor policy effectiveness

---

**Next**: Learn about [Permission Models](./PERMISSION-MODELS.md)

