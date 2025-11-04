# WebSocket Rooms & Namespaces

## 📚 Overview

Rooms and namespaces organize WebSocket connections.

## 🚪 Rooms

```javascript
// Join room
socket.join('room-1');

// Leave room
socket.leave('room-1');

// Emit to room
io.to('room-1').emit('message', data);

// Multiple rooms
socket.join(['room-1', 'room-2']);
```

## 📦 Namespaces

```javascript
// Create namespace
const adminNamespace = io.of('/admin');

adminNamespace.on('connection', (socket) => {
  console.log('Admin connected');
});

// Client connects to namespace
const adminSocket = io('http://localhost:3000/admin');
```

---

**Next**: Learn about [WebSockets Security](./WEBSOCKETS-SECURITY.md)

