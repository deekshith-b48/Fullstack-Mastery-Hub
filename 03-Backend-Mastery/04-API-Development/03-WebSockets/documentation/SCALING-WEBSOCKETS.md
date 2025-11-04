# Scaling WebSockets

## 📚 Overview

Scaling WebSocket applications across multiple servers.

## 🔄 Redis Adapter

```javascript
const { createAdapter } = require('@socket.io/redis-adapter');
const { createClient } = require('redis');

const pubClient = createClient({ host: 'localhost', port: 6379 });
const subClient = pubClient.duplicate();

io.adapter(createAdapter(pubClient, subClient));

io.on('connection', (socket) => {
  // Works across multiple servers
  socket.emit('message', 'Hello from server');
});
```

## ⚖️ Load Balancing

```nginx
# Nginx configuration
upstream websocket {
  server localhost:3001;
  server localhost:3002;
}

server {
  location /socket.io/ {
    proxy_pass http://websocket;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
```

---

**Next**: Learn about [Fallback Strategies](./FALLBACK-STRATEGIES.md)

