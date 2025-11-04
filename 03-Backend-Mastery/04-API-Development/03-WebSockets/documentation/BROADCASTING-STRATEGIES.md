# WebSocket Broadcasting Strategies

## 📚 Overview

Different strategies for broadcasting messages to multiple clients.

## 🎯 Broadcasting Methods

### 1. Broadcast to All

```javascript
io.emit('message', data); // All clients including sender
socket.broadcast.emit('message', data); // All except sender
```

### 2. Room-Based Broadcasting

```javascript
io.to('room-1').emit('message', data); // All in room
socket.to('room-1').emit('message', data); // All in room except sender
```

### 3. Namespace Broadcasting

```javascript
io.of('/admin').emit('message', data);
```

---

**Next**: Learn about [Rooms & Namespaces](./ROOMS-NAMESPACES.md)

