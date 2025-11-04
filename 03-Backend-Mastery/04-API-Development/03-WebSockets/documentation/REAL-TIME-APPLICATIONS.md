# Real-time Applications

## 📚 Overview

Building real-time applications with WebSockets.

## 💬 Chat Application

```javascript
// Server
io.on('connection', (socket) => {
  socket.on('join-room', (roomId) => {
    socket.join(roomId);
  });
  
  socket.on('send-message', (data) => {
    io.to(data.roomId).emit('receive-message', data);
  });
});

// Client
socket.emit('join-room', 'room-123');
socket.emit('send-message', {
  roomId: 'room-123',
  message: 'Hello!',
  user: 'John'
});
```

## 📊 Live Updates

```javascript
// Broadcast updates to all clients
io.emit('user-updated', { userId: 1, name: 'Jane' });

// Broadcast to specific room
io.to('admin-room').emit('admin-notification', data);
```

---

**Next**: Learn about [Broadcasting Strategies](./BROADCASTING-STRATEGIES.md)

