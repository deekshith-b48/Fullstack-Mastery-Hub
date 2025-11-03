# HTTP Basics

## What is HTTP?

HTTP (HyperText Transfer Protocol) is the foundation of data communication on the web.

## HTTP Request Structure

```
METHOD /path HTTP/1.1
Host: example.com
Header-Name: header-value

Body (optional)
```

## HTTP Methods

- **GET**: Retrieve data
- **POST**: Submit data
- **PUT**: Update resource
- **DELETE**: Delete resource
- **PATCH**: Partial update
- **HEAD**: Get headers only
- **OPTIONS**: Get allowed methods

## Status Codes

- **2xx Success**: 200 OK, 201 Created, 204 No Content
- **3xx Redirection**: 301 Moved, 302 Found, 304 Not Modified
- **4xx Client Error**: 400 Bad Request, 401 Unauthorized, 404 Not Found
- **5xx Server Error**: 500 Internal Server, 502 Bad Gateway, 503 Service Unavailable

## Headers

Common headers:
- `Content-Type`: application/json, text/html
- `Authorization`: Bearer token
- `Accept`: application/json
- `User-Agent`: Browser/client info
- `Cache-Control`: Cache directives

---

**Next**: See [HTTP Methods](./HTTP-METHODS.md) in detail

