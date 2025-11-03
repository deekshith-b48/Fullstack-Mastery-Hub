# System Design Basics

## Key Concepts

### Scalability
- **Horizontal**: Add more servers
- **Vertical**: Upgrade server hardware

### Load Balancing
- Distribute traffic across servers
- Round-robin, least connections, IP hash

### Caching
- Store frequently accessed data
- Redis, Memcached
- Cache invalidation strategies

### Database
- **SQL**: PostgreSQL, MySQL (ACID)
- **NoSQL**: MongoDB, Cassandra (BASE)
- Replication and sharding

### API Design
- RESTful principles
- GraphQL for flexible queries
- Rate limiting and versioning

## Design Process

1. **Requirements**: Functional and non-functional
2. **Capacity Estimation**: Traffic, storage, bandwidth
3. **System APIs**: Define interfaces
4. **Database Design**: Schema and data models
5. **High-level Design**: Components and interactions
6. **Detailed Design**: Specific algorithms and optimizations
7. **Scaling**: Handle growth and bottlenecks

---

**Next**: Learn about [Scalability Patterns](./SCALABILITY-PATTERNS.md)

