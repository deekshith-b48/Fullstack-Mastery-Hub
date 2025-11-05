# Browser & Web APIs Interview Questions

**150+ Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is a web browser and how does it work?
2. Explain the main components of a browser.
3. What is the browser rendering engine?
4. Explain the difference between browser engines: Blink, Gecko, WebKit.
5. What is the Document Object Model (DOM)?
6. Explain how the DOM tree is constructed.
7. What is the difference between DOM and HTML?
8. Explain DOM manipulation methods.
9. What is `document.getElementById()` and `document.querySelector()`?
10. Explain `querySelectorAll()` vs `getElementsByClassName()`.
11. What is `document.createElement()` and `appendChild()`?
12. Explain DOM events and event handling.
13. What is `addEventListener()` and how does it work?
14. Explain event propagation: bubbling and capturing.
15. What is `event.preventDefault()` and `event.stopPropagation()`?
16. Explain common DOM events: click, submit, change, input.
17. What is the Window object and its properties?
18. Explain `window.location` and `window.history`.
19. What is `window.localStorage` and `window.sessionStorage`?
20. Explain the difference between localStorage and sessionStorage.
21. What is `window.alert()`, `window.confirm()`, `window.prompt()`?
22. Explain `window.open()` and `window.close()`.
23. What is `window.setTimeout()` and `window.setInterval()`?
24. Explain `clearTimeout()` and `clearInterval()`.
25. What is `window.requestAnimationFrame()`?
26. Explain the difference between `setTimeout` and `requestAnimationFrame`.
27. What is the Browser Object Model (BOM)?
28. Explain `navigator` object and its properties.
29. What is `screen` object and display information?
30. Explain `location` object and URL manipulation.
31. What is `history` object and browser navigation?
32. Explain `history.pushState()` and `history.replaceState()`.
33. What is the Fetch API and how does it work?
34. Explain `fetch()` vs `XMLHttpRequest`.
35. What is `fetch()` with `async/await`?
36. Explain `Response` object and its methods.
37. What is `Request` object and its properties?
38. Explain `Headers` API and `Headers` object.
39. What is CORS (Cross-Origin Resource Sharing)?
40. Explain same-origin policy.
41. What are CORS headers: `Access-Control-Allow-Origin`?
42. Explain preflight requests.
43. What is cookies and how do they work?
44. Explain `document.cookie` property.
45. What are cookie attributes: `expires`, `path`, `domain`, `secure`?
46. Explain `HttpOnly` and `SameSite` cookie attributes.
47. What is the difference between cookies and localStorage?
48. Explain when to use cookies vs localStorage.
49. What is the browser console and DevTools?
50. Explain basic debugging techniques.

---

## 🎯 Intermediate (50 Questions)

51. What is the browser event loop and how does it work?
52. Explain call stack, heap, and callback queue.
53. What is microtasks vs macrotasks?
54. Explain the execution order of JavaScript code.
55. What is `Promise` and microtask queue?
56. Explain `setTimeout` and macrotask queue.
57. What is `process.nextTick()` in Node.js vs browser?
58. Explain `queueMicrotask()` API.
59. What is `MessageChannel` and `postMessage()`?
60. Explain `setImmediate()` in Node.js.
61. What is Web Workers and how do they work?
62. Explain `Worker` API and worker threads.
63. What is `SharedWorker` and multiple tabs communication?
64. Explain `ServiceWorker` and its lifecycle.
65. What is Service Worker registration and installation?
66. Explain Service Worker activation and update.
67. What is Service Worker caching strategies?
68. Explain `Cache` API and `caches` object.
69. What is `IndexedDB` and how does it work?
70. Explain IndexedDB vs localStorage vs sessionStorage.
71. What is `IDBRequest`, `IDBTransaction`, `IDBObjectStore`?
72. Explain IndexedDB transactions and object stores.
73. What is `File` API and `FileReader` API?
74. Explain reading files in the browser.
75. What is `Blob` and `ArrayBuffer`?
76. Explain `URL.createObjectURL()` and `URL.revokeObjectURL()`.
77. What is `FormData` API and file uploads?
78. Explain `XMLHttpRequest` and file upload progress.
79. What is `fetch()` with FormData?
80. Explain drag and drop API.
81. What is `DragEvent` and drag events?
82. Explain `dataTransfer` object.
83. What is `Geolocation` API?
84. Explain `navigator.geolocation.getCurrentPosition()`.
85. What is `MediaDevices` API and `getUserMedia()`?
86. Explain accessing camera and microphone.
87. What is `MediaStream` and `MediaStreamTrack`?
88. Explain `Canvas` API and 2D rendering context.
89. What is `Canvas` drawing methods?
90. Explain `Canvas` image manipulation.
91. What is `WebGL` and 3D graphics?
92. Explain `WebGL` context and shaders.
93. What is `WebSocket` API and real-time communication?
94. Explain `WebSocket` connection lifecycle.
95. What is `WebSocket` events: `onopen`, `onmessage`, `onclose`?
96. Explain `WebSocket` vs HTTP polling.
97. What is `IntersectionObserver` API?
98. Explain lazy loading images with IntersectionObserver.
99. What is `MutationObserver` API?
100. Explain `ResizeObserver` API.

