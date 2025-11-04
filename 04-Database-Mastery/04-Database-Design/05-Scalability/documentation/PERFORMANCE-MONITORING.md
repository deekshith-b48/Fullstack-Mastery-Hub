# Database Performance Monitoring

## 📚 Overview

Monitoring database performance helps identify bottlenecks and optimize operations. This guide covers monitoring strategies and metrics.

## 📊 Key Metrics

### Query Performance

```sql
-- PostgreSQL: Slow queries
SELECT 
    query,
    calls,
    total_time,
    mean_time,
    max_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- MySQL: Slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;
```

### Connection Metrics

```sql
-- PostgreSQL: Active connections
SELECT 
    count(*) as total_connections,
    count(*) FILTER (WHERE state = 'active') as active,
    count(*) FILTER (WHERE state = 'idle') as idle
FROM pg_stat_activity;

-- Connection pool usage
SELECT 
    max_conn,
    used_conn,
    (max_conn - used_conn) as available_conn
FROM pg_stat_database;
```

### Resource Usage

```sql
-- PostgreSQL: Database size
SELECT 
    pg_database.datname,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database_size(pg_database.datname) DESC;

-- Table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

## 🔍 Monitoring Tools

### Application Performance Monitoring (APM)

```python
# Track query performance
import time
from functools import wraps

def monitor_query(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        duration = time.time() - start
        
        if duration > 1.0:  # Log slow queries
            log_slow_query(func.__name__, duration, args)
        
        return result
    return wrapper
```

### Database Monitoring Tools

- **pg_stat_statements**: Query statistics
- **pgAdmin**: Visual monitoring
- **Grafana**: Dashboards
- **Prometheus**: Metrics collection

## 🎯 Alerting

### Thresholds

```python
# Set alert thresholds
ALERTS = {
    'slow_query_threshold': 2.0,  # seconds
    'connection_threshold': 80,  # percent
    'disk_space_threshold': 90  # percent
}

def check_alerts():
    if slow_query_count > ALERTS['slow_query_threshold']:
        send_alert('Slow queries detected')
    
    if connection_usage > ALERTS['connection_threshold']:
        send_alert('High connection usage')
```

## 🎯 Best Practices

1. **Monitor key metrics** continuously
2. **Set up alerts** for critical thresholds
3. **Track trends** over time
4. **Review performance** regularly
5. **Document** monitoring setup

---

**Next**: Continue learning about scalability.

