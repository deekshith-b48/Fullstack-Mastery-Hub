# WebSocket Fallback Strategies

## 📚 Overview

Fallback strategies when WebSockets are unavailable.

## 🔄 Polling Fallback

```javascript
// Socket.IO automatically falls back to polling
const socket = io('http://localhost:3000', {
  transports: ['websocket', 'polling']
});
```

## 📡 Long Polling

```javascript
// Server-side long polling
app.get('/messages', (req, res) => {
  // Wait for new messages
  const messages = await waitForMessages(req.query.lastId);
  res.json(messages);
});
```

## 🔁 Server-Sent Events (SSE)

```javascript
// Server
app.get('/events', (req, res) => {
  res.setHeader('Content-Type', 'text/event-stream');
  setInterval(() => {
    res.write(`data: ${JSON.stringify({ message: 'Hello' })}\n\n`);
  }, 1000);
});

// Client
const eventSource = new EventSource('/events');
eventSource.onmessage = (event) => {
  console.log(JSON.parse(event.data));
};
```

---

**Next**: Learn about [API Security](./../04-API-Security/documentation/JWT-TOKENS.md)

