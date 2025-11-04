# Serverless Functions

## 📚 Overview

Serverless functions allow you to run code in response to events without managing servers. Platforms like Vercel and Netlify provide serverless function capabilities for building APIs and handling backend logic.

## 🎯 Serverless Fundamentals

### What are Serverless Functions?

Serverless functions are event-driven, stateless functions that run in response to triggers. They automatically scale and you pay only for execution time.

### Benefits

- **No Server Management**: Platform handles infrastructure
- **Auto-scaling**: Automatic scaling based on demand
- **Pay-per-use**: Pay only for execution time
- **Fast Deployment**: Quick deployment cycles
- **Multiple Languages**: Support for various languages

## 🚀 Vercel Functions

### Creating Functions

```javascript
// api/hello.js
export default function handler(req, res) {
  const { method } = req;
  
  if (method === 'GET') {
    res.status(200).json({ message: 'Hello from Vercel!' });
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}

// api/users/[id].js
export default function handler(req, res) {
  const { id } = req.query;
  
  if (req.method === 'GET') {
    res.status(200).json({ id, name: `User ${id}` });
  } else if (req.method === 'POST') {
    res.status(201).json({ id, created: true });
  }
}
```

### Function Configuration

```json
{
  "functions": {
    "api/**/*.js": {
      "maxDuration": 10,
      "memory": 1024
    }
  }
}
```

### Environment Variables

```bash
# Set in Vercel dashboard
# Or use vercel env add

# Access in function
const apiKey = process.env.API_KEY;
```

## 🔧 Netlify Functions

### Creating Functions

```javascript
// netlify/functions/hello.js
exports.handler = async (event, context) => {
  const { httpMethod, path, queryStringParameters } = event;
  
  if (httpMethod === 'GET') {
    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Hello from Netlify!' })
    };
  }
  
  return {
    statusCode: 405,
    body: JSON.stringify({ error: 'Method not allowed' })
  };
};
```

### Function Configuration

```toml
[functions]
  directory = "netlify/functions"
  node_bundler = "esbuild"

[functions.hello]
  included_files = ["config/**"]
```

### Environment Variables

```bash
# Set in Netlify dashboard
# Or use netlify env:set

# Access in function
const apiKey = process.env.API_KEY;
```

## 📊 Database Integration

### Vercel with Database

```javascript
// api/users.js
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

export default async function handler(req, res) {
  const { data, error } = await supabase
    .from('users')
    .select('*');
  
  if (error) {
    return res.status(500).json({ error: error.message });
  }
  
  res.status(200).json(data);
}
```

### Netlify with Database

```javascript
// netlify/functions/users.js
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

exports.handler = async (event) => {
  const { data, error } = await supabase
    .from('users')
    .select('*');
  
  if (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
  
  return {
    statusCode: 200,
    body: JSON.stringify(data)
  };
};
```

## 🔐 Authentication

### Vercel Functions with Auth

```javascript
// api/protected.js
export default function handler(req, res) {
  const token = req.headers.authorization;
  
  if (!token || token !== process.env.API_TOKEN) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  
  res.status(200).json({ message: 'Protected data' });
}
```

### Netlify Functions with Auth

```javascript
// netlify/functions/protected.js
exports.handler = async (event) => {
  const token = event.headers.authorization;
  
  if (!token || token !== process.env.API_TOKEN) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: 'Unauthorized' })
    };
  }
  
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Protected data' })
  };
};
```

## 📈 Performance Optimization

### Caching

```javascript
// Cache responses
const cache = new Map();

export default function handler(req, res) {
  const cacheKey = req.url;
  
  if (cache.has(cacheKey)) {
    return res.status(200).json(cache.get(cacheKey));
  }
  
  const data = fetchData();
  cache.set(cacheKey, data);
  
  res.status(200).json(data);
}
```

### Connection Pooling

```javascript
// Reuse database connections
let dbConnection = null;

export default async function handler(req, res) {
  if (!dbConnection) {
    dbConnection = await createConnection();
  }
  
  const data = await dbConnection.query('SELECT * FROM users');
  res.status(200).json(data);
}
```

## 🎯 Best Practices

1. **Stateless**: Keep functions stateless
2. **Error Handling**: Implement proper error handling
3. **Timeouts**: Set appropriate timeouts
4. **Security**: Validate inputs and authenticate
5. **Monitoring**: Log and monitor function execution
6. **Caching**: Cache responses when appropriate
7. **Cold Starts**: Minimize cold start time

## 🎓 Learning Resources

- Vercel Functions: https://vercel.com/docs/functions
- Netlify Functions: https://docs.netlify.com/functions/overview/
- Serverless: https://serverless.com/

---

**Next**: Learn about [CI/CD Integration](./CI-CD-INTEGRATION.md)

