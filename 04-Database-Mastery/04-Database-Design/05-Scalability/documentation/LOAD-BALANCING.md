# Database Load Balancing

## 📚 Overview

Load balancing distributes database requests across multiple servers to improve performance and availability.

## ⚖️ Load Balancing Strategies

### Read Load Balancing

```python
# Route read queries to replicas
read_servers = ['replica1', 'replica2', 'replica3']
write_server = 'primary'

def get_read_connection():
    server = random.choice(read_servers)
    return connect(server)

def get_write_connection():
    return connect(write_server)
```

### Round-Robin

```python
# Distribute requests evenly
class RoundRobinBalancer:
    def __init__(self, servers):
        self.servers = servers
        self.current = 0
    
    def get_server(self):
        server = self.servers[self.current]
        self.current = (self.current + 1) % len(self.servers)
        return server
```

### Least Connections

```python
# Route to server with fewest connections
def get_least_loaded_server(servers):
    return min(servers, key=lambda s: s.get_connection_count())
```

## 🔄 Application-Level Load Balancing

### Connection Pooling

```python
# Use connection pool with load balancing
from sqlalchemy import create_engine

engine = create_engine(
    'postgresql://user:pass@host1,host2,host3/db',
    pool_size=10,
    max_overflow=20
)
```

## 🎯 Best Practices

1. **Balance read load** across replicas
2. **Use health checks** for servers
3. **Monitor server performance**
4. **Implement failover** mechanisms
5. **Test load balancing** strategies

---

**Next**: Continue learning about scalability.

