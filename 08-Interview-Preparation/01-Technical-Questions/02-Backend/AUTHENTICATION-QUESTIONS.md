# Authentication & Authorization Interview Questions

**150+ Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is authentication and why is it important?
2. Explain the difference between authentication and authorization.
3. What is session-based authentication?
4. Explain how session authentication works.
5. What is token-based authentication?
6. Explain JWT (JSON Web Tokens) structure.
7. What is JWT header, payload, and signature?
8. Explain JWT token generation and validation.
9. What is access tokens vs refresh tokens?
10. Explain token expiration and renewal.
11. What is password hashing and why is it needed?
12. Explain bcrypt and password hashing.
13. What is salt in password hashing?
14. Explain rainbow table attacks prevention.
15. What is password strength requirements?
16. Explain password complexity rules.
17. What is multi-factor authentication (MFA)?
18. Explain MFA factors: something you know, have, are.
19. What is TOTP (Time-based One-Time Password)?
20. Explain authenticator apps: Google Authenticator, Authy.
21. What is SMS-based MFA?
22. Explain email-based verification codes.
23. What is biometric authentication?
24. Explain fingerprint, face recognition authentication.
25. What is OAuth 2.0 and why is it used?
26. Explain OAuth 2.0 roles: resource owner, client, authorization server.
27. What is OAuth 2.0 authorization code flow?
28. Explain OAuth 2.0 client credentials flow.
29. What is OAuth 2.0 implicit flow?
30. Explain OAuth 2.0 password flow (not recommended).
31. What is OpenID Connect (OIDC)?
32. Explain OIDC vs OAuth 2.0.
33. What is SAML (Security Assertion Markup Language)?
34. Explain SAML vs OAuth.
35. What is SSO (Single Sign-On)?
36. Explain SSO benefits and implementation.
37. What is API key authentication?
38. Explain when to use API keys.
39. What is Basic Authentication?
40. Explain HTTP Basic Auth and security concerns.
41. What is Bearer token authentication?
42. Explain Authorization header with Bearer tokens.
43. What is cookie-based authentication?
44. Explain HttpOnly and Secure cookie flags.
45. What is SameSite cookie attribute?
46. Explain SameSite: Strict, Lax, None.
47. What is CSRF (Cross-Site Request Forgery)?
48. Explain CSRF token protection.
49. What is XSS (Cross-Site Scripting) and authentication?
50. Explain XSS prevention in authentication.

---

## 🎯 Intermediate (50 Questions)

51. What is JWT token security best practices?
52. Explain JWT token storage: localStorage vs cookies.
53. What is token refresh strategies?
54. Explain refresh token rotation.
55. What is token blacklisting and revocation?
56. Explain token invalidation strategies.
57. What is OAuth 2.0 scopes and permissions?
58. Explain fine-grained permissions.
59. What is OAuth 2.0 PKCE (Proof Key for Code Exchange)?
60. Explain PKCE flow for mobile apps.
61. What is OAuth 2.0 device flow?
62. Explain OAuth for IoT devices.
63. What is session management best practices?
64. Explain session timeout and expiration.
65. What is session fixation attacks?
66. Explain session regeneration.
67. What is session hijacking prevention?
68. Explain secure session storage.
69. What is password reset flow?
70. Explain secure password reset tokens.
71. What is email verification?
72. Explain email verification tokens.
73. What is account lockout strategies?
74. Explain brute force protection.
75. What is rate limiting for authentication?
76. Explain login attempt throttling.
77. What is CAPTCHA and when to use it?
78. Explain reCAPTCHA integration.
79. What is social login: OAuth with Google, Facebook?
80. Explain social authentication providers.
81. What is passwordless authentication?
82. Explain magic links and email-based login.
83. What is WebAuthn and FIDO2?
84. Explain passwordless authentication with WebAuthn.
85. What is role-based access control (RBAC)?
86. Explain roles and permissions.
87. What is attribute-based access control (ABAC)?
88. Explain policy-based access control.
89. What is authorization servers?
90. Explain OAuth authorization server implementation.
91. What is token introspection?
92. Explain OAuth 2.0 token introspection endpoint.
93. What is user consent in OAuth?
94. Explain consent screens and user approval.
95. What is authorization code exchange?
96. Explain token endpoint and token request.
97. What is client credentials in OAuth?
98. Explain service-to-service authentication.
99. What is JWT token claims?
100. Explain standard JWT claims: iss, sub, aud, exp, iat.

---

## 🚀 Advanced (50+ Questions)

101. What is JWT token signing algorithms?
102. Explain RS256 vs HS256 algorithms.
103. What is JWT token encryption (JWE)?
104. Explain encrypted JWT tokens.
105. What is stateless authentication architecture?
106. Explain stateless vs stateful authentication.
107. What is distributed authentication?
108. Explain authentication in microservices.
109. What is service-to-service authentication?
110. Explain mutual TLS (mTLS) authentication.
111. What is API gateway authentication?
112. Explain centralized authentication.
113. What is federated identity?
114. Explain identity federation protocols.
115. What is SAML 2.0 advanced features?
116. Explain SAML assertions and attributes.
117. What is WS-Federation?
118. Explain WS-Fed vs SAML.
119. What is OpenID Connect advanced features?
120. Explain OIDC userinfo endpoint.
121. What is OIDC discovery and metadata?
122. Explain OIDC dynamic client registration.
123. What is authentication delegation?
124. Explain authentication proxy patterns.
125. What is token-based session management?
126. Explain stateless session management.
127. What is session clustering?
128. Explain distributed session storage.
129. What is Redis session store?
130. Explain session replication strategies.
131. What is authentication token formats?
132. Explain opaque tokens vs JWT.
133. What is reference tokens?
134. Explain token lookup and validation.
135. What is authentication token lifecycle?
136. Explain token issuance, validation, revocation.
137. What is authentication audit logging?
138. Explain security event logging.
139. What is authentication anomaly detection?
140. Explain suspicious login detection.
141. What is geolocation-based authentication?
142. Explain IP-based authentication rules.
143. What is device fingerprinting?
144. Explain device recognition and trust.
145. What is adaptive authentication?
146. Explain risk-based authentication.
147. What is step-up authentication?
148. Explain contextual authentication.
149. What is authentication in serverless?
150. Explain Lambda authorizers.
151. What is authentication in GraphQL?
152. Explain GraphQL authentication middleware.
153. What is authentication in gRPC?
154. Explain gRPC authentication interceptors.
155. What is authentication token refresh strategies?
156. Explain automatic token renewal.
157. What is authentication token storage security?
158. Explain secure token storage best practices.
159. What is authentication in mobile apps?
160. Explain mobile app authentication patterns.
161. What is authentication in SPAs (Single Page Applications)?
162. Explain SPA authentication flow.
163. What is authentication in micro-frontends?
164. Explain cross-app authentication.
165. What is authentication token expiration strategies?
166. Explain short-lived vs long-lived tokens.
167. What is authentication token scoping?
168. Explain token scope limitation.
169. What is authentication in event-driven systems?
170. Explain event authentication.
171. What is authentication in API-first architecture?
172. Explain API authentication patterns.
173. What is authentication performance optimization?
174. Explain token caching strategies.
175. What is authentication security hardening?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*
