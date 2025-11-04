# Redis Pub/Sub Messaging

## 📚 Overview

Redis Pub/Sub provides a messaging system where publishers send messages to channels and subscribers receive messages from channels.

## 📢 Publishing

```bash
# Publish message to channel
PUBLISH channel "message"

# Publish to multiple channels
PUBLISH news "Breaking news"
PUBLISH sports "Game update"
```

## 📡 Subscribing

```bash
# Subscribe to channel
SUBSCRIBE channel

# Subscribe to multiple channels
SUBSCRIBE news sports

# Subscribe to patterns
PSUBSCRIBE news.*

# Unsubscribe
UNSUBSCRIBE channel
PUNSUBSCRIBE pattern
```

## 💻 Programming Example

### Publisher (Node.js)

```javascript
const redis = require('redis');
const publisher = redis.createClient();

// Publish message
publisher.publish('channel', 'Hello World');

// Publish with JSON
publisher.publish('events', JSON.stringify({
    type: 'user_created',
    userId: 123
}));
```

### Subscriber (Node.js)

```javascript
const redis = require('redis');
const subscriber = redis.createClient();

// Subscribe to channel
subscriber.subscribe('channel');

// Handle messages
subscriber.on('message', (channel, message) => {
    console.log(`Received ${message} from ${channel}`);
});

// Pattern subscribe
subscriber.psubscribe('events.*');
subscriber.on('pmessage', (pattern, channel, message) => {
    console.log(`Pattern ${pattern} matched ${channel}: ${message}`);
});
```

## 🎯 Use Cases

1. **Real-time notifications**
2. **Event broadcasting**
3. **Chat applications**
4. **System coordination**
5. **Log aggregation**

## 🎯 Best Practices

1. **Use appropriate channels** for message types
2. **Handle connection failures**
3. **Implement message acknowledgment** if needed
4. **Monitor message rates**
5. **Use patterns** for dynamic subscriptions

---

**Next**: Learn about [Clustering & Sentinel](./CLUSTERING-SENTINEL.md)

