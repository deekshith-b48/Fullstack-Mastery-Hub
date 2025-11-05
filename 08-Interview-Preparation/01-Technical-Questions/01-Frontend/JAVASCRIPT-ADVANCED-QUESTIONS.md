# JavaScript Advanced Interview Questions

**150+ Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is the JavaScript execution context?
2. Explain global execution context vs function execution context.
3. What is the creation phase vs execution phase?
4. Explain variable environment vs lexical environment.
5. What is scope chain in JavaScript?
6. Explain lexical scoping vs dynamic scoping.
7. What is closure and how does it work?
8. Explain closure with loops problem and solutions.
9. What is IIFE (Immediately Invoked Function Expression)?
10. Explain module pattern using IIFE.
11. What is the difference between function declaration and function expression?
12. Explain hoisting with function declarations vs expressions.
13. What is `arguments` object in functions?
14. Explain arrow functions and `this` binding.
15. What is the difference between arrow functions and regular functions regarding `this`?
16. Explain `call()`, `apply()`, and `bind()` methods.
17. What is method borrowing in JavaScript?
18. Explain `Function.prototype.call()` implementation.
19. What is currying in JavaScript?
20. Explain partial application vs currying.
21. What is function composition?
22. Explain higher-order functions.
23. What are pure functions and side effects?
24. Explain immutability in JavaScript.
25. What is the difference between mutable and immutable data?
26. Explain `Object.freeze()` and deep freezing.
27. What is `Object.assign()` and its limitations?
28. Explain spread operator for object copying.
29. What is shallow copy vs deep copy?
30. Explain methods to create deep copies.
31. What is `JSON.parse(JSON.stringify())` and its limitations?
32. Explain `structuredClone()` method.
33. What is debouncing and its use cases?
34. Explain throttling and when to use it.
35. What is the difference between debouncing and throttling?
36. Explain memoization in JavaScript.
37. What is `useMemo` and `useCallback` in React?
38. Explain recursion in JavaScript.
39. What is tail recursion and tail call optimization?
40. Explain factorial function with recursion.
41. What is Fibonacci sequence with recursion vs iteration?
42. Explain common recursion patterns.
43. What is the difference between `null` and `undefined`?
44. Explain type coercion in JavaScript.
45. What is explicit vs implicit type conversion?
46. Explain `Number()`, `String()`, `Boolean()` constructors.
47. What is `parseInt()` and `parseFloat()`?
48. Explain `toString()` and `valueOf()` methods.
49. What is `Symbol.toPrimitive` method?
50. Explain type checking: `typeof`, `instanceof`, `Object.prototype.toString()`.

---

## 🎯 Intermediate (50 Questions)

51. What is the JavaScript prototype chain?
52. Explain how prototype inheritance works.
53. What is the difference between `Object.create()` and `new` keyword?
54. Explain `Object.setPrototypeOf()` and `Object.getPrototypeOf()`.
55. What is the difference between `__proto__` and `prototype`?
56. Explain constructor property and its behavior.
57. What is `instanceof` operator and how does it work?
58. Explain `Object.prototype.hasOwnProperty()`.
59. What is `Object.keys()` vs `Object.getOwnPropertyNames()`?
60. Explain `Object.getOwnPropertySymbols()`.
61. What is `Object.defineProperty()` and property descriptors?
62. Explain property descriptors: `configurable`, `enumerable`, `writable`, `value`.
63. What are getter and setter descriptors?
64. Explain `Object.defineProperties()`.
65. What is `Object.preventExtensions()`, `Object.seal()`, `Object.freeze()`?
66. Explain the difference between `seal()` and `freeze()`.
67. What is `Object.is()` and its difference from `===`?
68. Explain `Object.assign()` and its shallow copy behavior.
69. What is `Object.entries()`, `Object.keys()`, `Object.values()`?
70. Explain `Object.fromEntries()` method.
71. What is JavaScript `Proxy` and how does it work?
72. Explain proxy traps: `get`, `set`, `has`, `deleteProperty`, `ownKeys`.
73. What is `Reflect` API and its relationship with `Proxy`?
74. Explain `Reflect.get()`, `Reflect.set()`, `Reflect.has()`.
75. What is `Reflect.construct()` and `Reflect.apply()`?
76. Explain proxy use cases: validation, logging, default values.
77. What is `Symbol` primitive type and its purpose?
78. Explain `Symbol()` vs `Symbol.for()`.
79. What are well-known symbols: `Symbol.iterator`, `Symbol.toPrimitive`, `Symbol.toStringTag`?
80. Explain `Symbol.hasInstance` and `Symbol.isConcatSpreadable`.
81. What is `Map` vs `Object` in JavaScript?
82. Explain `WeakMap` and when to use it.
83. What is `Set` vs `Array` for unique values?
84. Explain `WeakSet` and its use cases.
85. What is the difference between `Map`/`Set` and `WeakMap`/`WeakSet`?
86. Explain generator functions and `yield` keyword.
87. What is `yield*` in generator functions?
88. Explain generator function with `next()` method.
89. What is passing values to generators via `next()`?
90. Explain async generators and `for await...of`.
91. What are iterators and iterables in JavaScript?
92. Explain `Symbol.iterator` method.
93. What is the difference between iterable and iterator?
94. Explain custom iterators implementation.
95. What is `for...of` loop and how does it work with iterables?
96. Explain async iterators and `Symbol.asyncIterator`.
97. What is JavaScript module system: ES6 vs CommonJS?
98. Explain `export` and `import` syntax.
99. What is default export vs named export?
100. Explain dynamic imports with `import()`.

