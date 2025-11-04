# CORS Configuration

## 📚 Overview

CORS (Cross-Origin Resource Sharing) controls access from different origins.

## 🎯 Basic Configuration

```javascript
const cors = require('cors');

// Allow all origins
app.use(cors());

// Specific origins
app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true
}));

// Multiple origins
app.use(cors({
  origin: ['http://localhost:3000', 'https://example.com'],
  credentials: true
}));
```

## 🔒 Advanced Configuration

```javascript
const corsOptions = {
  origin: (origin, callback) => {
    const allowedOrigins = ['http://localhost:3000', 'https://example.com'];
    if (!origin || allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

app.use(cors(corsOptions));
```

---

**Next**: Learn about [HTTPS/TLS Configuration](./HTTPS-TLS-CONFIGURATION.md)