---

## 🚀 Advanced (50+ Questions)

101. What is `PerformanceObserver` API?
102. Explain Web Performance API.
103. What is `Performance` API and timing methods?
104. Explain `performance.now()`, `performance.mark()`, `performance.measure()`.
105. What is Navigation Timing API?
106. Explain Resource Timing API.
107. What is User Timing API?
108. Explain Paint Timing API.
109. What is `PerformanceEntry` and its types?
110. Explain performance monitoring and metrics.
111. What is `BroadcastChannel` API?
112. Explain cross-tab communication.
113. What is `Channel Messaging` API?
114. Explain `MessageChannel` and `MessagePort`.
115. What is `SharedArrayBuffer` and `Atomics`?
116. Explain shared memory and worker communication.
117. What is `WebAssembly` and its integration with JavaScript?
118. Explain WebAssembly compilation and execution.
119. What is `Web Crypto` API?
120. Explain cryptographic operations in the browser.
121. What is `SubtleCrypto` API?
122. Explain encryption, decryption, and hashing.
123. What is `TextEncoder` and `TextDecoder` APIs?
124. Explain text encoding and decoding.
125. What is `Intl` API for internationalization?
126. Explain `Intl.DateTimeFormat`, `Intl.NumberFormat`, `Intl.Collator`.
127. What is `Intl.RelativeTimeFormat` and `Intl.PluralRules`?
128. Explain `Intl.ListFormat` and `Intl.DisplayNames`.
129. What is `Intl.Locale` and locale negotiation?
130. Explain locale-aware formatting.
131. What is `Page Visibility` API?
132. Explain `document.visibilityState` and visibility events.
133. What is `Fullscreen` API?
134. Explain `requestFullscreen()` and `exitFullscreen()`.
135. What is `Payment Request` API?
136. Explain payment processing in browsers.
137. What is `Web Share` API?
138. Explain native sharing capabilities.
139. What is `Web Locks` API?
140. Explain resource locking and coordination.
141. What is `Clipboard` API?
142. Explain `navigator.clipboard.readText()` and `writeText()`.
143. What is `ClipboardItem` API?
144. Explain clipboard operations.
145. What is `MediaRecorder` API?
146. Explain recording audio and video.
147. What is `FileSystem` API (File System Access API)?
148. Explain file system access in browsers.
149. What is `FileSystemHandle` and `FileSystemFileHandle`?
150. Explain file and directory operations.
151. What is `Notification` API?
152. Explain browser notifications and permission.
153. What is `Push` API and push notifications?
154. Explain service worker push notifications.
155. What is `Background Sync` API?
156. Explain offline data synchronization.
157. What is `Background Fetch` API?
158. Explain large file downloads in background.
159. What is `WebRTC` and peer-to-peer communication?
160. Explain `RTCPeerConnection` API.
161. What is `RTCDataChannel` for data transfer?
162. Explain WebRTC signaling and ICE candidates.
163. What is `MediaStream` API and constraints?
164. Explain `getUserMedia()` constraints and tracks.
165. What is `MediaStreamTrack` API?
166. Explain track manipulation and effects.
167. What is `ImageCapture` API?
168. Explain camera capture and image processing.
169. What is `BarcodeDetector` API?
170. Explain barcode and QR code detection.
171. What is `WebCodecs` API?
172. Explain video and audio encoding/decoding.
173. What is `WebGPU` API?
174. Explain GPU computing in browsers.
175. What is browser security: CSP, CORS, SameSite cookies, HTTPS?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*
