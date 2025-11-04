# Edge Functions

## 📚 Overview

Edge functions run at the edge of the network, closer to users, enabling low-latency execution. Vercel and Netlify provide edge computing capabilities for improved performance.

## 🎯 Edge Computing Fundamentals

### What are Edge Functions?

Edge functions run code at edge locations worldwide, reducing latency by executing code closer to users. They're ideal for personalization, A/B testing, and authentication.

### Benefits

- **Low Latency**: Execute close to users
- **Global Distribution**: Run at edge locations
- **Performance**: Faster response times
- **Scalability**: Automatic scaling
- **Cost Efficiency**: Pay only for execution

## 🚀 Vercel Edge Functions

### Creating Edge Functions

```javascript
// middleware.js (Next.js)
export function middleware(request) {
  const response = new Response('Hello from Edge!', {
    headers: { 'content-type': 'text/plain' },
  });
  
  return response;
}

export const config = {
  matcher: '/api/:path*',
};
```

### Edge API Routes

```javascript
// app/api/edge/route.js (Next.js App Router)
export const runtime = 'edge';

export async function GET(request) {
  return new Response(JSON.stringify({ message: 'Hello from Edge!' }), {
    headers: { 'content-type': 'application/json' },
  });
}
```

### Edge Configuration

```javascript
// next.config.js
module.exports = {
  experimental: {
    runtime: 'edge',
  },
};
```

## 🔧 Netlify Edge Functions

### Creating Edge Functions

```javascript
// netlify/edge-functions/hello.js
export default async (request, context) => {
  return new Response('Hello from Edge!', {
    headers: { 'content-type': 'text/plain' },
  });
};
```

### Edge Function Configuration

```toml
[[edge_functions]]
  function = "hello"
  path = "/api/*"
```

### Request Handling

```javascript
// netlify/edge-functions/api.js
export default async (request, context) => {
  const { method, url } = request;
  const { geo, ip } = context;
  
  if (method === 'GET') {
    return new Response(JSON.stringify({
      message: 'Hello from Edge!',
      geo,
      ip,
    }), {
      headers: { 'content-type': 'application/json' },
    });
  }
  
  return new Response('Method not allowed', { status: 405 });
};
```

## 🔐 Authentication at Edge

### Vercel Edge Auth

```javascript
// middleware.js
import { NextResponse } from 'next/server';

export function middleware(request) {
  const token = request.headers.get('authorization');
  
  if (!token || token !== process.env.API_TOKEN) {
    return NextResponse.json(
      { error: 'Unauthorized' },
      { status: 401 }
    );
  }
  
  return NextResponse.next();
}
```

### Netlify Edge Auth

```javascript
// netlify/edge-functions/auth.js
export default async (request, context) => {
  const token = request.headers.get('authorization');
  
  if (!token || token !== Deno.env.get('API_TOKEN')) {
    return new Response(
      JSON.stringify({ error: 'Unauthorized' }),
      { status: 401, headers: { 'content-type': 'application/json' } }
    );
  }
  
  return context.next();
};
```

## 📊 Personalization

### A/B Testing

```javascript
// Vercel Edge
export function middleware(request) {
  const variant = Math.random() > 0.5 ? 'A' : 'B';
  
  const response = NextResponse.next();
  response.cookies.set('variant', variant);
  
  return response;
}
```

### Geo-based Routing

```javascript
// Netlify Edge
export default async (request, context) => {
  const { geo } = context;
  const country = geo.country.code;
  
  if (country === 'US') {
    return Response.redirect('https://us.example.com');
  }
  
  return context.next();
};
```

## 🎯 Best Practices

1. **Stateless**: Keep functions stateless
2. **Minimal Logic**: Keep logic simple
3. **Caching**: Cache responses when appropriate
4. **Security**: Validate inputs and authenticate
5. **Monitoring**: Monitor edge function performance
6. **Testing**: Test edge functions thoroughly
7. **Documentation**: Document edge function behavior

## 🎓 Learning Resources

- Vercel Edge: https://vercel.com/docs/edge-functions
- Netlify Edge: https://docs.netlify.com/edge-functions/overview/
- Edge Computing: https://www.cloudflare.com/learning/serverless/glossary/what-is-edge-computing/

---

**Next**: Learn about [Performance Optimization](./PERFORMANCE-OPTIMIZATION.md)

