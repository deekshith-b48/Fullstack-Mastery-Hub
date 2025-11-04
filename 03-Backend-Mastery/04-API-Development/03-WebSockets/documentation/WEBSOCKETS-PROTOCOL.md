# WebSockets Protocol

## 📚 Overview

WebSockets provide full-duplex communication over a single TCP connection.

## 🔌 WebSocket Handshake

```
Client → HTTP Upgrade Request
Server → HTTP 101 Switching Protocols
Connection Established
```

## 🎯 Client-Side

```javascript
const socket = new WebSocket('ws://localhost:3000');

socket.onopen = () => {
  console.log('Connected');
  socket.send('Hello Server');
};

socket.onmessage = (event) => {
  console.log('Message:', event.data);
};

socket.onerror = (error) => {
  console.error('Error:', error);
};

socket.onclose = () => {
  console.log('Disconnected');
};
```

## 🖥️ Server-Side (Node.js)

```javascript
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 3000 });

wss.on('connection', (ws) => {
  console.log('Client connected');
  
  ws.on('message', (message) => {
    console.log('Received:', message);
    ws.send('Echo: ' + message);
  });
  
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});
```

---

**Next**: Learn about [Socket.IO Mastery](./SOCKET-IO-MASTERY.md)

