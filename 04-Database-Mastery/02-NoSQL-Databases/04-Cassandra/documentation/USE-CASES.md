# Cassandra Use Cases

## 📚 Overview

Cassandra is well-suited for specific use cases that require high write throughput, horizontal scaling, and geographic distribution.

## 🎯 Ideal Use Cases

### Time-Series Data

```sql
-- IoT sensor data
CREATE TABLE sensor_readings (
    sensor_id UUID,
    timestamp TIMESTAMP,
    value DOUBLE,
    PRIMARY KEY (sensor_id, timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);
```

### Event Logging

```sql
-- Application event logs
CREATE TABLE events (
    app_name TEXT,
    date DATE,
    timestamp TIMESTAMP,
    event_type TEXT,
    message TEXT,
    PRIMARY KEY (app_name, date, timestamp)
) WITH CLUSTERING ORDER BY (date DESC, timestamp DESC);
```

### User Activity Tracking

```sql
-- User activity tracking
CREATE TABLE user_activities (
    user_id UUID,
    activity_date DATE,
    activity_time TIMESTAMP,
    activity_type TEXT,
    details TEXT,
    PRIMARY KEY (user_id, activity_date, activity_time)
) WITH CLUSTERING ORDER BY (activity_date DESC, activity_time DESC);
```

### Messaging

```sql
-- Chat messages
CREATE TABLE messages (
    chat_id UUID,
    message_time TIMESTAMP,
    message_id UUID,
    sender_id UUID,
    content TEXT,
    PRIMARY KEY (chat_id, message_time, message_id)
) WITH CLUSTERING ORDER BY (message_time DESC);
```

## 🎯 Best Practices

1. **Use for write-heavy workloads**
2. **Large-scale deployments**
3. **Geographic distribution**
4. **Time-series data**
5. **Event logging**
6. **Avoid for complex queries**
7. **Consider data model carefully**

---

**Cassandra section complete!** Next: Learn about [Sequelize](./../../03-ORM-ODM/01-Sequelize/documentation/SEQUELIZE-FUNDAMENTALS.md)

