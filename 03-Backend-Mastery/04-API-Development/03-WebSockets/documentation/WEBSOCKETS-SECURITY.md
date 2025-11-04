# WebSocket Security

## 📚 Overview

Security best practices for WebSocket connections.

## 🛡️ Authentication

```javascript
// Authenticate on connection
io.use((socket, next) => {
  const token = socket.handshake.auth.token;
  if (validateToken(token)) {
    socket.user = getUserFromToken(token);
    next();
  } else {
    next(new Error('Authentication failed'));
  }
});
```

## 🔒 Authorization

```javascript
socket.on('join-room', (roomId) => {
  if (socket.user.role === 'admin' || socket.user.rooms.includes(roomId)) {
    socket.join(roomId);
  } else {
    socket.emit('error', 'Unauthorized');
  }
});
```

## 🚫 Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 60 * 1000,
  max: 100
});

io.use((socket, next) => {
  // Apply rate limiting
  limiter(socket.request, socket.request.res, next);
});
```

---

**Next**: Learn about [Scaling WebSockets](./SCALING-WEBSOCKETS.md)

