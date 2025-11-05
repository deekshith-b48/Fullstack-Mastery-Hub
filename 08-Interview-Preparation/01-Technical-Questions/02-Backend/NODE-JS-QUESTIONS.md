# Node.js Interview Questions

**150+ Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is Node.js and what is it used for?
2. Explain the difference between Node.js and browser JavaScript.
3. What is V8 engine and how does Node.js use it?
4. Explain Node.js runtime environment.
5. What is npm and package.json?
6. Explain npm vs yarn vs pnpm.
7. What is the difference between dependencies and devDependencies?
8. Explain npm scripts and how to use them.
9. What is package-lock.json and why is it important?
10. Explain semantic versioning (semver).
11. What is Node.js global objects?
12. Explain `global` object vs `window` object.
13. What is `process` object and its properties?
14. Explain `process.env` and environment variables.
15. What is `process.argv` and command-line arguments?
16. Explain `process.exit()` and exit codes.
17. What is `console` object methods?
18. Explain `console.log()`, `console.error()`, `console.warn()`.
19. What is `require()` and module system?
20. Explain CommonJS modules vs ES6 modules.
21. What is `module.exports` vs `exports`?
22. Explain `require()` vs `import` in Node.js.
23. What is `__dirname` and `__filename`?
24. Explain path resolution in Node.js.
25. What is `path` module and its methods?
26. Explain `path.join()`, `path.resolve()`, `path.basename()`.
27. What is `fs` module and file operations?
28. Explain `fs.readFile()` vs `fs.readFileSync()`.
29. What is `fs.writeFile()` and file writing?
30. Explain `fs.appendFile()` for appending.
31. What is `fs.mkdir()` and directory creation?
32. Explain `fs.readdir()` and directory reading.
33. What is `fs.stat()` and file information?
34. Explain `fs.unlink()` and file deletion.
35. What is `fs.rename()` and file renaming?
36. Explain `url` module and URL parsing.
37. What is `querystring` module?
38. Explain `http` module and creating servers.
39. What is `http.createServer()` and request handling?
40. Explain `request` and `response` objects.
41. What is `http` vs `https` module?
42. Explain `crypto` module and hashing.
43. What is `crypto.createHash()` and hash algorithms?
44. Explain `crypto.randomBytes()` and random generation.
45. What is `os` module and system information?
46. Explain `os.platform()`, `os.arch()`, `os.cpus()`.
47. What is `util` module and utility functions?
48. Explain `util.promisify()` and callback conversion.
49. What is `events` module and EventEmitter?
50. Explain `EventEmitter` class and event handling.

---

## 🎯 Intermediate (50 Questions)

51. What is the Node.js event loop and how does it work?
52. Explain event loop phases: timers, pending callbacks, poll, check, close.
53. What is the difference between `setTimeout` and `setImmediate`?
54. Explain `process.nextTick()` and its priority.
55. What is `queueMicrotask()` in Node.js?
56. Explain the execution order of different async operations.
57. What is Node.js streams and why use them?
58. Explain readable streams and `fs.createReadStream()`.
59. What is writable streams and `fs.createWriteStream()`?
60. Explain duplex streams and transform streams.
61. What is `stream.pipe()` and stream chaining?
62. Explain backpressure in streams.
63. What is stream events: `data`, `end`, `error`, `finish`?
64. Explain custom stream implementation.
65. What is `Buffer` in Node.js and why is it needed?
66. Explain `Buffer.alloc()`, `Buffer.from()`, `Buffer.toString()`.
67. What is buffer encoding: `utf8`, `base64`, `hex`?
68. Explain buffer operations and methods.
69. What is error handling in Node.js?
70. Explain error-first callback pattern.
71. What is `try-catch` with async/await?
72. Explain error handling with promises.
73. What is custom error classes?
74. Explain `Error.stack` and error stack traces.
75. What is middleware pattern in Node.js?
76. Explain Express.js middleware architecture.
77. What is error handling middleware?
78. Explain async middleware error handling.
79. What is environment variables and configuration?
80. Explain `dotenv` package and `.env` files.
81. What is process.env and environment management?
82. Explain different environments: development, staging, production.
83. What is logging in Node.js applications?
84. Explain `winston`, `pino`, and logging libraries.
85. What is log levels and log formatting?
86. Explain structured logging and JSON logs.
87. What is Node.js clustering and why use it?
88. Explain `cluster` module and worker processes.
89. What is `cluster.fork()` and process creation?
90. Explain load balancing with cluster.
91. What is child processes in Node.js?
92. Explain `child_process.spawn()`, `exec()`, `fork()`.
93. What is the difference between `spawn` and `exec`?
94. Explain `child_process.fork()` and IPC communication.
95. What is process communication and messaging?
96. Explain `process.send()` and `process.on('message')`.
97. What is `worker_threads` module?
98. Explain worker threads vs child processes.
99. What is `worker_threads` use cases?
100. Explain shared memory with `SharedArrayBuffer`.

