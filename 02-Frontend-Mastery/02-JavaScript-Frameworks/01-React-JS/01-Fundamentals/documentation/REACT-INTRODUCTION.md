# React Introduction - Complete Guide

## 📚 What is React?

React is a JavaScript library for building user interfaces, particularly web applications. It uses a component-based architecture and a virtual DOM for efficient rendering.

## 🚀 Getting Started

### Installation

```bash
# Create React app
npx create-react-app my-app
cd my-app
npm start

# Or with Vite (faster)
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

### First Component

```jsx
// App.js
import React from 'react';

function App() {
  return (
    <div className="App">
      <h1>Hello, React!</h1>
    </div>
  );
}

export default App;
```

## 🧩 Core Concepts

### JSX

```jsx
// JSX allows you to write HTML-like syntax in JavaScript
const element = <h1>Hello, World!</h1>;

// Embedding expressions
const name = "John";
const element = <h1>Hello, {name}!</h1>;

// Attributes
const element = <img src="image.jpg" alt="Description" />;
```

### Components

```jsx
// Function Component
function Welcome({ name }) {
  return <h1>Hello, {name}!</h1>;
}

// Arrow Function Component
const Welcome = ({ name }) => {
  return <h1>Hello, {name}!</h1>;
};

// Usage
<Welcome name="John" />
```

### Props

```jsx
function UserCard({ name, email, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{email}</p>
      <p>Age: {age}</p>
    </div>
  );
}

// Usage
<UserCard name="John" email="john@example.com" age={30} />
```

### State

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}
```

### Event Handling

```jsx
function Button() {
  const handleClick = (e) => {
    e.preventDefault();
    console.log('Clicked!');
  };
  
  return <button onClick={handleClick}>Click me</button>;
}
```

### Conditional Rendering

```jsx
function Greeting({ isLoggedIn }) {
  return (
    <div>
      {isLoggedIn ? (
        <h1>Welcome back!</h1>
      ) : (
        <h1>Please log in.</h1>
      )}
      
      {isLoggedIn && <Dashboard />}
    </div>
  );
}
```

### Lists

```jsx
function TodoList({ todos }) {
  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

## 📦 Project Structure

```
my-react-app/
├── public/
│   ├── index.html
│   └── favicon.ico
├── src/
│   ├── components/
│   │   ├── Button.js
│   │   └── Card.js
│   ├── pages/
│   │   ├── Home.js
│   │   └── About.js
│   ├── hooks/
│   │   └── useCustomHook.js
│   ├── utils/
│   │   └── helpers.js
│   ├── App.js
│   └── index.js
├── package.json
└── README.md
```

## ✅ Best Practices

1. Keep components small and focused
2. Use functional components with hooks
3. Extract reusable logic into custom hooks
4. Use meaningful component and prop names
5. Keep components pure when possible
6. Use keys properly in lists

---

**Next**: Learn about [JSX Syntax](./JSX-SYNTAX-MASTERY.md)

