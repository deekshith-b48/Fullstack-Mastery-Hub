# Socket.IO Mastery

## 📚 Overview

Socket.IO provides real-time bidirectional communication.

## 🚀 Server Setup

```javascript
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

io.on('connection', (socket) => {
  console.log('User connected:', socket.id);
  
  socket.on('message', (data) => {
    io.emit('message', data);
  });
  
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

server.listen(3000);
```

## 📱 Client Setup

```javascript
import { io } from 'socket.io-client';

const socket = io('http://localhost:3000');

socket.on('connect', () => {
  console.log('Connected:', socket.id);
});

socket.emit('message', 'Hello Server');

socket.on('message', (data) => {
  console.log('Received:', data);
});
```

---

**Next**: Learn about [Real-time Applications](./REAL-TIME-APPLICATIONS.md)

