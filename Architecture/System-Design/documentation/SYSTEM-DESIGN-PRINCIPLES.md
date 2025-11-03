# System Design Principles

## 📚 Overview

System design is the process of defining the architecture, components, modules, interfaces, and data for a system to satisfy specified requirements.

## 🎯 Core Principles

### Scalability

**Horizontal Scaling**: Add more servers to handle increased load
- **Pros**: Can scale almost infinitely
- **Cons**: Requires load balancing, shared state management
- **Example**: Add more web servers behind a load balancer

**Vertical Scaling**: Increase resources (CPU, RAM) of existing servers
- **Pros**: Simpler, no code changes needed
- **Cons**: Limited by hardware, expensive
- **Example**: Upgrade server from 8GB to 32GB RAM

### Reliability

**High Availability**: System remains operational even when components fail
- Redundancy at multiple levels
- Failover mechanisms
- Health checks and monitoring

**Fault Tolerance**: System continues operating in the event of failures
- Graceful degradation
- Circuit breakers
- Retry mechanisms

### Performance

**Latency**: Time taken to process a request
- Database query optimization
- Caching strategies
- CDN for static content

**Throughput**: Number of requests processed per unit time
- Load balancing
- Database replication
- Async processing

## 🏗️ System Design Process

### 1. Requirements Clarification

```
Functional Requirements:
- What features does the system need?
- User stories and use cases

Non-Functional Requirements:
- Expected load (users, requests/sec)
- Performance requirements (latency, throughput)
- Availability requirements (uptime %)
- Scalability requirements (growth rate)
```

### 2. Capacity Estimation

```
Traffic Estimates:
- DAU (Daily Active Users): 1 million
- Read:Write ratio: 100:1
- Average request size: 10KB
- Peak traffic: 3x average

Storage Estimates:
- User data: 100KB per user
- Total storage: 1M * 100KB = 100GB
- Growth: 10GB per month

Bandwidth Estimates:
- Reads: 1M * 100KB / 86400s = ~1.16GB/s
- Writes: 1M * 10KB / 86400s = ~115MB/s
```

### 3. API Design

```javascript
// RESTful API Design
GET    /api/users/{id}        // Get user
POST   /api/users             // Create user
PUT    /api/users/{id}        // Update user
DELETE /api/users/{id}        // Delete user

// Response format
{
  "status": "success",
  "data": { ... },
  "error": null
}
```

### 4. Database Schema

```sql
-- Users table
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);
```

### 5. High-Level Design

```
┌─────────┐     ┌──────────┐     ┌─────────┐
│  CDN    │────▶│Load      │────▶│  Web    │
│         │     │Balancer  │     │ Servers │
└─────────┘     └──────────┘     └─────────┘
                        │
                        ▼
                  ┌──────────┐
                  │  Cache   │
                  │  (Redis) │
                  └──────────┘
                        │
                        ▼
                  ┌──────────┐
                  │Database  │
                  │(PostgreSQL│
                  └──────────┘
```

### 6. Detailed Design

- Component interactions
- Data flow
- Error handling
- Security considerations
- Monitoring and logging

## 🔑 Key Concepts

### Load Balancing

```javascript
// Algorithms
Round Robin        // Distribute requests sequentially
Least Connections  // Send to server with fewest active connections
Weighted Round Robin // Based on server capacity
IP Hash           // Route based on client IP
```

### Caching Strategies

```javascript
// Cache-Aside (Lazy Loading)
async function getUser(id) {
  // 1. Check cache
  let user = await cache.get(`user:${id}`);
  
  // 2. If not in cache, fetch from DB
  if (!user) {
    user = await db.getUser(id);
    await cache.set(`user:${id}`, user, 3600); // TTL: 1 hour
  }
  
  return user;
}

// Write-Through
async function updateUser(id, data) {
  await db.updateUser(id, data);
  await cache.set(`user:${id}`, data); // Update cache immediately
}
```

### Database Replication

```
Master-Slave Replication:
- Master: Handles writes
- Slaves: Handle reads
- Async replication from master to slaves

Master-Master Replication:
- Both handle reads and writes
- Synchronous replication
- Conflict resolution needed
```

### Message Queues

```javascript
// Publisher
await queue.publish('user.created', {
  userId: 123,
  email: 'user@example.com'
});

// Consumer
queue.subscribe('user.created', async (message) => {
  await sendWelcomeEmail(message.email);
  await updateAnalytics(message.userId);
});
```

## 📊 CAP Theorem

**CAP**: Consistency, Availability, Partition Tolerance

- **CP**: Consistency + Partition Tolerance (MongoDB, Redis)
- **AP**: Availability + Partition Tolerance (Cassandra, DynamoDB)
- **CA**: Consistency + Availability (Single server databases)

## 🎯 Design Patterns

### Microservices

```
Service Architecture:
├── User Service
├── Product Service
├── Order Service
├── Payment Service
└── Notification Service

Communication:
- REST APIs
- Message queues
- Service mesh
```

### Monolith vs Microservices

**Monolith**:
- ✅ Simple to develop and deploy
- ✅ Easier debugging
- ❌ Hard to scale
- ❌ Technology lock-in

**Microservices**:
- ✅ Independent scaling
- ✅ Technology diversity
- ❌ Complexity
- ❌ Network latency

---

**Next**: Learn about [Load Balancing Strategies](./LOAD-BALANCING.md)