---

## 🚀 Advanced (50+ Questions)

101. What is Node.js performance optimization?
102. Explain V8 engine optimization techniques.
103. What is memory management in Node.js?
104. Explain garbage collection and memory leaks.
105. What is `heapdump` and memory profiling?
106. Explain Chrome DevTools for Node.js debugging.
107. What is `node --inspect` and debugging?
108. Explain performance profiling with `clinic.js`.
109. What is async/await performance considerations?
110. Explain blocking vs non-blocking operations.
111. What is CPU-intensive tasks in Node.js?
112. Explain worker threads for CPU-bound tasks.
113. What is `worker_threads` implementation?
114. Explain thread pool and libuv.
115. What is Node.js security best practices?
116. Explain input validation and sanitization.
117. What is SQL injection prevention?
118. Explain XSS and CSRF protection.
119. What is secure headers and Helmet.js?
120. Explain dependency security and npm audit.
121. What is rate limiting and DDoS protection?
122. Explain authentication and authorization.
123. What is JWT implementation in Node.js?
124. Explain bcrypt for password hashing.
125. What is HTTPS and SSL/TLS configuration?
126. Explain certificate management.
127. What is Node.js debugging techniques?
128. Explain `console.trace()` and stack traces.
129. What is `debug` module and conditional logging?
130. Explain source maps and debugging.
131. What is testing in Node.js?
132. Explain Jest, Mocha, and testing frameworks.
133. What is unit testing vs integration testing?
134. Explain mocking and test doubles.
135. What is test coverage and Istanbul?
136. Explain E2E testing with Node.js.
137. What is database integration in Node.js?
138. Explain database connection pooling.
139. What is ORM vs raw SQL queries?
140. Explain Sequelize, TypeORM, Prisma.
141. What is database migrations?
142. Explain migration tools and versioning.
143. What is transaction management?
144. Explain ACID properties and transactions.
145. What is caching strategies in Node.js?
146. Explain Redis integration and caching.
147. What is session management?
148. Explain session storage: memory, Redis, database.
149. What is message queues in Node.js?
150. Explain RabbitMQ, Kafka, Bull queue.
151. What is background job processing?
152. Explain job queues and workers.
153. What is real-time communication?
154. Explain Socket.io and WebSocket.
155. What is Server-Sent Events (SSE)?
156. Explain pub/sub patterns.
157. What is GraphQL in Node.js?
158. Explain Apollo Server and GraphQL implementation.
159. What is RESTful API design?
160. Explain API versioning strategies.
161. What is API documentation with Swagger?
162. Explain OpenAPI specification.
163. What is microservices architecture?
164. Explain service communication patterns.
165. What is API Gateway pattern?
166. Explain service discovery and registration.
167. What is distributed tracing?
168. Explain Jaeger, Zipkin, and tracing tools.
169. What is monitoring and observability?
170. Explain Prometheus, Grafana, and metrics.
171. What is log aggregation and ELK stack?
172. Explain centralized logging.
173. What is containerization with Docker?
174. Explain Dockerfile and Node.js containers.
175. What is Kubernetes deployment for Node.js?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*