---

## 🚀 Advanced (50+ Questions)

101. What is the JavaScript event loop and how does it work?
102. Explain call stack, heap, and queue.
103. What is microtask queue vs macrotask queue?
104. Explain the execution order: sync code, promises, setTimeout.
105. What is `process.nextTick()` in Node.js?
106. Explain `queueMicrotask()` method.
107. What is `setImmediate()` in Node.js?
108. Explain `MessageChannel` and `postMessage()`.
109. What is JavaScript memory management and garbage collection?
110. Explain mark-and-sweep algorithm.
111. What is reference counting and its limitations?
112. Explain memory leaks in JavaScript.
113. What is `WeakMap` and `WeakSet` for memory management?
114. Explain Chrome DevTools memory profiling.
115. What is JavaScript performance optimization techniques?
116. Explain V8 engine optimization strategies.
117. What is hidden classes and inline caching?
118. Explain JIT (Just-In-Time) compilation.
119. What is JavaScript engine: V8, SpiderMonkey, Chakra?
120. Explain bytecode and machine code.
121. What is WebAssembly and its relationship with JavaScript?
122. Explain `SharedArrayBuffer` and `Atomics`.
123. What is JavaScript workers: Web Workers, Service Workers?
124. Explain `postMessage()` API for worker communication.
125. What is `Transferable` objects in workers?
126. Explain `BroadcastChannel` API.
127. What is `SharedWorker` and its use cases?
128. Explain Service Worker lifecycle and events.
129. What is Service Worker caching strategies?
130. Explain `Cache` API and `caches` object.
131. What is IndexedDB and how does it work?
132. Explain IndexedDB transactions and object stores.
133. What is `IDBRequest`, `IDBTransaction`, `IDBObjectStore`?
134. Explain IndexedDB vs localStorage.
135. What is `File` API and `FileReader` API?
136. Explain `Blob` and `ArrayBuffer` in JavaScript.
137. What is `Streams` API in JavaScript?
138. Explain `ReadableStream`, `WritableStream`, `TransformStream`.
139. What is `fetch()` API and `Response` object?
140. Explain `Request` object and its properties.
141. What is `Headers` API and `Headers` object?
142. Explain `AbortController` and request cancellation.
143. What is `FormData` API and file uploads?
144. Explain `URL` and `URLSearchParams` API.
145. What is `URL.createObjectURL()` and `URL.revokeObjectURL()`?
146. Explain `IntersectionObserver` API.
147. What is `MutationObserver` API?
148. Explain `ResizeObserver` API.
149. What is `PerformanceObserver` API?
150. Explain `Performance` API and timing methods.
151. What is `navigator` object and its properties?
152. Explain `geolocation` API.
153. What is `Notification` API?
154. Explain `Clipboard` API.
155. What is `MediaDevices` API and `getUserMedia()`?
156. Explain `Canvas` API and 2D rendering context.
157. What is `WebGL` and 3D graphics?
158. Explain `WebSocket` API and real-time communication.
159. What is `WebRTC` and peer-to-peer communication?
160. Explain `MediaRecorder` API.
161. What is `FileSystem` API (File System Access API)?
162. Explain `Page Visibility` API.
163. What is `Fullscreen` API?
164. Explain `Payment Request` API.
165. What is `Web Share` API?
166. Explain `Web Locks` API.
167. What is `Broadcast Channel` API?
168. Explain `Channel Messaging` API.
169. What is `Web Crypto` API?
170. Explain `TextEncoder` and `TextDecoder` APIs.
171. What is `Intl` API for internationalization?
172. Explain `Intl.DateTimeFormat`, `Intl.NumberFormat`, `Intl.Collator`.
173. What is `Intl.RelativeTimeFormat` and `Intl.PluralRules`?
174. Explain `Intl.ListFormat` and `Intl.DisplayNames`.
175. What is JavaScript metaprogramming and reflection?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*
