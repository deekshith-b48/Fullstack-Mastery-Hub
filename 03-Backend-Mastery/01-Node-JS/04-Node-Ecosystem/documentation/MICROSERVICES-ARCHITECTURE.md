# Node.js Microservices Architecture

## 📚 Overview

Microservices break applications into small, independent services.

## 🏗️ Architecture

```
┌─────────────┐
│   Gateway   │
└──────┬──────┘
       │
   ┌───┴───┬──────────┬──────────┐
   │       │          │          │
┌──▼──┐ ┌──▼──┐    ┌──▼──┐    ┌──▼──┐
│User │ │Order│    │Pay  │    │Notif│
│Svc  │ │Svc  │    │Svc  │    │Svc  │
└─────┘ └─────┘    └─────┘    └─────┘
```

## 🎯 Service Communication

### REST APIs

```javascript
// Service A calling Service B
const axios = require('axios');

async function getUserData(userId) {
  const response = await axios.get(`http://user-service:3000/users/${userId}`);
  return response.data;
}
```

### Message Queue (RabbitMQ)

```javascript
const amqp = require('amqplib');

// Producer
async function publishMessage(queue, message) {
  const connection = await amqp.connect('amqp://localhost');
  const channel = await connection.createChannel();
  await channel.assertQueue(queue);
  channel.sendToQueue(queue, Buffer.from(JSON.stringify(message)));
}

// Consumer
async function consumeMessages(queue) {
  const connection = await amqp.connect('amqp://localhost');
  const channel = await connection.createChannel();
  await channel.assertQueue(queue);
  
  channel.consume(queue, (msg) => {
    const content = JSON.parse(msg.content.toString());
    console.log('Received:', content);
    channel.ack(msg);
  });
}
```

## 🔧 Service Discovery

```javascript
const consul = require('consul')();

// Register service
consul.agent.service.register({
  name: 'user-service',
  address: 'localhost',
  port: 3000
});

// Discover service
consul.health.service({
  service: 'user-service',
  passing: true
}, (err, result) => {
  if (!err) {
    const service = result[0];
    const serviceUrl = `http://${service.Service.Address}:${service.Service.Port}`;
  }
});
```

---

**Next**: Learn about [Python Backend](./../../02-Python-Backend/01-Django/documentation/DJANGO-FUNDAMENTALS.md)

