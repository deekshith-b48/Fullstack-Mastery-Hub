# Express.js Interview Questions

**150+ Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is Express.js and what is it used for?
2. Explain the difference between Express and plain Node.js http module.
3. What is Express middleware and how does it work?
4. Explain `app.use()` and middleware registration.
5. What is request-response cycle in Express?
6. Explain `req` and `res` objects.
7. What is Express routing and how to define routes?
8. Explain `app.get()`, `app.post()`, `app.put()`, `app.delete()`.
9. What is route parameters with `:id`?
10. Explain `req.params` and accessing route parameters.
11. What is query strings and `req.query`?
12. Explain `req.body` and request body parsing.
13. What is `body-parser` middleware?
14. Explain `express.json()` and `express.urlencoded()`.
15. What is Express static files serving?
16. Explain `express.static()` middleware.
17. What is template engines in Express?
18. Explain EJS, Pug, Handlebars template engines.
19. What is `res.render()` and template rendering?
20. Explain `res.send()`, `res.json()`, `res.sendFile()`.
21. What is HTTP status codes in Express?
22. Explain `res.status()` and setting status codes.
23. What is `res.redirect()` and redirecting responses?
24. Explain `res.cookie()` and setting cookies.
25. What is `req.cookies` and reading cookies?
26. Explain `cookie-parser` middleware.
27. What is Express error handling?
28. Explain error middleware with 4 parameters.
29. What is `next()` function and middleware chain?
30. Explain `next(error)` and error propagation.
31. What is route handlers and middleware order?
32. Explain multiple middleware functions.
33. What is Express Router and modular routing?
34. Explain `express.Router()` and route organization.
35. What is mounting routers with `app.use()`?
36. Explain route prefixes and path mounting.
37. What is `app.listen()` and server creation?
38. Explain port configuration and environment variables.
39. What is Express application structure?
40. Explain MVC pattern with Express.
41. What is environment-based configuration?
42. Explain development vs production configurations.
43. What is CORS and Cross-Origin Resource Sharing?
44. Explain `cors` middleware and configuration.
45. What is CORS preflight requests?
46. Explain CORS headers and options.
47. What is Express security best practices?
48. Explain `helmet` middleware for security headers.
49. What is rate limiting in Express?
50. Explain `express-rate-limit` middleware.

---

## 🎯 Intermediate (50 Questions)

51. What is custom middleware creation?
52. Explain logging middleware implementation.
53. What is authentication middleware?
54. Explain JWT verification middleware.
55. What is authorization middleware?
56. Explain role-based access control (RBAC).
57. What is request validation middleware?
58. Explain `express-validator` and input validation.
59. What is file upload middleware?
60. Explain `multer` and file handling.
61. What is `multer` storage configuration?
62. Explain file filtering and size limits.
63. What is session management in Express?
64. Explain `express-session` middleware.
65. What is session storage: memory, Redis, database?
66. Explain Redis session store.
67. What is cookie configuration for sessions?
68. Explain `secure`, `httpOnly`, `sameSite` cookie options.
69. What is Express route organization?
70. Explain controller pattern and route handlers.
71. What is service layer pattern?
72. Explain separation of concerns.
73. What is async error handling in Express?
74. Explain `asyncHandler` wrapper function.
75. What is Express error handling best practices?
76. Explain error logging and monitoring.
77. What is Express testing strategies?
78. Explain `supertest` for API testing.
79. What is mocking in Express tests?
80. Explain integration testing.
81. What is Express API documentation?
82. Explain Swagger/OpenAPI integration.
83. What is `swagger-jsdoc` and API docs?
84. Explain API versioning in Express.
85. What is route versioning strategies?
86. Explain header-based versioning.
87. What is Express performance optimization?
88. Explain response compression with `compression`.
89. What is caching strategies?
90. Explain ETag and conditional requests.
91. What is Express clustering?
92. Explain PM2 process manager.
93. What is load balancing with Express?
94. Explain reverse proxy configuration.
95. What is Express middleware execution order?
96. Explain middleware mounting order importance.
97. What is `app.locals` and `res.locals`?
98. Explain template variables and data passing.
99. What is Express sub-applications?
100. Explain `express()` as middleware.

---

## 🚀 Advanced (50+ Questions)

101. What is Express advanced routing patterns?
102. Explain route parameter validation.
103. What is route-level middleware?
104. Explain conditional middleware application.
105. What is Express middleware composition?
106. Explain `compose` function for middleware.
107. What is Express plugin architecture?
108. Explain extensibility patterns.
109. What is Express request lifecycle hooks?
110. Explain custom request/response extensions.
111. What is Express streaming responses?
112. Explain `res.write()` and streaming.
113. What is Server-Sent Events (SSE) in Express?
114. Explain `res.writeHead()` and headers.
115. What is Express WebSocket integration?
116. Explain Socket.io with Express.
117. What is Express GraphQL integration?
118. Explain Apollo Server with Express.
119. What is Express middleware for GraphQL?
120. Explain GraphQL authentication middleware.
121. What is Express microservices architecture?
122. Explain API Gateway pattern.
123. What is service discovery integration?
124. Explain distributed tracing middleware.
125. What is Express monitoring and metrics?
126. Explain Prometheus metrics middleware.
127. What is Express logging strategies?
128. Explain structured logging with Winston.
129. What is request ID tracking?
130. Explain correlation IDs.
131. What is Express security headers?
132. Explain Content Security Policy (CSP).
133. What is CSRF protection in Express?
134. Explain `csurf` middleware.
135. What is input sanitization?
136. Explain `express-validator` advanced features.
137. What is SQL injection prevention?
138. Explain parameterized queries.
139. What is XSS prevention in Express?
140. Explain output encoding.
141. What is Express file upload security?
142. Explain file type validation.
143. What is Express rate limiting strategies?
144. Explain distributed rate limiting with Redis.
145. What is Express caching middleware?
146. Explain Redis caching integration.
147. What is Express database connection pooling?
148. Explain connection management.
149. What is Express transaction management?
150. Explain database transactions in Express.
151. What is Express background job processing?
152. Explain Bull queue integration.
153. What is Express scheduled tasks?
154. Explain `node-cron` integration.
155. What is Express real-time features?
156. Explain Socket.io rooms and namespaces.
157. What is Express API versioning best practices?
158. Explain semantic versioning for APIs.
159. What is Express deprecation strategies?
160. Explain API migration paths.
161. What is Express internationalization (i18n)?
162. Explain `i18n` middleware.
163. What is Express localization?
164. Explain locale detection.
165. What is Express testing advanced patterns?
166. Explain test fixtures and factories.
167. What is Express E2E testing?
168. Explain API contract testing.
169. What is Express performance monitoring?
170. Explain APM tools integration.
171. What is Express error tracking?
172. Explain Sentry integration.
173. What is Express deployment strategies?
174. Explain Docker containerization.
175. What is Express CI/CD pipeline setup?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*
